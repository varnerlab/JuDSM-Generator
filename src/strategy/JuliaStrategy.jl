function build_function_header_buffer(comment_dictionary)

  # initialize -
  buffer = ""

  # get some data from the comment_dictionary -
  function_name = comment_dictionary["function_name"]
  function_description = comment_dictionary["function_description"]
  input_arg_array = comment_dictionary["input_args"]
  output_arg_array = comment_dictionary["output_args"]

  buffer *= "# ----------------------------------------------------------------------------------- #\n"
  buffer *= "# Function: $(function_name)\n"
  buffer *= "# Description: $(function_description)\n"
  buffer *= "# Generated on: $(now())\n"
  buffer *= "#\n"
  buffer *= "# Input arguments:\n"

  for argument_dictionary in input_arg_array

    arg_symbol = argument_dictionary["symbol"]
    arg_description = argument_dictionary["description"]

    # write the buffer -
    buffer *= "# $(arg_symbol) => $(arg_description) \n"
  end

  buffer *= "#\n"
  buffer *= "# Output arguments:\n"
  for argument_dictionary in output_arg_array

    arg_symbol = argument_dictionary["symbol"]
    arg_description = argument_dictionary["description"]

    # write the buffer -
    buffer *= "# $(arg_symbol) => $(arg_description) \n"
  end
  buffer *= "# ----------------------------------------------------------------------------------- #\n"

  # return the buffer -
  return buffer

end

function build_copyright_header_buffer(problem_object::ProblemObject)

  # What is the current year?
  current_year = string(Dates.year(now()))

  buffer = ""
  buffer*= "# ----------------------------------------------------------------------------------- #\n"
  buffer*= "# Copyright (c) $(current_year) Varnerlab\n"
  buffer*= "# Robert Frederick Smith School of Chemical and Biomolecular Engineering\n"
  buffer*= "# Cornell University, Ithaca NY 14850\n"
  buffer*= "#\n"
  buffer*= "# Permission is hereby granted, free of charge, to any person obtaining a copy\n"
  buffer*= "# of this software and associated documentation files (the \"Software\"), to deal\n"
  buffer*= "# in the Software without restriction, including without limitation the rights\n"
  buffer*= "# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell\n"
  buffer*= "# copies of the Software, and to permit persons to whom the Software is\n"
  buffer*= "# furnished to do so, subject to the following conditions:\n"
  buffer*= "#\n"
  buffer*= "# The above copyright notice and this permission notice shall be included in\n"
  buffer*= "# all copies or substantial portions of the Software.\n"
  buffer*= "#\n"
  buffer*= "# THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR\n"
  buffer*= "# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,\n"
  buffer*= "# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE\n"
  buffer*= "# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER\n"
  buffer*= "# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,\n"
  buffer*= "# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN\n"
  buffer*= "# THE SOFTWARE.\n"
  buffer*= "# ----------------------------------------------------------------------------------- #\n"

  # return -
  return buffer
end

