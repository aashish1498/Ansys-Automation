import urllib
import os
import fileinput
import csv
from shutil import copyfile

def ModifyWBScript(X1, X2, ResultNum, folderPath):
  templatepath = "C:\\Users\\aashi\\Documents\\Uni\\Final year\\Final Year Project\\Automation\\Workflow_TEMPLATE.wbjn"
  filepath = folderPath + "\\Workflow.wbjn"  

  copyfile(templatepath, filepath)  

  # Read in the file
  with open(filepath, 'r') as file :
    filedata = file.read()  

  # Replace the target string
  filedata = filedata.replace("X1_DATA", str(X1))
  filedata = filedata.replace("X2_DATA", str(X2))
  filedata = filedata.replace("RESULT_NUMBER", str(ResultNum))  

  # Write the file out again
  with open(filepath, 'w') as file:
    file.write(filedata)