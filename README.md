# dissipative-asymmetric-stdmap

Code repository accompanying the publication entitled "Shrinking shrimp-shaped domains and multistability in the dissipative asymmetric kicked rotor map".

This project contains the code to generate and plot the data from all figures. It has been developed by both [Michele Mugnaine](https://mmugnaine.github.io/) and [me](https://mrolims.github.io/).

## Requirements

The required Python packages are listed in ``` requirements.txt ```. To install them, please execute ``` pip install -r requirements.txt ```.

## Figure 1

To generate the data from Figure 1, run ``` python exe_lyapunov_k_vs_a.py 1 ``` and ``` python exe_period_k_vs_a.py 1 ```. To plot the figure, run all cells within the heading named ``` Fig. 1 ``` in the ``` Plots.ipynb ``` Jupyter notebook.

## Figure 2

To generate the data from Figure 2, run ``` python exe_lyapunov_k_vs_a.py arg ``` and ``` python exe_period_k_vs_a.py arg ``` with ``` arg = 2a ```, ``` arg = 2b ```, ``` arg = 2c ```, and ``` arg = 2d ```. To plot the figure, run all cells within the heading named ``` Fig. 2 ``` in the ``` Plots.ipynb ``` Jupyter notebook.

## Figure 3

To generate the data from Figure 2, run ``` python exe_lyapunov_k_vs_a.py arg ``` with ``` arg = 3a ```, ``` arg = 3b ```, ``` arg = 3c ```, ``` arg = 3d ```, ``` arg = 3amag ```, ``` arg = 3bmag ```, ``` arg = 3cmag ```, and ``` arg = 3dmag ```. To plot the figure, run all cells within the heading named ``` Fig. 3 ``` in the ``` Plots.ipynb ``` Jupyter notebook.

## Figure 4

To generate the Figure 4, run all cells within the heading named ``` Fig. 4 ``` in the ``` Plots.ipynb ``` Jupyter notebook.

## Figure 5

To generate the data from the left column of Figure 5, run ``` python lyapunov_along_function.py arg ``` with ``` arg = 0.80 ```, ``` arg = 0.85 ```, ``` arg = 0.90 ```, and ``` arg = 0.95 ```. Next, run ``` python lyapunov_along_function_around_shrimp.py arg ``` with ``` arg = 0.80 ```, ``` arg = 0.85 ```, ``` arg = 0.90 ```, and ``` arg = 0.95 ```. It calculates the largest Lyapunov exponent around each shrimp-shaped domain to have a finer resolution on where the domain begins and ends. To calculate the width and plot the figure, run all cells within the heading named ``` Fig. 5 ``` in the ``` Plots.ipynb ``` Jupyter notebook.

## Figure 6

To generate the data from Figure 6(a) and 6(b), run ``` python lyapunov_phase_space.py arg ``` with ``` arg = 6a ``` and ``` arg = 6b ```. Then, run all cells within the heading named ``` Fig. 6 ``` in the ``` Plots.ipynb ``` Jupyter notebook to generate the data from Figure 6(c) and plot the figure.

## Figure 7

To generate the data from Figure 7, run ``` gfortran Figure7.f90 ``` to compile the program and then run ``` ./a.out ``` to execute it. To plot the figure, run ``` gnuplot plot7.txt ```.

## Figure 8

To generate the data from Figure 8, run ``` gfortran Figure8.f90 ``` to compile the program and then run ``` ./a.out ``` to execute it. To plot the figure, run ``` gnuplot plot8.txt ```.

## Figure 9

To generate the data from Figure 9, run ``` gfortran Figure9.f90 ``` to compile the program and then run ``` ./a.out ``` to execute it. To plot the figure, run ``` gnuplot plot9.txt ```.

## Figure 10

To generate the data from Figure 10, run ``` gfortran Figure10.f90 ``` to compile the program and then run ``` ./a.out ``` to execute it. To plot the figure, run ``` gnuplot plot10.txt ```.

## Contact

Matheus Rolim Sales: [matheusrolim95[at]gmail.com](mailto:matheusrolim95@gmail.com)\
Michele Mugnaine: [mmugnaine[at]gmail.com](mailto:mmugnaine95@gmail.com)