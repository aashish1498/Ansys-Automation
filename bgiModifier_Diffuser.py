import urllib
import os
import fileinput
import csv
from shutil import copyfile

def ModifyDiffuser(folderPath):
  templatepath = "C:\\Users\\aashi\\Documents\\Uni\\Final year\\Final Year Project\\Automation\\Diffuser Template.bgi"
  filepath = folderPath + "\\Diffuser.bgi"

  copyfile(templatepath, filepath)

  # Read in the file
  with open(filepath, 'r') as file :
    filedata = file.read()

  divider = "\n\t\t\t\t\t"
  divlen = 6
  searchArray = ["DATA_TO_CHANGE", "DATA_10", "DATA_11", "DATA_1", "DATA_2", "DATA_3", "DATA_4", "DATA_5", "DATA_6", "DATA_7", "DATA_8", "DATA_9"]

  # Loop starts here over the different texts to search
  for text_to_search in searchArray:
    csvFilepath = "C:\\Users\\aashi\\Documents\\Uni\\Final year\\Final Year Project\\Automation\\CSV\\Diffuser\\" + text_to_search + ".csv"
    replacement_text = ""

    if(text_to_search == "DATA_TO_CHANGE" or text_to_search == "DATA_11"):
      divider = "\n\t\t\t\t\t"
      divlen = 6
    else:
      divider = "\n\t\t\t\t"
      divlen = 5

    # Open CSV and read text into a variable
    with open(csvFilepath) as csvfile:
        datareader = csv.reader(csvfile, delimiter=' ', quotechar='|')
        for row in datareader:
            #print('( ' + ', '.join(row) + ' )')
            replacement_text = replacement_text + '( ' + ', '.join(row) + ' )' + divider

    # Remove trailing divider
    if replacement_text.endswith(divider):
        replacement_text = replacement_text[:-divlen]

    # Replace the target string
    filedata = filedata.replace(text_to_search, replacement_text)

  # Loop ends here

  # Write the file out again
  with open(filepath, 'w') as file:
    file.write(filedata)
    