function build_data_dictionary_buffer(problem_object::ProblemObject,solver_option::Symbol,reactor_option::Symbol)

  # What is my filename?
  filename = "DataDictionary.jl"

  # build the header -
  header_buffer = build_copyright_header_buffer(problem_object)

  # get the comment buffer -
  comment_header_dictionary = problem_object.configuration_dictionary["function_comment_dictionary"]["data_dictionary_function"]
  function_comment_buffer = build_function_header_buffer(comment_header_dictionary)

  # initialize the buffer -
  buffer = ""
  buffer *= header_buffer
  buffer *= "#\n"
  buffer *= function_comment_buffer
  buffer *= "function DataDictionary(time_start::Float64,time_stop::Float64,time_step::Float64)\n"
  buffer *= "\n"

  # Alias -
  buffer *="\t# Species list - \n"
  list_of_species::Array{SpeciesObject} = problem_object.list_of_species
  for (index,species_object::SpeciesObject) in enumerate(list_of_species)

    species_bound_type::Symbol = species_object.species_bound_type
    species_type::Symbol = species_object.species_type
    species_symbol = species_object.species_symbol

    buffer *= "\t# $(species_symbol) $(index)\n"
  end

  # Setup the flag -
  buffer *= "\n"
  buffer *= "\t# Is this min or max - \n"
  buffer *= "\tis_minimum_flag = false\n"

  buffer *="\n"
  buffer *= "\t# Load the complete stoichiometric_matrix - \n"
  buffer *= "\tstoichiometric_matrix = readdlm(\"./Network.dat\")\n"
  buffer *= "\n"

  # get the index of dyanmic species -
  counter::Int = 1
  buffer *="\t# Dyanmic species array -\n"
  buffer *="\tdynamic_species_index_array = [\n"
  for (index,species_object::SpeciesObject) in enumerate(list_of_species)

    # get species -
    species_bound_type::Symbol = species_object.species_bound_type
    species_type::Symbol = species_object.species_type
    species_symbol = species_object.species_symbol

    if (species_type == :metabolite && (species_bound_type == :free))

      buffer *="\t\t$(index)\t;\t# $(counter) $(species_symbol)\n"

      # update -
      counter = counter + 1

    end
  end
  buffer *="\t];\n"
  buffer *="\tfree_stoichiometric_array = stoichiometric_matrix[dynamic_species_index_array,:];\n"
  buffer *= "\n"

  counter = 1
  buffer *="\t# Measured species array -\n"
  buffer *="\tmeasured_species_index_array = [\n"
  for (index,species_object::SpeciesObject) in enumerate(list_of_species)

    # get species -
    species_bound_type::Symbol = species_object.species_bound_type
    species_type::Symbol = species_object.species_type
    species_symbol = species_object.species_symbol

    if (species_type == :metabolite && species_bound_type == :measured)

      buffer *="\t\t$(index)\t;\t# $(counter) $(species_symbol)\n"

      # update -
      counter = counter + 1

    end
  end
  buffer *="\t];\n"
  buffer *="\tmeasured_stoichiometric_array = stoichiometric_matrix[measured_species_index_array,:];\n"
  buffer *= "\n"
  buffer *="\t# Convex species array -\n"
  counter = 1
  buffer *="\tconvex_species_index_array = [\n"
  for (index,species_object::SpeciesObject) in enumerate(list_of_species)

    # get species -
    species_bound_type::Symbol = species_object.species_bound_type
    species_type::Symbol = species_object.species_type
    species_symbol = species_object.species_symbol

    if (species_type == :metabolite && species_bound_type == :balanced)

      buffer *="\t\t$(index)\t;\t# $(counter) $(species_symbol)\n"

      # update -
      counter = counter + 1

    end
  end
  buffer *="\t];\n"
  buffer *="\tconvex_stoichiometric_array = stoichiometric_matrix[convex_species_index_array,:];\n"
  buffer *= "\n"

  # write the IC vector -
  counter = 1
  buffer *= "\t# Convex initial condition array - \n"
  buffer *="\tconvex_initial_condition_array = [\n"
  for (index,species_object::SpeciesObject) in enumerate(list_of_species)

    # get species -
    species_bound_type::Symbol = species_object.species_bound_type
    species_type::Symbol = species_object.species_type
    species_symbol = species_object.species_symbol

    if (species_type == :metabolite && species_bound_type == :balanced)

      buffer *="\t\t0.0\t;\t# $(counter) $(species_symbol)\n"

      # update -
      counter = counter + 1

    end
  end
  buffer *="\t];\n"
  buffer *= "\n"

  # setup pointers -


  # return block -
  buffer *= "\n"
  buffer *= "\t# =============================== DO NOT EDIT BELOW THIS LINE ============================== #\n"
  buffer *= "\tdata_dictionary = Dict{AbstractString,Any}()\n"
  buffer *= "\tdata_dictionary[\"stoichiometric_matrix\"] = stoichiometric_matrix\n"
  buffer *= "\tdata_dictionary[\"free_stoichiometric_array\"] = free_stoichiometric_array\n"
  buffer *= "\tdata_dictionary[\"measured_stoichiometric_array\"] = measured_stoichiometric_array\n"
  buffer *= "\tdata_dictionary[\"convex_stoichiometric_array\"] = convex_stoichiometric_array\n"
  buffer *= "\tdata_dictionary[\"convex_initial_condition_array\"] = convex_initial_condition_array\n"
  buffer *= "\n"
  buffer *= "\tdata_dictionary[\"is_minimum_flag\"] = is_minimum_flag\n"
  buffer *= "\t# =============================== DO NOT EDIT ABOVE THIS LINE ============================== #\n"
  buffer *= "\treturn data_dictionary\n"
  buffer *= "end\n"

  # build the component -
  program_component::ProgramComponent = ProgramComponent()
  program_component.filename = filename
  program_component.buffer = buffer

  # return -
  return (program_component)
