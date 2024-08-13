import numpy as np
import pandas as pd
import sys
from functions import lyapunov, format_number

# Path to where the data will be stored. Make sure to create
# Data/ or modify the variable path accordingly
path = "Data"
# Get the input argument
gamma = float(sys.argv[1])
_ = lyapunov(1, 1, 15, 0.5, gamma, 10, 20)
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
num_k = 1000 # Number of samples in k
# Number of shrimp-shaped domains
num_shrimp = len(k_s)
# Initial condition
x = 1.78
p = 0.0
# Calculate the Lyapunov exponent around each shrimp-shaped domain
for i in range(1, num_shrimp):
    print(i)
    # Separation between two adjecent shrimp
    dk = k_s[i] - k_s[i - 1]
    # Limits in k
    k_ini = k_s[i] - dk/5
    k_end = k_s[i] + dk/5
    # Create an array with the values of k
    k = np.linspace(k_ini, k_end, num_k)
    # Calculate a according to the function a = a(k)
    a = sum(coeffs[i]*k**(order - i) for i in range(coeffs.shape[0]))    
    # Calculate the largest Lyapunov exponent
    lypnv = lyapunov(x, p, k, a, gamma, t_trans, t_end)
    # Write the data
    data = np.zeros((num_k, 3))
    data[:, 0] = a
    data[:, 1] = k
    data[:, 2] = lypnv
    df = "%s/lyapunov_vs_a(k)_gamma=%s_T=%i_t=%i_nk=%i_nshrimp=%i.dat" % (path, format_number(gamma, 5), t_end, t_trans, num_k, i)
    np.savetxt(df, data, delimiter=" ", newline="\n")
