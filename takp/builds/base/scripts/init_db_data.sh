#!/bin/bash

set -e

cd /data

if [ -d /var/lib/mysql/${DB_NAME_LS} ]; then
  echo "[database] ${DB_NAME_LS} database exists; proceeding with init..."
else
  echo "[database] create ${DB_NAME_LS} database..."
  mariadb --user root --password=${MARIADB_ROOT_PASSWORD} -h db -e "create database ${DB_NAME_LS};"
  echo "[database] grant privs on ${DB_NAME_LS} database..."
  mariadb --user root --password=${MARIADB_ROOT_PASSWORD} -h db -e "GRANT ALL PRIVILEGES ON ${DB_NAME_LS}.* TO '${MARIADB_USER}'@'%'"
  echo "[database] load alkabor tables..."
  mariadb --user root --password=${MARIADB_ROOT_PASSWORD} -h db -D ${DB_NAME_GAME} < /data/alkabor_2023-10-25-19\:31.sql
  echo "[database] load player tables..."
  mariadb --user root --password=${MARIADB_ROOT_PASSWORD} -h db -D ${DB_NAME_GAME} < /data/player_tables_2023-10-25-19\:31.sql
  echo "[database] load data tables..."
  mariadb --user root --password=${MARIADB_ROOT_PASSWORD} -h db -D ${DB_NAME_GAME} < /data/data_tables_2023-10-25-19\:31.sql
  echo "[database] load loginserver tables..."
  mariadb --user root --password=${MARIADB_ROOT_PASSWORD} -h db -D ${DB_NAME_LS} < /data/login_tables_2023-10-25-19\:31.sql
  mariadb --user root --password=${MARIADB_ROOT_PASSWORD} -h db -D ${DB_NAME_LS} < /data/tblloginserversettings.sql
  mariadb --user root --password=${MARIADB_ROOT_PASSWORD} -h db -D ${DB_NAME_LS} -e "ALTER TABLE tblLoginServerAccounts ALTER creationIP SET DEFAULT '127.0.0.1';"
  mariadb --user root --password=${MARIADB_ROOT_PASSWORD} -h db -D ${DB_NAME_LS} -e "ALTER TABLE tblLoginServerAccounts ALTER ForumName SET DEFAULT 'docker';"
  echo "[database] setting up initial dockeradmin login account, dockeradmin:dockeradmin"
  mariadb --user root --password=${MARIADB_ROOT_PASSWORD} -h db -D ${DB_NAME_LS} <<EOF
    INSERT INTO tblLoginServerAccounts (LoginServerID, AccountName, AccountPassword, AccountEmail, LastLoginDate, LastIPAddress)
    VALUES(999, 'dockeradmin', SHA('dockeradmin'), 'local_creation', NOW(), '127.0.0.1');
EOF
  mariadb --user root --password=${MARIADB_ROOT_PASSWORD} -h db -D ${DB_NAME_GAME} <<EOF
    INSERT INTO account (name, status, lsaccount_id)
    VALUES ('dockeradmin', 250, 999);
EOF
fi

