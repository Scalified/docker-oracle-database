FROM container-registry.oracle.com/database/enterprise:19.3.0.0

COPY setup /opt/oracle/scripts/setup

COPY scripts /home/scripts

