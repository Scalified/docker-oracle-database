# Oracle Database Docker

## Description

This repository is used for building a [**Docker**](https://www.docker.com) image containing [**Oracle Database**](https://www.oracle.com/database/index.html)

## Official Documentation

* [Creating an Oracle Database Docker image](https://blogs.oracle.com/developer/entry/creating_and_oracle_database_docker)
* [Oracle Database Software Downloads](http://www.oracle.com/technetwork/database/enterprise-edition/downloads/index.html)
* [Docker Images from Oracle](https://github.com/oracle/docker-images)

## Dockerhub

`docker pull scalified/oracle-database:<version>`

| Version                     | Description                 |
|-----------------------------|-----------------------------|
| **12.1.0.2-se2**            | 12.1.0.2 Standard Edition   |
| **12.1.0.2-ee**             | 12.1.0.2 Enterprise Edition |

## Building Docker Image

1. Increase Docker container size by adding the following option to the daemon start:  
   **`--storage-opt dm.basesize=20G`**
2. Download Oracle installation files from [Oracle Database Software Downloads](http://www.oracle.com/technetwork/database/enterprise-edition/downloads/index.html)
3. Put downloaded files from *step 2* into the correspondent Oracle version folder in the:  
   **`oracle-docker-images/OracleDatabase/dockerfiles`**
4. Proceed with [official building instructions](https://github.com/oracle/docker-images/tree/master/OracleDatabase#building-oracle-database-docker-install-images)

## Database Configuration

### Default Admin Accounts Passwords

On the first startup of the container a random password is generated for the database and shown in log message:

`ORACLE AUTO GENERATED PASSWORD FOR SYS, SYSTEM AND PDBAMIN: <password goes here>`

### Creating a User

```sql
CREATE USER <username> IDENTIFIED BY <password>
;
GRANT ALL PRIVILEGES TO <username>
;
```

### Creating Pluggable Database

```sql
CREATE PLUGGABLE DATABASE <db_name> ADMIN USER <username> IDENTIFIED BY <password> FILE_NAME_CONVERT=('/opt/oracle/oradata/APSUSER/pdbseed/','/opt/oracle/oradata/APSUSER/<db_name>')
;
ALTER PLUGGABLE DATABASE <db_name> OPEN
;
ALTER PLUGGABLE DATABASE <db_name> SAVE STATE
;
```

## Scalified Links

* [Scalified](http://www.scalified.com)
* [Scalified Official Facebook Page](https://www.facebook.com/scalified)
* <a href="mailto:info@scalified.com?subject=[Squash TM Docker Image]: Proposals And Suggestions">Scalified Support</a>
