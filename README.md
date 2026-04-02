# Docker Oracle Enterprise Database

[![Docker Pulls](https://img.shields.io/docker/pulls/scalified/oracle-database.svg)](https://hub.docker.com/r/scalified/oracle-database)
[![Release](https://img.shields.io/github/v/release/Scalified/docker-oracle-database?style=flat-square)](https://github.com/Scalified/docker-oracle-database/releases/latest)

## Overview

This repository provides a prebuilt [**Oracle Database Enterprise Edition**](https://container-registry.oracle.com) **Docker** image with automatic setup and additional configuration scripts for simplified database management

## Official Resources

* [Oracle Database Container Registry](https://container-registry.oracle.com)
* [Creating an Oracle Database Docker Image (Oracle Blog)](https://blogs.oracle.com/developer/entry/creating_and_oracle_database_docker)
* [Oracle Database Software Downloads](http://www.oracle.com/technetwork/database/enterprise-edition/downloads/index.html)
* [Oracle Docker Images (GitHub)](https://github.com/oracle/docker-images)

## Usage

```bash
docker run -d \
    --name oracledb \
    scalified/oracle-database:<version>
```

### Available Versions

| Version          |
|------------------|
| **19.3.0.0**     |
| **12.2.0.1-ee**  |
| **12.1.0.2-se2** |
| **12.1.0.2-ee**  |
| **11g-r2**       |

### Connecting to the Database

After the container starts and the database initializes, connect using `sqlplus` as follows:

```bash
sqlplus sys/<your password>@//localhost:1521/<your SID> as sysdba
sqlplus system/<your password>@//localhost:1521/<your SID>
sqlplus sys/<your password>@//localhost:1521/<Your PDB name> as sysdba
sqlplus pdbadmin/<your password>@//localhost:1521/<Your PDB name>
```

### Configuration

#### Automatic Setup

The setup script is automatically executed during the initial container startup. It performs the following configuration steps:

* Disables local undo, preventing the database from using locally managed undo segments
* Sets the `PGA` aggregate limit to `0`, removing the global hard cap on total `PGA` memory usage
* Updates the `SPFILE` to include `PROCESSES=2000`, allowing up to `2000` server processes or sessions after the next database restart

No manual setup is required.

#### Creating a Pluggable Database (PDB)

To create a new PDB inside a running Oracle container:

```sql
docker exec <oracle_container_name> create-pdb <db_name> <username> <password>
```

Parameters:

* `<db_name>` - PDB name
* `<username>` - PDB username
* `<password>` - PDB password

#### Changing Enterprise Manager Endpoint

To view the listener status and endpoints, run:

```bash
lsnrctl status
```

Sample output:

```
...
Listening Endpoints Summary...
  (DESCRIPTION=(ADDRESS=(PROTOCOL=ipc)(KEY=EXTPROC1)))
  (DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=0.0.0.0)(PORT=1521)))
  (DESCRIPTION=(ADDRESS=(PROTOCOL=tcps)(HOST=67e0ca534f7b)(PORT=5500))(Presentation=HTTP)(Session=RAW))
...
```

Then connect to `SQL*Plus` as `sysdba` and update the Enterprise Manager listener endpoint:

```sql
exec dbms_xdb_config.setListenerEndPoint(dbms_xdb_config.xdb_endpoint_http2, '67e0ca534f7b', 5500, dbms_xdb_config.xdb_protocol_tcp);
```

Set the Enterprise Manager (EM) ports if needed:

```sql
exec DBMS_XDB_CONFIG.SETHTTPSPORT(5500);
exec DBMS_XDB_CONFIG.SETHTTPPORT(5510);
```

> For more details, refer to [DBMS_XDB_CONFIG documentation](https://www.morganslibrary.org/reference/pkgs/dbms_xdb_config.html)

#### Changing Connection Timeouts

To disable inbound connection timeouts, append the following lines to the Oracle network configuration files:

```bash
echo "INBOUND_CONNECT_TIMEOUT_LISTENER=0" >> $ORACLE_HOME/network/admin/listener.ora
echo "SQLNET.INBOUND_CONNECT_TIMEOUT=0" >> $ORACLE_HOME/network/admin/sqlnet.ora
```

---

**Made with ❤️ by [Scalified](http://www.scalified.com)**
