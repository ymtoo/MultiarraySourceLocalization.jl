DSP.rms(X::AbstractMatrix; dims::Integer=1) = vec(sqrt.(sum(abs2, X; dims=dims)))