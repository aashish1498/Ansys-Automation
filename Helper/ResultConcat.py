import urllib
import os
import fileinput
import csv

def find_missing(lst):
    return [x for x in range(lst[0], lst[-1]+1) 
                               if x not in lst]

MaxResultNum = 80
csvFolderPath = "C:\\Users\\aashi\\Documents\\Uni\\Final year\\Final Year Project\\Automation\\Results"
csvPressurePath = "C:\\Users\\aashi\\Documents\\Uni\\Final year\\Final Year Project\\Automation\\PressureIncrease.csv"
ResultsList = []
PressureHeadList = [-1.0] * MaxResultNum

for filename in os.listdir(csvFolderPath):
    ResultNum = int(filename.strip("Results_.csv"))
    ResultsList.append(ResultNum)
    csvFilepath = os.path.join(csvFolderPath, filename)
    with open(csvFilepath) as csvDataFile:
        data=list(csv.reader(csvDataFile))
        PressureHeadList[ResultNum-1] = (data[7][13])

with open(csvPressurePath, 'w', newline='') as f:
    writer = csv.writer(f)
    for i in range(MaxResultNum):
        writer.writerow([PressureHeadList[i]])

ResultsList.sort()

MissingResults = find_missing(ResultsList)

print("Missing numbers are:")
print(MissingResults)

