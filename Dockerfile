ARG VERSION=19.3.0.0

FROM container-registry.oracle.com/database/enterprise:${VERSION}

COPY rootfs /

COPY --chown=oracle:dba ./scripts/setup/* /opt/oracle/scripts/setup/
