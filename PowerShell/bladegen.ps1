c:

$parentFolder="C:\Users\apm47\Documents\FYP\bladegen\Geometries"

$GeometriesToRun = @(74, 75, 76, 77, 78, 79, 80) # Select which geometry numbers to run

foreach($i in $GeometriesToRun){
$myFolder="C:\Users\apm47\Documents\FYP\bladegen\Geometries\Geom_$i"

# Diffuser
$src=$myfolder + "\Diffuser.bgi"
$dstfolder = $myfolder + "\Diffuser"
$dst=$dstfolder + "\Diffuser.bgd"

$prefix = "BG-2"

# Create directory
if(Test-Path $dstfolder){
    Remove-Item $dstfolder -Force -Recurse
}

New-Item -ItemType Directory -Force -Path $dstfolder



& "C:\Program Files\ANSYS Inc\v202\aisol\BladeModeler\BladeGen\BladeBatch.exe" $src $dst


& "C:\Program Files\ANSYS Inc\v202\aisol\BladeModeler\BladeGen\BladeBatch.exe" $src -TG $dstfolder

# Rename files

#Get-ChildItem -Path $myfolder | Rename-Item -NewName { $_.Name -replace 'Diffuser.bgd',"$prefix.bgd"}
Rename-Item "$dstfolder\Diffuser.bgd" "$prefix.bgd"
Rename-Item "$dstfolder\BladeGen.inf" "$prefix.inf"
Rename-Item "$dstfolder\hub.curve" $prefix'_hub.curve'
Rename-Item "$dstfolder\profile.curve" $prefix'_profile.curve'
Rename-Item "$dstfolder\shroud.curve" $prefix'_shroud.curve'

# Copy files to Ansys folder
$bg2Folder = "C:\Users\apm47\Documents\FYP\_Model_Resized\FYP_Resized_Model_files\dp0\BG-2\TS"
$sourceDir = $dstfolder + "\*"
Copy-item -Force -Recurse -Verbose $sourceDir -Destination $bg2Folder

###################################################################################################################

## Impeller
$src=$myfolder + "\Impeller.bgi"
$dstfolder = $myfolder + "\Impeller"
$dst=$dstfolder + "\Impeller.bgd"

$prefix = "BG-1"

# Create directory
if(Test-Path $dstfolder){
    Remove-Item $dstfolder -Force -Recurse
}

New-Item -ItemType Directory -Force -Path $dstfolder

& "C:\Program Files\ANSYS Inc\v202\aisol\BladeModeler\BladeGen\BladeBatch.exe" $src $dst


& "C:\Program Files\ANSYS Inc\v202\aisol\BladeModeler\BladeGen\BladeBatch.exe" $src -TG $dstfolder

Rename-Item "$dstfolder\Impeller.bgd" "$prefix.bgd"
Rename-Item "$dstfolder\BladeGen.inf" "$prefix.inf"
Rename-Item "$dstfolder\hub.curve" $prefix'_hub.curve'
Rename-Item "$dstfolder\profile.curve" $prefix'_profile.curve'
Rename-Item "$dstfolder\shroud.curve" $prefix'_shroud.curve'

# Copy files to Ansys folder
$bg1Folder = "C:\Users\apm47\Documents\FYP\_Model_Resized\FYP_Resized_Model_files\dp0\BG-1\TS"
$sourceDir = $dstfolder + "\*"
Copy-item -Force -Recurse -Verbose $sourceDir -Destination $bg1Folder

###################################################################################################################
# Run simulation on workbench
Write-Host("Running simulation for geometry number $i")

$scriptPath = Join-Path -Path $myfolder -ChildPath "Workflow.wbjn"
$projectPath = "C:\Users\apm47\Documents\FYP\_Model_Resized\FYP_Resized_Model.wbpj"
& "C:\Program Files\ANSYS Inc\v202\Framework\bin\Win64\RunWB2.exe" -B -F $projectPath -R $scriptPath | Out-Null
}

read-host “Press ENTER to continue...”