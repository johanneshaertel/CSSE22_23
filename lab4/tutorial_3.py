# SIMULATION DEFECTS.

import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import binom
from scipy.stats import norm
from scipy.special import expit

# Simulating defects Y.
np.random.seed(seed=233423)

X = norm.rvs(size=100, loc=0, scale=1)  # For example, this might be a feature that measures the complexity of code.

# The probability is influenced by the complexity of the code and by a base rate alpha.
# We have a simple function with alpha and beta.
alpha = -0.4
beta = 0.7
prob = expit(alpha + beta * X)  # This is the inverted logistic function used to produce a valid probability.
Y = binom.rvs(n=1, p=prob)

# END SIMULATION.

# Using logistic regression package in python.

from sklearn.linear_model import LogisticRegression

model = LogisticRegression().fit(X.reshape(-1, 1), Y)

# Print alpha (intercept) and beta (coef).
print(model.intercept_, model.coef_)

# Predict
def classify(x):
    return model.predict_proba([[x]])[0][1]

# Here are some examples using it with different features xs.
x = 0
print("for x=" + str(x) + " we predict a defect with " + str(round(classify(x), 2)) + " %.")

x = -2
print("for x=" + str(x) + " we predict a defect with " + str(round(classify(x), 2)) + " %.")

x = 5
print("for x=" + str(x) + " we predict a defect with " + str(round(classify(x), 2)) + " %.")

