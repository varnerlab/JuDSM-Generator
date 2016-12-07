% Driver file for metabolic model -

% Setup the time scale -
time_start = 0.0;
time_step = 1.0;
time_stop = 120.0;

% Load the data dictionary -
data_dictionary = DataDictionary(time_start,time_stop,time_step);

% Solve the model -
[simulation_time_array,state_archive,flux_archive,volume_archive] = Solve(time_start,time_stop,time_step,data_dictionary);