end

function build_dilution_buffer(problem_object::ProblemObject,solver_option::Symbol,reactor_option::Symbol)

  # What is my filename?
  filename = "Dilution.jl"

  # build the header -
  header_buffer = build_copyright_header_buffer(problem_object)

  # get the comment buffer -
  comment_header_dictionary = problem_object.configuration_dictionary["function_comment_dictionary"]["dilution_function"]
  function_comment_buffer = build_function_header_buffer(comment_header_dictionary)

  # initialize the buffer -
  buffer = ""
  buffer *= header_buffer
  buffer *= "#\n"
  buffer *= function_comment_buffer
  buffer *= "function Dilution(t,metabolite_array,enzyme_array,volume,data_dictionary)\n"
  buffer *= "\n"
  buffer *= "return\n"

  # build the component -
  program_component::ProgramComponent = ProgramComponent()
  program_component.filename = filename
  program_component.buffer = buffer

  # return -
  return (program_component)
end

function build_control_buffer(problem_object::ProblemObject)

  filename = "Control.jl"

  # build the header -
  header_buffer = build_copyright_header_buffer(problem_object)

  # get the comment buffer -
  comment_header_dictionary = problem_object.configuration_dictionary["function_comment_dictionary"]["control_function"]
  function_comment_buffer = build_function_header_buffer(comment_header_dictionary)

  # Get list of control statements -
  list_of_control_statements::Array{VFFControlSentence} = problem_object.list_of_control_statements
  list_of_reactions::Array{ReactionObject} = problem_object.list_of_reactions

  # initialize the buffer -
  buffer = ""
  buffer *= header_buffer
  buffer *= "#\n"
  buffer *= function_comment_buffer

  buffer *= "function control_array = Control(t,x,rate_array,data_dictionary)\n"
  buffer *= "\n"
  buffer *= "\t# Initialize the control array - \n"
  buffer *= "\tcontrol_array = ones(length(rate_array),1);\n"
  buffer *= "\n"
  buffer *= "return\n"

  # build the component -
  program_component::ProgramComponent = ProgramComponent()
  program_component.filename = filename
  program_component.buffer = buffer

  # return -
  return (program_component)

end

function build_inputs_buffer(problem_object::ProblemObject)

  filename = "Inputs.jl"

  # build the header -
  header_buffer = build_copyright_header_buffer(problem_object)

  # get the comment buffer -
  comment_header_dictionary = problem_object.configuration_dictionary["function_comment_dictionary"]["input_function"]
  function_comment_buffer = build_function_header_buffer(comment_header_dictionary)

  # initialize the buffer -
  buffer = ""
  buffer *= header_buffer
  buffer *= "#\n"
  buffer *= function_comment_buffer
  buffer *= "function Inputs(t,x,data_dictionary)\n"
  buffer *= "\tinput_array = calculate_input_array(t,x,data_dictionary);\n"
  buffer *= "return\n"
  buffer *= "\n"
  buffer *= "function calculate_input_array(t,x,data_dictionary)\n"
  buffer *= "\n"
  buffer *= "\t# Default input array - \n"
  buffer *= "\tinput_array = zeros(length(x),1);\n"
  buffer *= "return\n"

  # build the component -
  program_component::ProgramComponent = ProgramComponent()
  program_component.filename = filename
  program_component.buffer = buffer

  # return -
  return (program_component)

end

