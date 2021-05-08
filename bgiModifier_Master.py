import urllib
import os
import fileinput
import csv
import matlab.engine
from shutil import copyfile
from ScriptModifier import ModifyWBScript
from bgiModifier_Diffuser import ModifyDiffuser
from bgiModifier_Impeller import ModifyImpeller

print("Starting MATLAB...")
eng = matlab.engine.start_matlab()

ResultNum = 1

# Note that these numbers must be floats (i.e. 60.0, not 60)
beta1 = -84.68
beta2 = -60.0
beta1Diff = 55.82
X1 = 18.0
X2 = 13.34

folderName = "Geom_" + str(ResultNum)
folderPath = "C:\\Users\\aashi\\Documents\\Uni\\Final year\\Final Year Project\\Automation\\" + folderName

try:
    os.mkdir(folderPath)
except OSError:
    print ("Creation of the directory %s failed" % folderPath)
    exit()
else:
    print ("Successfully created the directory %s " % folderPath)

print("Creating Impeller CSV files...")
thetaDMax = eng.ImpellerCSVGenerator(beta1, beta2, X1)
print("Max impeller theta is " + str(round(thetaDMax)))

print("\nCreating Diffuser CSV files...")
thetaDMax = eng.DiffuserCSVGenerator(beta1Diff, X1, X2)
print("Max diffuser theta is " + str(round(thetaDMax)))

print("\nGenerating Impeller File ...")
ModifyImpeller(folderPath)
print("Impeller file generated")

print("\nGenerating Diffuser File ...")
ModifyDiffuser(folderPath)
print("Diffuser file generated")

print("\nGenerating Workbench Script ...")
ModifyWBScript(X1, X2, ResultNum, folderPath)
print("Workbench Script generated")