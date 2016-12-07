% ----------------------------------------------------------------------------------- %
% Copyright (c) 2016 Varnerlab
% Robert Frederick Smith School of Chemical and Biomolecular Engineering
% Cornell University, Ithaca NY 14850
%
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
%
% The above copyright notice and this permission notice shall be included in
% all copies or substantial portions of the Software.
%
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
% THE SOFTWARE.
% ----------------------------------------------------------------------------------- %
%
% ----------------------------------------------------------------------------------- %
% Function: solve
% Description: Solves the model equations from time_start to time_stop
% Generated on: 2016-09-18T14:27:51
%
% Input arguments:
% time_start::Float64 => Simulation start time value (scalar)
% time_stop::Float64 => Simulation stop time value (scalar)
% time_step::Float64 => Simulation time step (scalar)
%
% Output arguments:
% time_array::Array{Float64,1} => simulation time array (number_of_timesteps x 1)
% state_array::Array{Float64,2} => state array (number_of_timesteps x number_of_species)
% flux_array::Array{Float64,2} => array of model fluxes (number_of_timesteps x number_of_fluxes)
% ----------------------------------------------------------------------------------- %
function [simulation_time_array,state_archive,flux_archive,volume_archive] = Solve(time_start,time_stop,time_step,data_dictionary)

  % Setup time scale -
  simulation_time_array = time_start:time_step:time_stop;
  number_of_timesteps = length(simulation_time_array);
  data_dictionary.time_step_size = time_step;

  % Initialize -
  initial_condition_array = data_dictionary.initial_condition_array;
  STM = data_dictionary.stoichiometric_matrix;

  % Split the experimental_data_array -
  experimental_data_array = data_dictionary.experimental_data_array;
  experimental_time_array = experimental_data_array(:,1);
  experimental_state_array = experimental_data_array(:,2:end);

  % Augment the initial_condition_array w/the measured species -
  initial_condition_array = [initial_condition_array ; transpose(experimental_state_array(1,:))];

  % Get the *free* and *measured* species - these will be updated, the rest will stay at the IC -
  index_vector_measured_species = data_dictionary.index_vector_measured_species;
	index_vector_free_species = data_dictionary.index_vector_free_species;

  % Partition the stoichiometric_matrix -
  dynamic_species_index_vector = [index_vector_free_species ; index_vector_measured_species];
  stoichiometric_matrix =  STM(dynamic_species_index_vector,:);

  % Get the system dimension -
  [total_number_of_states,total_number_of_fluxes] = size(stoichiometric_matrix);
  state_archive = zeros(number_of_timesteps+1,total_number_of_states);
  flux_archive = zeros(number_of_timesteps+1,total_number_of_fluxes);

  % Get volume, and flow rate array -
  initial_volume = data_dictionary.initial_volume;
  volumetric_flow_array = data_dictionary.volumetric_flowrate_array;

  % initialize the volume array -
  volume_archive = zeros(number_of_timesteps+1,1);
  volume_archive(1,1) = initial_volume;

  % update the state_cache -
  update_archive(state_archive,initial_condition_array,1);

  % Compute the initial flux and update the flux_archive -
  initial_flux_array = Kinetics(0.0,initial_condition_array,data_dictionary);
  update_archive(flux_archive,initial_flux_array,1);

  % Main simulation loop -
  for time_step_index = 1:number_of_timesteps

    % get the time value -
    time_value = simulation_time_array(time_step_index)

    % current state -
    current_state_array = state_archive(time_step_index,:);

    % compute the kinetics -
    flux_array = Kinetics(time_value,current_state_array,data_dictionary);

    % compute the dilution terms -
    dilution_array = Dilution(time_value,time_step_index,current_state_array,volume,data_dictionary);

    % update the state -
    next_state_array = current_state_array + time_step*(STM*flux_array+dilution_array);

    % update the state_archive -
    update_archive(state_archive,next_state_array,time_step_index+1);

    % Update the flux archive -
    update_archive(flux_archive,flux_array,time_step_index+1);

    % Update the volume archive -
    next_volume = volume + time_step*volumetric_flow_array(time_step_index);
    volume_archive(time_step_index+1,1) = next_volume;
    volume = next_volume;
  end

% return -
return

function new_state_archive = update_archive(state_archive,state_array,row_index_value)

  % Get the size of the state array -
  [number_of_rows,number_of_cols] = size(state_archive);

  % Initialize the new_state_archive -
  new_state_archive = state_archive;

  % update the new archive -
  for col_index = 1:number_of_cols
    new_state_archive(row_index_value,col_index) = state_array(col_index);
  end

return
