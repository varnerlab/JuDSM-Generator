# ----------------------------------------------------------------------------------- #
# Copyright (c) 2017 Varnerlab
# Robert Frederick Smith School of Chemical and Biomolecular Engineering
# Cornell University, Ithaca NY 14850
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
# ----------------------------------------------------------------------------------- #
function Solver(balance_function_pointer,
  initial_condition_array,
  initial_enzyme_array,
  initial_volume,
  time_start,
  time_stop,
  time_step,
  data_dictionary)

  # Setup time scale -
  simulation_time_array = collect(time_start:time_step:time_stop);
  number_of_timesteps = length(simulation_time_array);

  # what is my system size?
  number_of_metabolic_states = length(initial_condition_array)
  number_of_enzyme_states = length(initial_enzyme_array)

  # initialize the state, flux and error_flag_archive arrays -
  metabolic_state_archive = zeros(number_of_timesteps,number_of_metabolic_states)
  enzyme_state_archive = zeros(number_of_timesteps,number_of_enzyme_states)
  flux_archive = zeros(number_of_timesteps,1)
  error_flag_archive = Array{Int64}()
  volume_archive = Array{Float64}()

  # Main simulation loop -
  for time_step_index = 1:number_of_timesteps

    # get the time value -
    time_value = simulation_time_array(time_step_index);

    # current state -
    current_state_array = transpose(state_archive[time_step_index,:]);

    # calculate the balance equations -
    (metabolite_derivative_vector,enzyme_derivative_vector,volume_derivative,metabolic_flux_array,error_flag) = balance_function_pointer(time_value,current_state_array,data_dictionary)

    # update the metabolic state -
    next_state_array = current_state_array + time_step*(metabolite_derivative_vector);

    # update the enzyme state -
    next_enzyme_state_array = current_enzyme_state_array +time_step*(enzyme_derivative_vector);

    # update the system volume -
    next_volume = current_volume + time_step*(volume_derivative)

    # Check for negatives -
    idx_negative = find(next_state_array.<0);
    next_state_array[idx_negative] = 0.0;

    # update the state_archive (in place)-
    update_archive!(metabolic_state_archive,next_state_array,time_step_index+1);

    # Update the flux archive (in place) -
    update_archive!(flux_archive,flux_array,time_step_index+1);

    # Update the enzyme state archive -
    update_archive!(enzyme_state_archive,enzyme_array,time_step_index+1)

    # update the error flag archive -
    push!(error_flag_archive,error_flag)

    # update the volume archive -
    push!(volume_archive,next_volume)

    # message to the user -
    msg = ['Completed ',num2str(time_value),' min'];
    disp(msg);
  end

# return -
return (simulation_time_array,metabolic_state_archive,enzyme_state_archive,volume_archive,flux_archive,error_flag_archive)

function update_archive!(state_archive,state_array,row_index_value)

  # Get the size of the state array -
  (number_of_rows,number_of_col) = size(state_archive);

  # update the new archive -
  for col_index = 1:number_of_cols
    state_archive[row_index_value,col_index] = state_array[col_index];
  end

return
