# Oracle Database Docker

[![Docker Pulls](https://img.shields.io/docker/pulls/scalified/oracle-database.svg)](https://hub.docker.com/r/scalified/oracle-database)
[![](https://images.microbadger.com/badges/image/scalified/oracle-database.svg)](https://microbadger.com/images/scalified/oracle-database)
[![](https://images.microbadger.com/badges/version/scalified/oracle-database.svg)](https://microbadger.com/images/scalified/oracle-database)

## Description

This repository is used for building a [**Docker**](https://www.docker.com) image containing [**Oracle Database**](https://www.oracle.com/database/index.html)

## Official Documentation

* [Creating an Oracle Database Docker image](https://blogs.oracle.com/developer/entry/creating_and_oracle_database_docker)
* [Oracle Database Software Downloads](http://www.oracle.com/technetwork/database/enterprise-edition/downloads/index.html)
* [Docker Images from Oracle](https://github.com/oracle/docker-images)

## Dockerhub

**`docker pull scalified/oracle-database:<version>`**

| Version                     | Description                   |
|-----------------------------|-------------------------------|
| **11g-r2**                  | 11g Release 2 Express Edition |
| **12.2.0.1-ee**             | 12.2.0.1 Enterprise Edition   |
| **12.1.0.2-se2**            | 12.1.0.2 Standard Edition     |
| **12.1.0.2-ee**             | 12.1.0.2 Enterprise Edition   |

## Oracle 11.x Releases

Currently only 11g Release 2 is supported

### Running Container

```
docker run -it --name oracle -p 1521:1521 scalified/oracle-database:<tag>
```

### Connection Settings

#### JDBC URL

```
jdbc:oracle:thin:@//localhost:1521/xe
```

#### Credentials

| User      | Password | Description  |
|-----------|----------|--------------|
| system    | oracle   | System user  |
| sys       | oracle   | System user  |
| scalified | 123456   | Regular user |

## Oracle 12.x Releases

### Building Docker Images

1. Increase Docker container size by adding the following option to the daemon start:  
   **`--storage-opt dm.basesize=20G`**
2. Download Oracle installation files from [Oracle Database Software Downloads](http://www.oracle.com/technetwork/database/enterprise-edition/downloads/index.html)
3. Put downloaded files from *step 2* into the correspondent Oracle version folder in the:  
   **`oracle-docker-images/OracleDatabase/dockerfiles`**
4. Proceed with [official building instructions](https://github.com/oracle/docker-images/tree/master/OracleDatabase#building-oracle-database-docker-install-images)

### Connecting to Database

Once the container has been started and the database created you can connect to it just like to any other database:

```
sqlplus sys/<your password>@//localhost:1521/<your SID> as sysdba
sqlplus system/<your password>@//localhost:1521/<your SID>
sqlplus sys/<your password>@//localhost:1521/<Your PDB name> as sysdba
sqlplus pdbadmin/<your password>@//localhost:1521/<Your PDB name>
```

### Database Configuration

#### Default Admin Accounts Passwords

On the first startup of the container a random password is generated for the database and shown in log message:

`ORACLE AUTO GENERATED PASSWORD FOR SYS, SYSTEM AND PDBAMIN: <password goes here>`

#### Creating a User Inside Pluggable Database

```sql
CREATE USER <username> IDENTIFIED BY <password>
;
GRANT ALL PRIVILEGES TO <username>
;
```

#### Creating Pluggable Database

```sql
CREATE PLUGGABLE DATABASE <pdb_name> ADMIN USER <username> IDENTIFIED BY <password> 
  FILE_NAME_CONVERT=('/opt/oracle/oradata/<cdb_name>/pdbseed/','/opt/oracle/oradata/<cdb_name>/<pdb_name>')
;
ALTER PLUGGABLE DATABASE <pdb_name> OPEN
;
ALTER PLUGGABLE DATABASE <pdb_name> SAVE STATE
;
```

where:

* **\<pdb_name\>** - pluggable database name to create
* **\<cdb_name\>** - container database name (**SID**)

#### Changing Enterprise Manager Endpoint

Check the listener status:
```cmd
lsnrctl status
```
This will output endpoints:
```cmd
...
Listening Endpoints Summary...
  (DESCRIPTION=(ADDRESS=(PROTOCOL=ipc)(KEY=EXTPROC1)))
  (DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=0.0.0.0)(PORT=1521)))
  (DESCRIPTION=(ADDRESS=(PROTOCOL=tcps)(HOST=67e0ca534f7b)(PORT=5500))(Presentation=HTTP)(Session=RAW))
...
```
Login to sql as sysdba and execute procedure:
```sql
exec dbms_xdb_config.setListenerEndPoint(dbms_xdb_config.xdb_endpoint_http2, '67e0ca534f7b', 5500, dbms_xdb_config.xdb_protocol_tcp);
```

More info:
```
https://www.morganslibrary.org/reference/pkgs/dbms_xdb_config.html
```

#### Changing Connection Timeouts

```cmd
echo "INBOUND_CONNECT_TIMEOUT_LISTENER=0" >> $ORACLE_HOME/network/admin/listener.ora
echo "INBOUND_CONNECT_TIMEOUT_LISTENER=0" >> $ORACLE_HOME/network/admin/sqlnet.ora
```

## Scalified Links

* [Scalified](http://www.scalified.com)
* [Scalified Official Facebook Page](https://www.facebook.com/scalified)
* <a href="mailto:info@scalified.com?subject=[Squash TM Docker Image]: Proposals And Suggestions">Scalified Support</a>
