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

| Version                     | Description                 |
|-----------------------------|-----------------------------|
| **12.2.0.1-ee**             | 12.2.0.1 Enterprise Edition |
| **12.1.0.2-se2**            | 12.1.0.2 Standard Edition   |
| **12.1.0.2-ee**             | 12.1.0.2 Enterprise Edition |

## Building Docker Image

1. Increase Docker container size by adding the following option to the daemon start:  
   **`--storage-opt dm.basesize=20G`**
2. Download Oracle installation files from [Oracle Database Software Downloads](http://www.oracle.com/technetwork/database/enterprise-edition/downloads/index.html)
3. Put downloaded files from *step 2* into the correspondent Oracle version folder in the:  
   **`oracle-docker-images/OracleDatabase/dockerfiles`**
4. Proceed with [official building instructions](https://github.com/oracle/docker-images/tree/master/OracleDatabase#building-oracle-database-docker-install-images)

## Connecting to Database

Once the container has been started and the database created you can connect to it just like to any other database:

```
sqlplus sys/<your password>@//localhost:1521/<your SID> as sysdba
sqlplus system/<your password>@//localhost:1521/<your SID>
sqlplus sys/<your password>@//localhost:1521/<Your PDB name> as sysdba
sqlplus pdbadmin/<your password>@//localhost:1521/<Your PDB name>
```

## Database Configuration

### Default Admin Accounts Passwords

On the first startup of the container a random password is generated for the database and shown in log message:

`ORACLE AUTO GENERATED PASSWORD FOR SYS, SYSTEM AND PDBAMIN: <password goes here>`

### Creating a User Inside Pluggable Database

```sql
CREATE USER <username> IDENTIFIED BY <password>
;
GRANT ALL PRIVILEGES TO <username>
;
```

### Creating Pluggable Database

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

## Scalified Links

* [Scalified](http://www.scalified.com)
* [Scalified Official Facebook Page](https://www.facebook.com/scalified)
* <a href="mailto:info@scalified.com?subject=[Squash TM Docker Image]: Proposals And Suggestions">Scalified Support</a>
