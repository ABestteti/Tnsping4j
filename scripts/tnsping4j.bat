@echo off
rem tnsping4j.bat -- script to run tnsping4j under Windows with an appropriate
rem                   classpath.  If first parameter is -v, will output java
rem                   command line before running it.
rem                   NOTE: This does NOT work under Windows 95/98/NT.
rem                   It DOES work under Windows 2000/XP/Vista.

rem Display the command usage
if "X-helpX" == "X%1X" (
   goto :usage )
if "XX" == "X%1X" (
   goto :usage )
   
setlocal
setlocal ENABLEDELAYEDEXPANSION

rem Find out drive and directory where this script is,
rem so we can find the jar files underneath it.
set SCRIPTPATH=%~d0%~p0

rem TNSPCLASSPATH must contain paths to all needed classes for TNSPING4J,
rem separated by semicolons.  All .jar files under lib
rem below the directory the .bat file is in are automatically added.
rem If you need others, either drop them in that directory, or add them
rem here manually (dropping them in the directory is better!).
set TNSPCLASSPATH=
rem Build the classpath
if "X-ojdbcX" == "X%1X" (
   shift ) else (
   goto :error )
for %%Y in ("%SCRIPTPATH%"lib\*.jar %1) do set TNSPCLASSPATH=!TNSPCLASSPATH!;%%Y
rem Get rid of unwanted initial semicolon using the modifier %~1
SET TNSPCLASSPATH=%TNSPCLASSPATH:~1%

rem Output what we will execute, for debugging, if we have a -v parameter
if not "X-vX" == "X%1X" goto :endif
  echo java -classpath "%TNSPCLASSPATH%" br.com.interop.main.Main %2 %3 %4 %5
:endif

rem Run the relevant Java code with the appropriate classpath
java -classpath "%TNSPCLASSPATH%" br.com.interop.main.Main %~2 %~3 %~4 %~5
goto :end

:error
echo Error: -ojdbc parameter was not informed in the command line.

:usage
echo Usage: 
echo tnsping4j.bat -ojdbc ojdbc_driver_parth -conn net_service_name^|^"net_service_string^"
echo.
echo Where
echo * ojdbc_driver_parth
echo   Is the Oracle JDBC driver file path.
echo.
echo * net_service_name
echo   Must exist in tnsnames.ora file when -oci switch is used.
echo.
echo * net_service_string
echo   A valid connect string to be used by Oracle JDBC driver.
echo .
echo Examples
echo 1) Testing database connection with Oracle JDBC THIN driver
echo tnsping4j.bat -ojdbc C:\Oracle\sqlcl\lib\ojdbc8.jar -conn "(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=oracle-server)(PORT=1521)))(CONNECT_DATA=SERVICE_NAME=SERVICE)))"
echo.
echo 2) Testing atabase connection with Oracle JDBC OCI driver
echo tnsping4j.bat -ojdbc C:\Oracle\sqlcl\lib\ojdbc8.jar -conn ORCL -oci

:end