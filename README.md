# Tnsping4j (Version 1.0.28.11.2018) - It is a Java utility to test connection to an Oracle database

Test database connectivity through Oracle JDBC driver. The test can be done using
either Oracle JDBC Thin driver, or Oracle JDBC-OCI driver. The last one requires additional
Oracle software installed, such as SQL*Net and TNSNAMES.ora file properly configured. 
The goal of this utility is not only test the database connectivity, but also test both Oracle JDBC driver 
compatibility with target database, and validate the connect string, especially ones stored in JDBC data 
sources in Java EE application servers and containers, such as Oracle Weblogic, WildFly, Tomcat, etc.

# Usage:

The utility can be launched with aid of three scripts for Windows, Linux/Mac and PowerShell. 

###### Here are some examples in PowerShell.

- Using JDBC-OCI driver
```
PS C:\>.\tnsping4j.ps1 -ojdbc C:\Oracle\sqlcl\lib\ojdbc8.jar -conn ORCL -oci
```

- Using JDBC-Thin driver
```
PS C:\>.\tnsping4j.ps1 -ojdbc C:\Oracle\sqlcl\lib\ojdbc8.jar -conn "(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=oracle-server)(PORT=1521)))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=SERVICE)))"
```
