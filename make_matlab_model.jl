using ArgParse
using JSON

include("./src/Types.jl")
include("./src/Macros.jl")
include("./src/Parser.jl")
include("./src/Problem.jl")
include("./src/strategy/MatlabStrategy.jl")
include("./src/strategy/OctaveStrategy.jl")
include("./src/Common.jl")

# Grab the required functions for code generation -
# const parser_function::Function = parse_vff_file

function parse_commandline()
    settings_object = ArgParseSettings()
    @add_arg_table settings_object begin
      "-o"
        help = "Directory where the Matlab model files will be written."
        arg_type = AbstractString
        default = "."

      "-m"
        help = "Path to the biochemical reaction file written in the vff format."
        arg_type = AbstractString
        required = true

      "-s"
        help = "Linear programming solver (Default: linprog)"
        arg_type = Symbol
        default = :linprog

      "-r"
        help = "Reactor configuration (B = Batch, F = Fedbatch, C = Continous)"
        arg_type = Symbol
        default = :F
    end

    # return a dictionary w/args -
    return parse_args(settings_object)
end


function main()

  # Build the arguement dictionary -
  parsed_args = parse_commandline()

  # Load the statement_vector -
  path_to_model_file = parsed_args["m"]
  metabolic_statement_vector::Array{VFFSentence} = parse_vff_metabolic_statements(path_to_model_file)
  control_statement_vector::Array{VFFControlSentence} = parse_vff_control_statements(path_to_model_file)
  measured_species_vector::Array{SpeciesObject} = parse_vff_measured_species_statements(path_to_model_file)
  free_species_vector::Array{SpeciesObject} = parse_vff_free_species_statements(path_to_model_file)

  # for (index,species_object) in enumerate(measured_species_vector)
  #
  #   @show species_object.species_symbol
  #
  # end


  # Generate the problem object -
  problem_object = generate_problem_object(metabolic_statement_vector,control_statement_vector,measured_species_vector,free_species_vector)

  # Load the JSON configuration file -
  config_dict = JSON.parsefile("./config/Configuration.json")
  problem_object.configuration_dictionary = config_dict

  # Write the DataDictionary -
  solver_type = parsed_args["s"]
  reactor_type = parsed_args["r"]
  component_set = Set{ProgramComponent}()
  program_component_data_dictionary = build_data_dictionary_buffer_matlab(problem_object,solver_type,reactor_type)
  push!(component_set,program_component_data_dictionary)

  # Write the dilution -
  program_component_dilution = build_dilution_buffer_matlab(problem_object,solver_type,reactor_type)
  push!(component_set,program_component_dilution)

  # Write the Kinetics -
  program_component_kinetics = build_kinetics_buffer_matlab(problem_object,solver_type)
  push!(component_set,program_component_kinetics)

  # Write the Inputs -
  # program_component_inputs = build_inputs_buffer_matlab(problem_object)
  # push!(component_set,program_component_inputs)

  # Write the Inputs -
  program_component_control = build_control_buffer_matlab(problem_object)
  push!(component_set,program_component_control)

  # Write the stoichiometric_matrix --
  program_component_stoichiometric_matrix = generate_stoichiomteric_matrix_buffer(problem_object)
  push!(component_set,program_component_stoichiometric_matrix)

  # Dump the component_set to disk -
  path_to_output_file = parsed_args["o"]
  write_program_components_to_disk(path_to_output_file,component_set)

  # Transfer distrubtion files to the output -
  transfer_distribution_file("./distribution","DriverFedbatch.m",path_to_output_file,"Driver.m")
  transfer_distribution_file("./distribution","SolveFedbatch.m",path_to_output_file,"Solve.m")
  transfer_distribution_file("./distribution","README_MATLAB.md",path_to_output_file,"README.md")
end

main()
