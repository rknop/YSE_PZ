#!/bin/bash

if [ ! -f $POSTGRES_DATA_DIR/PG_VERSION ]; then
    echo "Running initdb in $POSTGRES_DATA_DIR"
    /usr/lib/postgresql/13/bin/initdb -U postgres --pwfile=/secrets/postgresql_password $POSTGRES_DATA_DIR
    /usr/lib/postgresql/13/bin/pg_ctl -D $POSTGRES_DATA_DIR start
    psql --command "CREATE DATABASE yse_pz OWNER postgres"
    psql --command "CREATE EXTENSION q3c" tom_desc
    explorerpassword=`cat /secrets/postgresql_explorer_password`
    psql --command "CREATE USER explorer PASSWORD '${explorerpassword}'"
    psql --command "GRANT CONNECT ON yse_pz TO explorer"
    psql --command "GRANT USAGE ON SCHEMA public TO explorer"
    psql --command "ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO explorer" yse_pz
    /usr/lib/postgresql/13/bin/pg_ctl -D $POSTGRES_DATA_DIR stop
fi
exec /usr/lib/postgresql/13/bin/postgres -c config_file=/etc/postgresql/13/main/postgresql.conf
