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
function Balances(time,state_array,enzyme_array,volume,data_dictionary)

  # Get data from the data dictionary -
  stoichiometric_matrix = data_dictionary["stoichiometric_matrix"]
  enzyme_degradation_array = data_dictionary["enzyme_degradation_array"]

  # what is the size of the state array?
  number_of_states = length(state_array)

  # calculate the fluxes, kinetic rates, dilution and inputs -
  kinetic_rate_array = Kinetics(time,state_array,enzyme_array,volume,data_dictionary)
  (dilution_array,total_volumetric_flow_rate) = Dilution(time,state_array,enzyme_array,volume,data_dictionary)
  input_array = Inputs(time,state_array,enzyme_array,volume,data_dictionary)

  # Calculate the fluxes for the LP subproblem -
  (metabolic_flux_array,error_flag) = Fluxes(time,state_array,enzyme_array,volume,data_dictionary)

  # build the rate_array -
  rate_array = [metabolic_flux_array ; kinetic_rate_array]

  # calculate the metabolite derivative_vector -
  metabolite_derivative_vector = stoichiometric_matrix*rate_array+dilution_array+input_array

  # calculate the enzyme derivative vector -
  enzyme_derivative_vector = enzyme_degradation_array*enzyme_array+dilution_array+input_array

  # calculate the volume derivative -
  volume_derivative = total_volumetric_flow_rate

# return the dxdt, fluxes and the error_flag -
return (metabolite_derivative_vector,enzyme_derivative_vector,volume_derivative,metabolic_flux_array,error_flag)
