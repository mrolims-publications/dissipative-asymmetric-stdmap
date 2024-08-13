import numpy as np
from functions import period_counter, format_number
import sys

# Path to where the data will be stored. Make sure to create
# Data/ or modify the variable path accordingly
path = "Data"
# Get the input arguments
gamma = float(sys.argv[1])
k_ini = float(sys.argv[2])
k_end = float(sys.argv[3])
a_ini = float(sys.argv[4])
a_end = float(sys.argv[5])
grid = int(sys.argv[6])
# Parameters of the simulation
t_trans = int(5e4) # Transient time
sample_size = int(1e4) # Number of samples
t_end = t_trans + sample_size # Total iteration time
# Set the initial conditions
x = 1.78
p = 0.0
# Create the grid in parameter space
k = np.linspace(k_ini, k_end, grid)
a = np.linspace(a_ini, a_end, grid)
k, a = np.meshgrid(k, a)
# Calculate the period in parameter space
periods = period_counter(x, p, k, a, gamma, t_trans, t_end)
# Write the data in df
df = "%s/period_k_vs_a_gamma=%s_k0=%s_k1=%s_a0=%s_a1=%s_T=%i_t=%i_grid=%i.dat" % (path, format_number(gamma, 5), format_number(k_ini, 5), format_number(k_end, 5), format_number(a_ini, 5), format_number(a_end, 5), t_end, t_trans, grid)
with open(df, "w") as df:
    for j in range(grid):
        for jj in range(grid):
            df.write("%.16f %.16f %i\n" % (a[j, jj], k[j, jj], periods[j, jj]))
        df.write("\n")