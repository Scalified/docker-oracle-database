SET VERIFY OFF;

DEFINE sid = &1
DEFINE db_name = &2
DEFINE username = &3
DEFINE password = &4

CREATE PLUGGABLE DATABASE &db_name ADMIN USER &username IDENTIFIED BY &password FILE_NAME_CONVERT=('/opt/oracle/oradata/&sid/pdbseed/','/opt/oracle/oradata/&sid/&db_name');
ALTER PLUGGABLE DATABASE &db_name OPEN;
ALTER PLUGGABLE DATABASE &db_name SAVE STATE;

ALTER SESSION SET CONTAINER=&db_name;
GRANT ALL PRIVILEGES TO &username;
ALTER PROFILE DEFAULT LIMIT password_life_time UNLIMITED;
SELECT resource_name, limit FROM dba_profiles WHERE PROFILE = 'DEFAULT';

ALTER TABLESPACE UNDOTBS1 OFFLINE;
DROP TABLESPACE UNDOTBS1 INCLUDING CONTENTS AND DATAFILES;
ALTER SESSION SET CONTAINER=CDB$ROOT;

