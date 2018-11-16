#!/bin/sh
# tnsping4j.sh  -- script to TNSPING4J under Linux/Unix with an 
#                  appropriate classpath.  If first parameter is -v, 
#                  will output java command line before running it.

# Display usage information
usage() {
  echo Usage: 
  echo tnsping4j.bat -ojdbc ojdbc_driver_parth -conn net_service_name\|net_service_string
  echo
  echo Where
  echo * ojdbc_driver_parth
  echo   Is the Oracle JDBC driver file path.
  echo
  echo * net_service_name
  echo   Must exist in tnsnames.ora file when -oci switch is used.
  echo
  echo * net_service_string
  echo   A valid connect string to be used by Oracle JDBC driver.
  echo
  echo Examples
  echo 1\) Testing database connection using Oracle JDBC THIN driver
  echo tnsping4j.bat -ojdbc C:\Oracle\sqlcl\lib\ojdbc8.jar -conn \"'(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=oracle-server)(PORT=1521)))(CONNECT_DATA=SERVICE_NAME=SERVICE)))'\"
  echo
  echo 2\) Testing database connection using Oracle JDBC OCI driver
  echo tnsping4j.bat -ojdbc C:\Oracle\sqlcl\lib\ojdbc8.jar -conn ORCL -oci
}

if [[ "$1" = "-help" || "$1" = "" ]] ; then
   usage
   exit 0
fi

if [ "$1" != "-ojdbc" ] ; then
   echo Error: -ojdbc parameter was not informed in the command line.
   usage
   exit 1
fi

# If there is -ojdbc switch in the command line, then shift
# parameters to get the JDBC driver file path
shift

# Find out the directory where this script is,
# so we can find the jar files underneath it.
scriptpath=`dirname $0`

# tnspclasspath must contain paths to all needed classes for DV,
# separated by colons.    All .jar files under lib/
# below the directory the .sh file is in are automatically added.
# If you need others, either drop them in that directory, or add 
# them here manually (dropping them in the directory is better!).
tnspclasspath="."
for l in ${scriptpath}/lib/*.jar $1 ; do
    tnspclasspath=$tnspclasspath:$l
done

# Output what we will execute, for debugging, if we have a -v switch
if [ "$1" = "-v" ] ; then
    shift
    echo java -classpath "$tnspclasspath" br.com.interop.main.Main $2 $3 $4 $5
fi

# Run the relevant Java code with the appropriate classpath
echo java -classpath "$tnspclasspath" br.com.interop.main.Main $2 $3 $4 $5
java -classpath "$tnspclasspath" br.com.interop.main.Main $2 $3 $4 $5