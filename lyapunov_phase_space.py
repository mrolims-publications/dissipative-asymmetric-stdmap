import numpy as np
import pandas as pd
import sys
from functions import lyapunov

# Dissipation parameter 
gamma = 0.80 # Dissipation parameter
# Path to where the data will be stored. Make sure to create
# Data/ or modify the variable path accordingly
path = "Data"
# Get the input argument
idntf = sys.argv[1]
# Extract the coefficients of the function a = a(k)
df = pd.read_csv("%s/coeffs.csv" % path)
coeffs = np.array(df["gamma=%.2f" % gamma])
order = int(np.array(df["Order"])[-1])
# Parameters of the simulation
t_trans = int(5e4) # Transient time
t_end = int(1e5) # Total iteration time
k = 158.4 # Nonlinearity parameter
a = sum(coeffs[i]*k**(order - i) for i in range(coeffs.shape[0])) # Asymmetry parameter
grid = 1000 # Grid size
# 
if idntf == "6a":
    x_ini = 0
    x_end = 2 * np.pi
    y_ini = 0
    y_end = 200
    df = "%s/lyapunov_phase_space_k=%.5f_a=%.5f_gamma=%.2f.dat" % (path, k, a, gamma)
elif idntf == "6b":
    x_ini = 0.5
    x_end = 2.7
    y_ini = 135
    y_end = 200
    df = "%s/lyapunov_phase_space_k=%.5f_a=%.5f_gamma=%.2f_zoom.dat" % (path, k, a, gamma)
else:
    print("Invalid idntf")
    sys.exit()

# Create the grid in phase space
x = np.linspace(x_ini, x_end, grid)
y = np.linspace(y_ini, y_end, grid)
x, y = np.meshgrid(x, y)
# Calculate the Lyapunov exponent
lypnv = lyapunov(x, y, k, a, gamma, t_trans, t_end)
# Write the data
with open(df, "w") as df:
    for i in range(grid):
        for j in range(grid):
            df.write("%.16f %.16f %.16f\n" % (x[i, j], y[i, j], lypnv[i, j]))
        df.write("\n")