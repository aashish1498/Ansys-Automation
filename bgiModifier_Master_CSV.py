import urllib
import os
import fileinput
import csv
import matlab.engine
from shutil import copyfile
from ScriptModifier import ModifyWBScript
from bgiModifier_Diffuser import ModifyDiffuser
from bgiModifier_Impeller import ModifyImpeller
class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

print(bcolors.OKBLUE + "Starting MATLAB..." + bcolors.ENDC)
eng = matlab.engine.start_matlab()

csvFilepath = "C:\\Users\\aashi\\Documents\\Uni\\Final year\\Final Year Project\\Automation\\DOEParameters.csv"
row_count = 0

# Find number of rows
with open(csvFilepath, encoding='utf-8-sig') as csvfile:
    datareader = csv.reader(csvfile, delimiter=',', quotechar='|')
    row_count = sum(1 for row in datareader)
    print(bcolors.OKCYAN + "There are " + str(row_count) + " rows" + bcolors.ENDC)

count = 0
beta1 = [0.0] * row_count
beta2 = [0.0] * row_count
beta1Diff =[0.0] * row_count
X1 = [0.0] * row_count
X2 = [0.0] * row_count
# Open CSV and read rows into variable arrays
with open(csvFilepath, encoding='utf-8-sig') as csvfile:
    datareader = csv.reader(csvfile, delimiter=',', quotechar='|')
    for row in datareader:
        inletImp = float(str(row[0]))
        outletImp = float(str(row[1]))
        inletDiff = float(str(row[2]))
        X1[count] = float(str(row[3]))
        X2[count] = float(str(row[4]))
        beta1[count] = -(90 - inletImp)
        beta2[count] = -(90 - outletImp)
        beta1Diff[count] = 90 - inletDiff
        count+=1

for index in range(row_count):
    ResultNum = index + 1
    print(bcolors.OKCYAN + "Computing row " + str(ResultNum) + " of " +str(row_count) + bcolors.ENDC)
    folderName = "Geom_" + str(ResultNum)
    folderPath = "C:\\Users\\aashi\\Documents\\Uni\\Final year\\Final Year Project\\Automation\\Geometries\\" + folderName

    try:
        os.mkdir(folderPath)
    except OSError:
        print (bcolors.FAIL + "Creation of the directory %s failed" % folderPath + bcolors.ENDC)
        exit()

    thetaDMax = eng.ImpellerCSVGenerator(beta1[index], beta2[index], X1[index])
    thetaDMax = eng.DiffuserCSVGenerator(beta1Diff[index], X1[index], X2[index])
    print("CSV files generated")
    ModifyImpeller(folderPath)
    ModifyDiffuser(folderPath)
    print("Bladegen files generated")
    ModifyWBScript(X1[index], X2[index], ResultNum, folderPath)
    print("Workbench Script generated")
