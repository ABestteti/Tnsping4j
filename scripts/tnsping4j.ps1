# tnsping4j.ps1  --  script to run tnsping4j under Windows with an appropriate
#                    classpath.

param (
    [Parameter(Mandatory=$false)][switch]$help = $false,
    [Parameter(Mandatory=$true)][string]$ojdbc,
    [Parameter(Mandatory=$true)][string]$conn,
    [Parameter(Mandatory=$false)][switch]$oci = $false
 )

# Display usage information
function usage() { 
    Write-Host "Usage:"
    Write-Host " tnsping4j.ps1 -ojdbc ojdbc_driver_parth -conn net_service_name\|net_service_string [-oci]"
    Write-Host ""
    Write-Host "Where"
    Write-Host "* ojdbc_driver_parth"
    Write-Host "  Is the Oracle JDBC driver file path."
    Write-Host ""
    Write-Host "* net_service_name"
    Write-Host "  Must exist in tnsnames.ora file when -oci switch is used."
    Write-Host ""
    Write-Host "* net_service_string"
    Write-Host "  A valid connect string to be used by Oracle JDBC driver."
    Write-Host ""
    Write-Host "Examples"
    Write-Host "1) Testing database connection using Oracle JDBC THIN driver"
    Write-Host "tnsping4j.ps1 -ojdbc C:\Oracle\sqlcl\lib\ojdbc8.jar -conn '(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=oracle-server)(PORT=1521)))(CONNECT_DATA=SERVICE_NAME=SERVICE)))'"
    Write-Host ""
    Write-Host "2) Testing database connection using Oracle JDBC OCI driver"
    Write-Host "tnsping4j.ps1 -ojdbc C:\Oracle\sqlcl\lib\ojdbc8.jar -conn ORCL -oci"
}

if ($help) {
    usage
    Exit
}

$scriptpath = $PSScriptRoot.ToString() + "\lib"
$FileList   = get-childitem $scriptpath 

# TNSPCLASSPATH must contain paths to all needed classes for TNSPING4J,
# separated by semicolons.  All .jar files under lib
# below the directory the .bat file is in are automatically added.
# If you need others, either drop them in that directory, or add them
# here manually (dropping them in the directory is better!).
$tnspclasspath = "."

# Prepare the classpath to run the application with the
# list of jar libraries required.
ForEach ($jarFile in $FileList) {
    $tnspclasspath = $tnspclasspath + ";" + ($jarFile.FullName)
}

$tnspclasspath = $tnspclasspath + ";" + $ojdbc

if ($oci) {
    Write-Host java -classpath $tnspclasspath br.com.interop.main.Main -conn $conn -oci
    & java -classpath $tnspclasspath br.com.interop.main.Main -conn $conn -oci
} else {
    Write-Host java -classpath $tnspclasspath br.com.interop.main.Main -conn $conn -oci
    & java -classpath $tnspclasspath br.com.interop.main.Main -conn $conn
}