function build_kinetics_buffer(problem_object::ProblemObject,solver_option::Symbol)

  filename = "Kinetics.jl"

  # build the header -
  header_buffer = build_copyright_header_buffer(problem_object)

  # get the comment buffer -
  comment_header_dictionary = problem_object.configuration_dictionary["function_comment_dictionary"]["kinetics_function"]
  function_comment_buffer = build_function_header_buffer(comment_header_dictionary)

  # initialize the buffer -
  buffer = ""
  buffer *= header_buffer
  buffer *= "#\n"
  buffer *= function_comment_buffer
  buffer *= "function Kinetics(t,x,enzyme_array,volume,data_dictionary)\n"
  buffer *= "\n"
  buffer *= "\t# Get data from the data_dictionary - \n"
  buffer *= "\trate_constant_array = data_dictionary[\"rate_constant_array\"];\n"
  buffer *= "\tsaturation_constant_array = data_dictionary[\"saturation_constant_array\"];\n"
  buffer *= "\n"
  buffer *= "\t# Alias the species array (helps with debuging) - \n"

  # Alias the species -
  counter::Int = 1;
  list_of_enzymes::Array{AbstractString} = AbstractString[]
  list_of_species::Array{SpeciesObject} = problem_object.list_of_species
  for (index,species_object::SpeciesObject) in enumerate(list_of_species)

    species_bound_type::Symbol = species_object.species_bound_type
    species_type::Symbol = species_object.species_type
    species_symbol = species_object.species_symbol

    if (species_type == :metabolite && species_bound_type == :free)
      buffer *= "\t$(species_symbol) = x[$(counter)];\n"
      counter = counter + 1
    end
  end

  for (index,species_object::SpeciesObject) in enumerate(list_of_species)

    species_bound_type::Symbol = species_object.species_bound_type
    species_type::Symbol = species_object.species_type
    species_symbol = species_object.species_symbol

    if (species_type == :enzyme)
      buffer *= "\t$(species_symbol) = x[$(counter)];\n"
      counter = counter + 1;
    end
  end

  for (index,species_object::SpeciesObject) in enumerate(list_of_species)

    species_bound_type::Symbol = species_object.species_bound_type
    species_type::Symbol = species_object.species_type
    species_symbol = species_object.species_symbol

    if (species_bound_type == :measured)
      buffer *= "\t$(species_symbol) = x[$(counter)];\n"
      counter = counter + 1;
    end
  end

  buffer *= "\n"
  buffer *= "\t# Convex species alias - \n"
  buffer *= "\tconvex_initial_condition_array = data_dictionary[\"convex_species_initial_condition_array\"];\n"
  counter = 1
  for (index,species_object) in enumerate(list_of_species)

    species_bound_type::Symbol = species_object.species_bound_type
    species_type::Symbol = species_object.species_type
    species_symbol = species_object.species_symbol

    if (species_type == :metabolite && species_bound_type == :balanced)
      buffer *= "\t$(species_symbol) = convex_initial_condition_array[$(counter)];\n"
      counter = counter + 1
    end
  end

  for (index,species_object) in enumerate(list_of_species)

    species_bound_type::Symbol = species_object.species_bound_type
    species_type::Symbol = species_object.species_type
    species_symbol = species_object.species_symbol

    if (species_type == :metabolite && species_bound_type == :unbalanced)
      buffer *= "\t$(species_symbol) = convex_initial_condition_array[$(counter)];\n"
      counter = counter + 1
    end
  end

  buffer *= "\n"
  buffer *= "\t# Write the kinetics functions - \n"
  buffer *= "\tkinetic_flux_array = Array{Float64}[];\n"
  buffer *= "\n"

  # extract the list of metabolic reactions -
  saturation_constant_counter = 1
  list_of_reactions::Array{ReactionObject} = problem_object.list_of_reactions
  list_of_metabolic_reactions::Array{ReactionObject} = extract_metabolic_reactions(list_of_reactions)
  counter = 1
  for (index,reaction_object::ReactionObject) in enumerate(list_of_metabolic_reactions)

    # formulate the comment -
    comment_string = build_reaction_comment_string(reaction_object)
    reaction_type::Symbol = reaction_object.reaction_type
    reaction_name::AbstractString = reaction_object.reaction_name
    enyzme_generation_flag = reaction_object.enyzme_generation_flag

    # ok, write the start -
    buffer *= "\t# $(index) $(comment_string)\n"

    if (enyzme_generation_flag == 0)
      buffer *= "\tflux = rate_constant_array[$(index)]"
    else

      # Cutoff _revrese -
      if (contains(reaction_name,"_reverse") == true)
        local_enzyme_name = reaction_name[1:end-8]
        buffer *= "\tflux = rate_constant_array[$(index)]*(E_$(local_enzyme_name))"
      else
        local_enzyme_name = reaction_name
        buffer *= "\tflux = rate_constant_array[$(index)]*(E_$(local_enzyme_name))"
      end
    end

    # ok, get the list of reactants -
    local_list_of_reactants::Array{SpeciesObject} = reaction_object.list_of_reactants
    for (index,species_object) in enumerate(local_list_of_reactants)

      species_symbol = species_object.species_symbol
      species_type = species_object.species_type
      buffer *= "*(($(species_symbol))/(saturation_constant_array[$(saturation_constant_counter)]+$(species_symbol)))"

      # update -
      saturation_constant_counter = saturation_constant_counter + 1
    end

    # closing ;
    buffer *=";"

    # push -
    buffer *= "\n"
    buffer *= "\tpush!(kinetic_flux_array,flux);\n"
    buffer *= "\n"

    counter = counter + 1
  end

  # extract the extract_enzyme_degradation_reactions -
  list_of_enzyme_degradation_reactions::Array{ReactionObject} = extract_enzyme_degradation_reactions(list_of_reactions)
  for (index,reaction_object::ReactionObject) in enumerate(list_of_enzyme_degradation_reactions)

    reaction_type::Symbol = reaction_object.reaction_type
    reaction_name::AbstractString = reaction_object.reaction_name

    # update the index -
    local_index = index + counter - 1

    # formulate the comment -
    comment_string = build_reaction_comment_string(reaction_object)

    # ok, write the start -
    buffer *= "\t# $(local_index) $(comment_string)\n"

    # ok, write the start -
    buffer *= "\tflux = rate_constant_array[$(local_index)]"

    # ok, get the list of reactants -
    local_list_of_reactants::Array{SpeciesObject} = reaction_object.list_of_reactants
    for (index,species_object) in enumerate(local_list_of_reactants)

      species_symbol = species_object.species_symbol
      species_type = species_object.species_type
      buffer *= "*($(species_symbol));"
    end

    # push -
    buffer *= "\n"
    buffer *= "\tkinetic_flux_array = [kinetic_flux_array ; flux];\n"
    buffer *= "\n"
  end

  # return -
  buffer *= "return kinetic_flux_array\n"
  buffer *= "\n"

  # Build the convex flux function -
  # steady_state_function_buffer = @include_function_julia "default_estimate_fluxes_glpk"
  # buffer *= steady_state_function_buffer

  # build the component -
  program_component::ProgramComponent = ProgramComponent()
  program_component.filename = filename
  program_component.buffer = buffer

  # return -
  return (program_component)
