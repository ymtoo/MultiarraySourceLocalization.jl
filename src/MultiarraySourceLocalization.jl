module MultiarraySourceLocalization

using Requires

using DSP
using Distributions
using LinearAlgebra

export 

    # utils
    rms,

    # simulations
    rx1pos,
    rx2pos,
    simulate,

    # plot
    plotvectors,
    plotconfig

include("utils.jl")
include("localization.jl")
include("simulations.jl")

function __init__()
    @require Plots="91a5bcdd-55d7-5caf-9e0b-520d859cae80" include("plot.jl")
end

end # module
