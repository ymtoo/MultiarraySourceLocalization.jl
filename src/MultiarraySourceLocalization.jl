module MultiarraySourceLocalization

using DSP
using Distributions
using LinearAlgebra
using Plots

export simulate

include("localization.jl")
include("simulations.jl")

end # module
