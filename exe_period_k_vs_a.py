import os
import sys
from functions import get_params

py_file = sys.argv[0]
py_file = py_file[py_file.find("period"):]
idntf = [sys.argv[1]]
grid = 1000

if idntf[0] == "ALL":
    idntf = ["1",
             "2a", "2b", "2c", "2d"]

for i in range(len(idntf)):
    gamma, limits = get_params(idntf[i])
    comm = "python %s %.16f %.16f %.16f %.16f %.16f %i" % (py_file, gamma, limits[0], limits[1], limits[2], limits[3], grid)
    print("\t$", comm)
    #os.system(comm)