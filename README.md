# MultiarraySourceLocalization

This package implements methods and simulations for practical source localization using multiple arrays.

## Usage
```juilia
using Plots, MultiarraySourceLocalization

txpos = [100, -100, 5]
rotateangles = [5, -10, -3]
σ = 0.1
esttxpos = simulate(txpos=txpos, rotateangles=rotateangles, σ=σ)
plotconfig(rx1pos, rx2pos, txpos, esttxpos)
```
![window](images/config.png)
```julia
nrealizations = 1000
esttxposs = hcat([esttxpostmp = simulate(txpos=txpos, rotateangles=rotateangles, σ=σ) 
                  for i in 1:nrealizations]...)
rmses = rms(txpos .- esttxposs; dims=1)
histogram(rmses; xlabel="RMSE (m)")
```
![window](images/rmse.png)