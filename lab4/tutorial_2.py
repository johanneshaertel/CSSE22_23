# SIMULATION DEFECTS.

import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import binom
from scipy.stats import norm
from scipy.special import expit

# Simulating defects Y.
np.random.seed(seed=233423)

X = norm.rvs(size=100, loc=0, scale=1)  # For example, this might be a feature that measures the complexity of code.

# Uncomment to explore the distribution of X.
# plt.hist(X)
# plt.show()

# The probability is influenced by the complexity of the code and by a base rate alpha.
# We have a simple function with alpha and beta.
alpha = -0.4
beta = 0.7
prob = expit(alpha + beta * X)  # This is the inverted logistic function used to produce a valid probability.

# Uncomment to explore the relation between X and prob.
# plt.scatter(X, prob)
# plt.xlabel("X")
# plt.ylabel("prob")
# plt.show()

# We now simulate our defects Y.
Y = binom.rvs(n=1, p=prob)

# Uncomment to explore the relation between X and defects.
plt.scatter(X, Y)
plt.xlabel("X")
plt.ylabel("Defect (yes/no)")
plt.show()

# END SIMULATION.

# Constructing a trivial classifier using a single feature x.
alphas = []
betas = []
ls = []

# Parameter 'tuning' (a basic grid search to fine best alpha and beta).
for alpha in np.arange(-1, 1, 0.1):
    for beta in np.arange(-1, 1, 0.1):
        # How likely is it that this prop produce our Y?
        prob = expit(alpha + beta * X)

        l = np.prod(binom.pmf(Y, n=1, p=prob))  # This may cause numerical problems.

        # Uncomment this for a numerically more stable computation.
        # l = np.sum(binom.logpmf(Y, n=1, p=prob))

        alphas.append(alpha)
        betas.append(beta)
        ls.append(l)

# Plot this relation between ps and ls to find the best parameter for p.
plt.scatter(x=alphas, y=betas, c=ls)
plt.xlabel("alpha")
plt.ylabel("beta")

# Find the best alpha and beta.
best_alpha = alphas[np.argmax(ls)]
best_beta = betas[np.argmax(ls)]

plt.scatter(best_alpha, best_beta, c='red', marker="x")

plt.show()


#  This is our logistic classifier function.

def classify(x):
    return expit(best_alpha + best_beta * x)


# Here are some examples using it with different features xs.
x = 0
print("for x=" + str(x) + " we predict a defect with " + str(round(classify(x), 2)) + " %.")

x = -2
print("for x=" + str(x) + " we predict a defect with " + str(round(classify(x), 2)) + " %.")

x = 5
print("for x=" + str(x) + " we predict a defect with " + str(round(classify(x), 2)) + " %.")
