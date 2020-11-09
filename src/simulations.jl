"""
Receiver array #1 position in the global frame. 
"""
rx1pos = [0., 0., 0.]

"""
Receiver array #2 position in the global frame. 
"""
rx2pos = [20., -150., -3.]

"""
Sensor position of receiver array #1 in the global frame.
"""
srx1pos = rx1pos .+ [0.5002 1.0004 0.0000 0.5002
                     0.8663 0.0000 0.0000 0.28877
                     0.0000 0.0000 0.0000 0.8170]

                     """
Sensor position of receiver array #2 in the global frame.
"""
srx2pos = rx2pos .+ [0.5002 1.0004 0.0000 0.5002
                     0.8663 0.0000 0.0000 0.28877
                     0.0000 0.0000 0.0000 0.8170]
          
"""
Transmitter position in the global frame at t=0
"""
#txpos0 = [100, -200, 5]

"""
Horizontal velocity vector.
"""
v = reshape([0.0 0.5 0.], 3, 1)

"""
Transmitter path given a 3D velocity vector.
"""
getpath(txpos0, v, t::AbstractMatrix) = txpos0 .+ v * t
getpath(txpos0, v, t) = getpath(txpos0, v, reshape(collect(t), 1, :))

"""
Rotation matrix.

α=roll
β=pitch
ψ=yawn
"""
rotation(α, β, ψ) = [cos(α)cos(β) cos(α)sin(β)sin(ψ)-sin(α)cos(ψ) cos(α)sin(β)cos(ψ)+sin(α)sin(ψ)
                     sin(α)cos(β) sin(α)sin(β)sin(ψ)+cos(α)cos(ψ) sin(α)sin(β)cos(ψ)-cos(α)sin(ψ)
                     -sin(β)      cos(β)sin(ψ)                    cos(β)cos(ψ)]
rotation(angles::AbstractVector) = iszero(angles) ? I : rotation(angles[1], angles[2], angles[3])

"""
Get Direction of Arrivals (DoAs).
"""
function getdoa(txpos::AbstractVector, rxpos::AbstractVector, rotateangles::AbstractVector=[0,0,0])
    p⃗true = txpos - rxpos
    R = rotation(rotateangles)
    p⃗measure = inv(R) * p⃗true 
    û = p⃗measure ./ norm(p⃗measure)
    θ = asin(û[3])
    ϕ = asin(û[2] / cos(θ))
    ϕ, θ
end

"""
Get propagating vector.
"""
getpropagateunitvector(ϕ, θ) = reshape([cos(ϕ)cos(θ), sin(ϕ)cos(θ), sin(θ)], 3, 1)
getpropagateunitvector(angles::Tuple) = getpropagateunitvector(angles[1], angles[2])

"""
Simulation the estimated source position.
"""
function simulate(;txpos, 
                  rx1angles=[0, 0, 0], 
                  rx2angles=[0, 0, 0],
                  σ=0.)
    # rotateangles = [5, -10, 3]
    # σ = 0.1

    # t = 0
    # txposs = getpath(txpos0, v, t)

    compassrx1 = rx1angles .+ [rand(Normal(0, σ)), rand(Normal(0, σ)), rand(Normal(0, σ))]
    # truedoarx1 = getdoa(txpos, rx1pos)
    measuredoarx1 = getdoa(txpos, rx1pos, deg2rad.(rx1angles))
    u1 = rotation(deg2rad.(compassrx1)) * getpropagateunitvector(measuredoarx1)

    compassrx2 = rx2angles .+ [rand(Normal(0, σ)), rand(Normal(0, σ)), rand(Normal(0, σ))]
    # truedoarx2 = getdoa(txpos, rx2pos)
    measuredoarx2 = getdoa(txpos, rx2pos, deg2rad.(rx2angles))
    u2 = rotation(deg2rad.(compassrx2)) * getpropagateunitvector(measuredoarx2)

    sourcepos = localize(rx1pos, rx2pos, u1, u2)
#    rms(txpos - sourcepos)
end
