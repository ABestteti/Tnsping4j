# tnsping4j.ps1  --  script to run tnsping4j under Windows with an appropriate
#                    classpath.

param (
    [Parameter(Mandatory=$false)][string]$help,
    [string]$ojdbc,
    [string]$conn,
    [string]$oci
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

Write-Host $ojdbc