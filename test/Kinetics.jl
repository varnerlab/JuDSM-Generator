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
#
# ----------------------------------------------------------------------------------- #
# Function: Kinetics
# Description: Calculate the flux array at time t
# Generated on: 2017-06-29T16:10:53.051
#
# Input arguments:
# t::Float64 => Current time value (scalar) 
# x::Array{Float64,1} => State array (number_of_species x 1) 
# data_dictionary::Dict{AbstractString,Any} => Dictionary holding model parameters 
#
# Output arguments:
# flux_array::Array{Float64,1} => Flux array (number_of_rates x 1) at time t 
# ----------------------------------------------------------------------------------- #
function Kinetics(t,x,volume,data_dictionary)

	# Get data from the data_dictionary - 
	rate_constant_array = data_dictionary["rate_constant_array"];
	saturation_constant_array = data_dictionary["saturation_constant_array"];

	# Alias the species array (helps with debuging) - 

	# Convex species alias - 
	convex_species_initial_condition_array = data_dictionary["convex_species_initial_condition_array"];

	# Write the kinetics functions - 
	kinetic_flux_array = Array{Float64}[];
return kinetic_flux_array

