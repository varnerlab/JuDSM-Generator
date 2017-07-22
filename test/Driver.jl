# Script to solve dynamic cell free constraint based problem -
include("Include.jl")

# setup the time scale -
time_start = 0.0
time_stop = 12.0
time_step = 0.1

# load the data dictionary -
data_dictionary = DataDictionary(time_start,time_stop,time_step)

# get my initial conditon arrays -
metabolite_initial_condition_array = data_dictionary["metabolite_initial_condition_array"]
enzyme_initial_condition_array = data_dictionary["enzyme_initial_condition_array"]
volume_initial_condition = data_dictionary["volume_initial_condition"]

# What is my balance pointer?
balance_function_pointer = Balances;

# call the solver -
(simulation_time_array,metabolic_state_archive,enzyme_state_archive,volume_archive,flux_archive,error_flag_archive) = Solver(balance_function_pointer,
  metabolite_initial_condition_array,
  enzyme_initial_condition_array,
  volume_initial_condition,
  time_start,
  time_stop,
  time_step,
  data_dictionary);
