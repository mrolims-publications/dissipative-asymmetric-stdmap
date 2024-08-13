import os
import sys
from functions import get_params

f90_file = sys.argv[0]
idntf = [sys.argv[1]]
grid = 1000

if idntf[0] == "ALL":
    idntf = ["1",
             "2a", "2b", "2c", "2d",
             "3a", "3b", "3c", "3d",
             "3amag", "3bmag", "3cmag", "3dmag"]

f90_file = f90_file[f90_file.find("lyap"):f90_file.find(".py")] + ".f90"
exe_file = "lkva.x"

print("Removing executable to avoid old file execution...")
comm = "rm -rf %s" % exe_file
print("\n\t$", comm)
os.system(comm)
print("\nSuccesfully removed %s.\nCompiling files..." % exe_file)
comm = "ifx functions.f90 %s -o %s -fopenmp" % (f90_file, exe_file)
print("\n\t$", comm)
os.system(comm)

if os.path.isfile(exe_file):
    print("\nCompilation succeeded. Executing files...\n")
else:
    print("\nCompilation failed. Aborting execution.")
    sys.exit()

for i in range(len(idntf)):
    gamma, limits = get_params(idntf[i])
    comm = "./%s %.16f %.16f %.16f %.16f %.16f %i" % (exe_file, gamma, limits[0], limits[1], limits[2], limits[3], grid)
    print("\t$", comm)
    #os.system(comm)