FROM container-registry.oracle.com/database/enterprise:19.3.0.0

ENV ORACLE_SCRIPTS_PATH /opt/scripts

ENV PATH "$PATH:$ORACLE_SCRIPTS_PATH"

COPY setup /opt/oracle/scripts/setup

COPY scripts /opt/scripts

