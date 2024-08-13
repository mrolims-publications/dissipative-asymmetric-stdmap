import numpy as np
import sys
import pandas as pd
from functions import lyapunov, format_number

# Path to where the data will be stored. Make sure to create
# Data/ or modify the variable path accordingly
path = "Data"
# Get the input argument
gamma = float(sys.argv[1])
# Extract the coefficients of the function a = a(k)
df = pd.read_csv("%s/coeffs.csv" % path)
coeffs = np.array(df["gamma=%.2f" % gamma])
order = int(np.array(df["Order"])[-1])
# Extract the values of a and k
df = pd.read_csv("%s/a_and_k_gamma=%.2f.csv" % (path, gamma))
a_s = np.array(df["a"])
k_s = np.array(df["k"])
# Parameters of the simulation
t_trans = int(5e4) # Transient time
t_end = int(1e5) # Total iteration time
num_k = 1000000 # Number of samples in k
k_ini = k_s.min()
k_end = k_s.max()
# Create an array with the values of k
k = np.linspace(k_ini, k_end, num_k)
# Calculate a according to the function a = a(k)
a = sum(coeffs[i]*k**(order - i) for i in range(coeffs.shape[0]))
# Initial condition
x = 1.78
p = 0.0
# Calculate the largest Lyapunov exponent
_ = lyapunov(x, p, 15, 0.5, gamma, 10, 20)
lypnv = lyapunov(x, p, k, a, gamma, t_trans, t_end)
# Write the data
data = np.zeros((num_k, 3))
data[:, 0] = a
data[:, 1] = k
data[:, 2] = lypnv
df = "%s/lyapunov_vs_a(k)_gamma=%s_T=%i_t=%i_nk=%i.dat" % (format_number(gamma, 5), t_end, t_trans, num_k)
np.savetxt(df, data, delimiter=" ", newline="\n")
