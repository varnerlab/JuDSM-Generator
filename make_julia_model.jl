using ArgParse
using JSON

include("./src/Types.jl")
include("./src/Macros.jl")
include("./src/Parser.jl")
include("./src/Problem.jl")
include("./src/strategy/JuliaStrategy.jl")
include("./src/Common.jl")

# Grab the required functions for code generation -
# const parser_function::Function = parse_vff_file

function parse_commandline()
    settings_object = ArgParseSettings()
    @add_arg_table settings_object begin
      "-o"
        help = "Directory where the Julia model files will be written."
        arg_type = AbstractString
        default = "."

      "-m"
        help = "Path to the biochemical reaction file written in the vff format."
        arg_type = AbstractString
        required = true

      "-s"
        help = "Linear programming solver (Default: glpk)"
        arg_type = Symbol
        default = :glpk

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
  measured_species_vector::Array{SpeciesObject} = parse_vff_measured_species_statements(path_to_model_file)
  free_species_vector::Array{SpeciesObject} = parse_vff_free_species_statements(path_to_model_file)

  @show free_species_vector

  # Generate the problem object -
  problem_object = generate_problem_object(metabolic_statement_vector,measured_species_vector,free_species_vector)

  # Load the JSON configuration file -
  config_dict = JSON.parsefile("./config/Configuration.json")
  problem_object.configuration_dictionary = config_dict

  # Write the DataDictionary -
  solver_type = parsed_args["s"]
  reactor_type = parsed_args["r"]
  component_set = Set{ProgramComponent}()

  # Write the data dictionary -
  program_component_data_dictionary = build_data_dictionary_buffer(problem_object,solver_type,reactor_type)
  push!(component_set,program_component_data_dictionary)

  # Write the dilution -
  program_component_dilution = build_dilution_buffer(problem_object,solver_type,reactor_type)
  push!(component_set,program_component_dilution)
  #
  # Write the Kinetics -
  program_component_kinetics = build_kinetics_buffer(problem_object,solver_type)
  push!(component_set,program_component_kinetics)

  # Write the Inputs -
  program_component_inputs = build_inputs_buffer(problem_object)
  push!(component_set,program_component_inputs)

  # Write the flux bound array pointer - \n

  # Write the Inputs -
  # program_component_control = build_control_buffer(problem_object)
  # push!(component_set,program_component_control)

  # Write the stoichiometric_matrix --
  program_component_stoichiometric_matrix = generate_stoichiomteric_matrix_buffer(problem_object)
  push!(component_set,program_component_stoichiometric_matrix)

  # Dump the component_set to disk -
  path_to_output_file = parsed_args["o"]
  write_program_components_to_disk(path_to_output_file,component_set)

  # Transfer distrubtion files to the output -
  transfer_distribution_file("./distribution","Driver.jl",path_to_output_file,"Driver.jl")
  transfer_distribution_file("./distribution","Fluxes.jl",path_to_output_file,"Fluxes.jl")
  transfer_distribution_file("./distribution","Balances.jl",path_to_output_file,"Balances.jl")
  transfer_distribution_file("./distribution","Solver.jl",path_to_output_file,"Solver.jl")
  transfer_distribution_file("./distribution","Include.jl",path_to_output_file,"Include.jl")
  transfer_distribution_file("./distribution","README_JULIA.md",path_to_output_file,"README.md")
end

main()
