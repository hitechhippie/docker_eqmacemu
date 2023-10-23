#!/bin/bash

set -e

cd /eqmacemu

if test -f "eqemu_config.json"; then
  echo "[config] eqemu_config.json exists..."
else
  echo "[config] staging initial eqemu_config.json..."
  cp /build/eqemu_config.json eqemu_config.json
fi

if test -f "spells_en.txt"; then
  echo "[config] spells_en.txt exists..."
else
  echo "[config] staging initial spells_en.txt..."
  cp /build/spells_en.txt spells_en.txt
fi

if test -f "db.ini"; then
  echo "[config] db.ini exists..."
else
  echo "[config] staging initial db.ini..."
  cp /build/db.ini db.ini
fi

if test -f "login.ini"; then
  echo "[config] login.ini exists..."
else
  echo "[config] staging initial login.ini..."
  cp /build/login.ini login.ini
fi

sed -i "s/HOSTADDRESS/$HOST_ADDRESS/g" login.ini
sed -i "s/LOCALNETWORK/$LOCAL_NETWORK/g" login.ini
sed -i "s/ALLOWAUTOWORLDSERVERREGISTRATION/$ALLOW_AUTO_WORLDSERVER_REGISTRATION/g" login.ini
sed -i "s/ALLOWAUTOACCOUNTCREATION/$ALLOW_AUTO_ACCOUNT_CREATION/g" login.ini
sed -i "s/DBNAMELS/$DB_NAME_LS/g" login.ini
sed -i "s/MARIADBUSER/$MARIADB_USER/g" login.ini
sed -i "s/MARIADBPASSWORD/$MARIADB_PASSWORD/g" login.ini

sed -i "s/HOSTADDRESS/$HOST_ADDRESS/g" db.ini
sed -i "s/DBNAMEGAME/$DB_NAME_GAME/g" db.ini
sed -i "s/DBNAMELS/$DB_NAME_LS/g" db.ini
sed -i "s/MARIADBUSER/$MARIADB_USER/g" db.ini
sed -i "s/MARIADBPASSWORD/$MARIADB_PASSWORD/g" db.ini

sed -i "s/HOSTADDRESS/$HOST_ADDRESS/g" eqemu_config.json
sed -i "s/WORLDSERVERSHORTNAME/$WORLDSERVER_SHORT_NAME/g" eqemu_config.json
sed -i "s/WORLDSERVERLONGNAME/$WORLDSERVER_LONG_NAME/g" eqemu_config.json
sed -i "s/DBNAMEGAME/$DB_NAME_GAME/g" eqemu_config.json
sed -i "s/MARIADBUSER/$MARIADB_USER/g" eqemu_config.json
sed -i "s/MARIADBPASSWORD/$MARIADB_PASSWORD/g" eqemu_config.json