end

# ====== HELPER FUNCTIONS ================================================================================== #
function extract_enzyme_degradation_reactions(list_of_reactions::Array{ReactionObject})

  list_of_enzyme_degradation_reactions::Array{ReactionObject} = ReactionObject[]
  for (index,reaction_object::ReactionObject) in enumerate(list_of_reactions)

    # What is the reaction_type?
    reaction_type::Symbol = reaction_object.reaction_type

    # is this a metabolic_reaction?
    is_degradation_reaction::Bool = false
    if (reaction_type == :kinetic)

      # ok, we have a kinetic reaction - does it involve metabolites?
      list_of_reactants::Array{SpeciesObject} = reaction_object.list_of_reactants
      for species_object in list_of_reactants

        species_type::Symbol = species_object.species_type
        if (species_type == :enzyme)
          is_degradation_reaction = true
        end
      end

      if (is_degradation_reaction == true)
        push!(list_of_enzyme_degradation_reactions,reaction_object)
      end
    end
  end

  return list_of_enzyme_degradation_reactions
end

function extract_metabolic_reactions(list_of_reactions::Array{ReactionObject})

  list_of_metabolic_reactions::Array{ReactionObject} = ReactionObject[]
  for (index,reaction_object::ReactionObject) in enumerate(list_of_reactions)

    # What is the reaction_type?
    reaction_type::Symbol = reaction_object.reaction_type

    # @show reaction_object

    # is this a metabolic_reaction?
    is_metabolic_reaction::Bool = false
    if (reaction_type == :kinetic)

      # ok, we have a kinetic reaction - does it involve metabolites?
      list_of_reactants::Array{SpeciesObject} = reaction_object.list_of_reactants
      if (isempty(list_of_reactants) == true)
        is_metabolic_reaction = true
      else

        for species_object in list_of_reactants

          species_type::Symbol = species_object.species_type
          if (species_type == :metabolite)
            is_metabolic_reaction = true
          end
        end
      end # end empty check if -

      if (is_metabolic_reaction == true)
        push!(list_of_metabolic_reactions,reaction_object)
      end
    end
  end

  return list_of_metabolic_reactions
end

function is_enzyme_degradation_reaction(reaction_object::ReactionObject)

  # Get the list of reactants -
  list_of_reactants::Array{SpeciesObject,1} = reaction_object.list_of_reactants
  if (length(list_of_reactants) == 1 && list_of_reactants[1].species_type == :enzyme)
    return true
  end

  return false
end
