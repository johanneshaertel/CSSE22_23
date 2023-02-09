# SIMULATION DEFECTS.

import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import binom

# Simulating defects Y.
np.random.seed(seed=233423)
Y = binom.rvs(n=1, p=0.4, size=10)

# END SIMULATION.
# Constructing a trivial classifier without using any features.
ps = []
ls = []

# Parameter 'tuning' (a basic grid search to fine best p).
for p in np.arange(0, 1, 0.01):
    # How likely is it that this prob p produce our Y?
    l = np.prod(binom.pmf(Y, n=1, p=p))

    ps.append(p)
    ls.append(l)

# Plot this relation between ps and ls to find the best parameter for p.
plt.scatter(x=ps, y=ls)
plt.show()
