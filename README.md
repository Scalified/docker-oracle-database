# Docker Oracle Database

[![Docker Pulls](https://img.shields.io/docker/pulls/scalified/oracle-database.svg)](https://hub.docker.com/r/scalified/oracle-database)
[![](https://images.microbadger.com/badges/image/scalified/oracle-database.svg)](https://microbadger.com/images/scalified/oracle-database)
[![](https://images.microbadger.com/badges/version/scalified/oracle-database.svg)](https://microbadger.com/images/scalified/oracle-database)

## Description

This repository contains an official [**Oracle Database**](https://container-registry.oracle.com/ords/f?p=113:4:113443227637136:::4:P4_REPOSITORY,AI_REPOSITORY,AI_REPOSITORY_NAME,P4_REPOSITORY_NAME,P4_EULA_ID,P4_BUSINESS_AREA_ID:9,9,Oracle%20Database%20Enterprise%20Edition,Oracle%20Database%20Enterprise%20Edition,1,0&cs=3ngPvo9IXPi_O4ZXhv09DqTdDeSyjEdM9Bllql6pu2wJzhQdAu8XltTmhgof2DCjvAGrBWeSfyWTMj3xRtT3yQw) images with additional scripts

## Official Documentation

* [Oracle Database Container Registry](https://container-registry.oracle.com/ords/f?p=113:4:113443227637136:::4:P4_REPOSITORY,AI_REPOSITORY,AI_REPOSITORY_NAME,P4_REPOSITORY_NAME,P4_EULA_ID,P4_BUSINESS_AREA_ID:9,9,Oracle%20Database%20Enterprise%20Edition,Oracle%20Database%20Enterprise%20Edition,1,0&cs=3ngPvo9IXPi_O4ZXhv09DqTdDeSyjEdM9Bllql6pu2wJzhQdAu8XltTmhgof2DCjvAGrBWeSfyWTMj3xRtT3yQw)
* [Creating an Oracle Database Docker image](https://blogs.oracle.com/developer/entry/creating_and_oracle_database_docker)
* [Oracle Database Software Downloads](http://www.oracle.com/technetwork/database/enterprise-edition/downloads/index.html)
* [Docker Images from Oracle](https://github.com/oracle/docker-images)* [Creating an Oracle Database Docker image](https://blogs.oracle.com/developer/entry/creating_and_oracle_database_docker)

## Dockerhub

`docker pull scalified/oracle-database:<version>`

| Version                     | Description                   |
|-----------------------------|-------------------------------|
| **19.3.0.0-ee**             | 19.3.0.0 Enterprise Edition   |
| **12.2.0.1-ee**             | 12.2.0.1 Enterprise Edition   |
| **12.1.0.2-se2**            | 12.1.0.2 Standard Edition     |
| **12.1.0.2-ee**             | 12.1.0.2 Enterprise Edition   |
| **11g-r2**                  | 11g Release 2 Express Edition |

### Running Container

`docker run -it --name oracle -p 1521:1521 scalified/oracle-database:<tag>`

### Connecting to the Database

Once the container has been started and the database created you can connect to it just like to any other database:

```
sqlplus sys/<your password>@//localhost:1521/<your SID> as sysdba
sqlplus system/<your password>@//localhost:1521/<your SID>
sqlplus sys/<your password>@//localhost:1521/<Your PDB name> as sysdba
sqlplus pdbadmin/<your password>@//localhost:1521/<Your PDB name>
```

#### Creating PDB

```sql
docker exec <oracle_container_name> create-pdb.sh <db_name> <username> <password>
```

where:

* `<db_name>` - PDB name
* `<username>` - PDB username
* `<password>` - PDB password

#### Changing Enterprise Manager Endpoint

Check the listener status:

`lsnrctl status`

This will output endpoints:

```
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

Setting EM ports:

```sql
exec DBMS_XDB_CONFIG.SETHTTPSPORT(5500);
exec DBMS_XDB_CONFIG.SETHTTPPORT(5510);
```

#### Changing Connection Timeouts

```cmd
echo "INBOUND_CONNECT_TIMEOUT_LISTENER=0" >> $ORACLE_HOME/network/admin/listener.ora
echo "SQLNET.INBOUND_CONNECT_TIMEOUT=0" >> $ORACLE_HOME/network/admin/sqlnet.ora
```

## Scalified Links

* [Scalified](http://www.scalified.com)
* [Scalified Official Facebook Page](https://www.facebook.com/scalified)
* <a href="mailto:info@scalified.com?subject=[Oracle Docker Image]: Proposals And Suggestions">Scalified Support</a>

