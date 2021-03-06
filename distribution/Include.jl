# Generated code -
include("DataDictionary.jl")
include("Solver.jl")
include("Kinetics.jl")
include("Dilution.jl")
include("Inputs.jl")
include("Balances.jl")

# Julia packages -
using GLPK
using PyPlot
using JSON

# We use python interpolation -
using PyCall
@pyimport numpy as np
