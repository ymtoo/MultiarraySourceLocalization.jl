# MultiarraySourceLocalization

This package implements methods and simulations for practical source localization using multiple arrays.

## Usage
```juilia
using Plots, MultiarraySourceLocalization

txpos = [100, -100, 5]
rx1angles = [5, -10, -3]
rx2angles = [8, 6, 0.2]
σ = 0.1
esttxpos = simulate(txpos=txpos, rx1angles=rx1angles, rx2angles=rx2angles, σ=σ)
plotconfig(rx1pos, rx2pos, txpos, esttxpos)
```
![window](images/config.png)
```julia
nrealizations = 1000
esttxposs = hcat([esttxpostmp = simulate(txpos=txpos, rx1angles=rx1angles, 
                  rx2angles=rx2angles, σ=σ) for i in 1:nrealizations]...)
rmses = rms(txpos .- esttxposs; dims=1)
histogram(rmses; xlabel="RMSE (m)")
```
![window](images/rmse.png)
```julia
xtxposs = 50:10:200
ytxposs = -350:10:200
ztxposs = -5:1:5
μ = zeros(length(xtxposs), length(ytxposs), length(ztxposs))
for (i, xtxpos) in enumerate(xtxposs)
    for (j, ytxpos) in enumerate(ytxposs)
        for (k, ztxpos) in enumerate(ztxposs)
            txpostmp = [xtxpos,ytxpos,ztxpos]
            esttxposs = hcat([esttxpostmp = simulate(txpos=txpostmp, rx1angles=rx1angles, 
                  rx2angles=rx2angles, σ=σ) for i in 1:nrealizations]...)
            μ[i,j,k] = sum(rms(txpostmp .- esttxposs; dims=1)) / nrealizations
        end
    end
end
heatmap(xtxposs,ytxposs, μ[:,:,6]; xlabel="x (m)", ylabel="y (m)")
```
![window](images/rmse-map.png)