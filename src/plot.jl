using .Plots

function plotvectors(rx1pos, rx2pos, v1, v2)
    x = [rx1pos[1],rx2pos[1]]
    y = [rx1pos[2],rx2pos[2]]
    z = [rx1pos[3],rx2pos[3]]
    u = [v1[1],v2[1]]
    v = [v1[2],v2[2]]
    w = [v1[3],v2[3]]
    quiver!(x, y, quiver=(u,v); xlabel="x (m)", ylabel="y (m)", color="red") # 3D not working
end

function plotconfig(rx1pos, rx2pos, txpos, esttxpos=nothing)
    x = [rx1pos[1],rx2pos[1]]
    y = [rx1pos[2],rx2pos[2]]
    z = [rx1pos[3],rx2pos[3]]
    scatter(x, y; color="blue", label="")
    if esttxpos !== nothing
        v1 = esttxpos - rx1pos
        v2 = esttxpos - rx2pos
        plotvectors(rx1pos, rx2pos, v1, v2)
        scatter!([esttxpos[1]], [esttxpos[2]]; color="black", m=[:x], label="estimate")
    end
    scatter!([txpos[1]], [txpos[2]]; color="black", label="true")
end
