#!/bin/env bash

DB_NAME="$1"
USERNAME="$2"
PASSWORD="$3"

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")

sqlplus -S /nolog <<EOF
CONNECT / as sysdba
@$SCRIPT_DIR/sql/pdb.sql $ORACLDE_SID $DB_NAME $USERNAME $PASSWORD
EXIT
EOF

