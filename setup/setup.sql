SHUTDOWN IMMEDIATE;

STARTUP UPGRADE;

ALTER DATABASE LOCAL UNDO OFF;

SHUTDOWN IMMEDIATE;

STARTUP;

SELECT * FROM database_properties WHERE property_name='LOCAL_UNDO_ENABLED';

