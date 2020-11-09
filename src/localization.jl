function getpropagatevectors(rx1pos, rx2pos, u1, u2)
    U = [-u1 u2]
    a⃗ = rx1pos - rx2pos
    λ⃗ = inv(U'U) * U'a⃗
    λ⃗[1] * u1, λ⃗[2] * u2
end

function localize(rx1pos, rx2pos, u1, u2)
    v1, v2 = getpropagatevectors(rx1pos, rx2pos, u1, u2)
    rx1pos + v1
end