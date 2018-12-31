#!/usr/bin/env sh
set -eo pipefail

WORK_DIR=/var/www/powerdns-admin

export FLASK_APP=app/__init__.py

echo "Run options"
if [ ! -z $SECRET_KEY ]; then
  sed -i "s|SECRET_KEY = 'We are the world'|SECRET_KEY = '${SECRET_KEY}'|g" $WORK_DIR/config.py
fi

if [ ! -z $PORT ]; then
  sed -i "s|PORT = 9191|PORT = ${PORT}|g" $WORK_DIR/config.py
fi

if [ ! -z $BIND_ADDRESS ]; then
  sed -i "s|BIND_ADDRESS = '0.0.0.0'|BIND_ADDRESS = '${BIND_ADDRESS}'|g" $WORK_DIR/config.py
fi

if [ ! -z $SQLA_DB_USER ]; then
  sed -i "s|SQLA_DB_USER = 'pdnsui'|SQLA_DB_USER = '${SQLA_DB_USER}'|g" $WORK_DIR/config.py
fi

if [ ! -z $UPLOAD_DIR ]; then
  sed -i "s|UPLOAD_DIR = os.path.join(basedir, '/upload')|UPLOAD_DIR = os.path.join(basedir, '${UPLOAD_DIR}')|g" $WORK_DIR/config.py
fi

if [ ! -z $SQLA_DB_PORT ]; then
  sed -i "s|SQLA_DB_PORT = 5432|SQLA_DB_PORT = ${SQLA_DB_PORT}|g" $WORK_DIR/config.py
fi

if [ ! -z $SQLA_DB_PASSWORD ]; then
  sed -i "s|SQLA_DB_PASSWORD = 'pdnsui'|SQLA_DB_PASSWORD = '${SQLA_DB_PASSWORD}'|g" $WORK_DIR/config.py
fi

if [ ! -z $SQLA_DB_HOST ]; then
  sed -i "s|SQLA_DB_HOST = '127.0.0.1'|SQLA_DB_HOST = '${SQLA_DB_HOST}'|g" $WORK_DIR/config.py
fi

if [ ! -z $SQLA_DB_NAME ]; then
  sed -i "s|SQLA_DB_NAME = 'pdnsui'|SQLA_DB_NAME = '${SQLA_DB_NAME}'|g" $WORK_DIR/config.py
fi

echo "Run migrate"
flask db migrate
flask db upgrade
yarn install --pure-lockfile
flask assets build

echo "Run admin"
./run.py