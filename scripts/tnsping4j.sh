#!/bin/bash
# tnsping4j.sh  -- script to TNSPING4J under Linux/Unix with an 
#                  appropriate classpath.

# Display usage information
usage() {
  echo Usage: 
  echo tnsping4j.sh -ojdbc ojdbc_driver_parth -conn net_service_name\|net_service_string [-oci]
  echo
  echo Where
  echo \* ojdbc_driver_parth
  echo   Is the Oracle JDBC driver file path.
  echo
  echo \* net_service_name
  echo   Must exist in tnsnames.ora file when -oci switch is used.
  echo
  echo \* net_service_string
  echo   A valid connect string to be used by Oracle JDBC driver.
  echo
  echo Examples
  echo 1\) Testing database connection using Oracle JDBC THIN driver
  echo tnsping4j.sh -ojdbc $ORACLE_HOME/jdbc/lib/ojdbc8.jar -conn \"'(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=oracle-server)(PORT=1521)))(CONNECT_DATA=SERVICE_NAME=SERVICE)))'\"
  echo
  echo 2\) Testing database connection using Oracle JDBC OCI driver
  echo tnsping4j.sh -ojdbc $ORACLE_HOME/jdbc/lib/ojdbc8.jar -conn ORCL -oci
}

if [[ "$1" = "-help" || "$1" = "" ]] ; then
   usage
   exit 0
fi

# Stop this shell if ORACLE_HOME is not
# defined.
if [[ ! ${ORACLE_HOME} ]] ; then
   echo Environment variable ORACLE_HOME is not defined!
   exit 1
fi

# Define LD_LIBRARY_PATH just in case it does not
# exist in shell environment.
if [[ ! ${LD_LIBRARY_PATH} ]] ; then
   LD_LIBRARY_PATH=$ORACLE_HOME/lib
   export LD_LIBRARY_PATH
fi

# Find out the directory where this script is,
# so we can find the jar files underneath it.
scriptpath=`dirname $0`

if [ "$1" != "-ojdbc" ] ; then
   echo Error: -ojdbc parameter was not informed in the command line.
   usage
   exit 1
fi

# If there is -ojdbc switch in the command line, then shift
# parameters to get the JDBC driver file path
shift

# tnspclasspath must contain paths to all needed classes for DV,
# separated by colons.    All .jar files under lib/
# below the directory the .sh file is in are automatically added.
# If you need others, either drop them in that directory, or add 
# them here manually (dropping them in the directory is better!).
tnspclasspath="."
for l in ${scriptpath}/lib/*.jar $1 ; do
    tnspclasspath=$tnspclasspath:$l
done

# Prepare command line to call Java runtime properly
JAVACMD=`which java 2>/dev/null`

if [ -z "$JAVACMD" ] ; then
   echo Java runtime was not found. Exiting...
   exit 1
fi

# Run the relevant Java code with the appropriate classpath
"$JAVACMD" -classpath "$tnspclasspath" br.com.interop.main.Main $2 $3 $4 $5