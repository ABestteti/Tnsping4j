# tnsping4j.ps1  --  This PowerShell script launches tnsping4j under Windows with an appropriate
#                    classpath.

<#
.SYNOPSIS

Test database connectivity through Oracle JDBC driver.

.DESCRIPTION

Test database connectivity through Oracle JDBC driver. The test can be done using
either Oracle JDBC Thin driver, or Oracle JDBC-OCI driver. The last one requires additional
Oracle software installed, such as SQL*Net and TNSNAMES.ora file properly configured. 
The goal of this utility is not only test the database connectivity, but also test both Oracle JDBC driver 
compatibility with target database, and validade the connect string, especially ones stored in JDBC data 
sources in Java EE application servers, such as Oracle Weblogic, WildFly, Tomcat, etc.

.PARAMETER ojdbc
Specifies the full path of Oracle JDBC jar file name to be used to test the connection.

.PARAMETER conn
Specifies the connection string or SQL*Net alias to be used to connect to a remote database. Be awere that SQL*Net aliases requires
a proper TNSNAMES.ora file configured.

.PARAMETER oci
Specifies that the connection test must be done through Oracle JDBC-OCI driver. This is an optional parameter, when supressed the
Oracle JDBC Thin driver will be used.

.OUTPUTS

Returns the status of connection test. OK (time in miliseconds) for sucessfull connection; otherwise an error will be shown.

.EXAMPLE

PS C:\>.\tnsping4j.ps1 -ojdbc C:\Oracle\sqlcl\lib\ojdbc8.jar -conn "(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=oracle-server)(PORT=1521)))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=SERVICE)))"

.EXAMPLE
PS C:\>.\tnsping4j.ps1 -ojdbc C:\Oracle\sqlcl\lib\ojdbc8.jar -conn ORCL -oci
#>

param (
    [Parameter(Mandatory=$true)][string]$ojdbc,
    [Parameter(Mandatory=$true)][string]$conn,
    [Parameter(Mandatory=$false)][switch]$oci = $false
 )

# Get the script location in order to determine the
# lib directory.
$scriptBasePath = $PSScriptRoot.ToString() + "\lib"
$libFileList    = get-childitem $scriptBasePath

# TNSPCLASSPATH must contain paths to all needed classes for TNSPING4J,
# separated by semicolons.  All .jar files under lib
# below the directory the .ps1 file is in are automatically added.
# If you need others, either drop them in that directory, or add them
# here manually (dropping them in the directory is better!).
$tnspclasspath = "."

# Prepare classpath to run the application with the
# list of jar libraries required by the tool.
ForEach ($jarFile in $libFileList) {
    $tnspclasspath = $tnspclasspath + ";" + ($jarFile.FullName)
}

$tnspclasspath = $tnspclasspath + ";" + $ojdbc

if ($oci) {
    & java -classpath $tnspclasspath br.com.interop.main.Main -conn $conn -oci
} else {
    & java -classpath $tnspclasspath br.com.interop.main.Main -conn $conn
}
