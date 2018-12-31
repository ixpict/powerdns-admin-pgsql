# Docker image for powerdns-admin with postgresql

Docker image for [powerdns-admin](https://github.com/ngoduykhanh/PowerDNS-Admin) with postgresql

# Usage
docker run --name pdnsadmin-test -e BIND_ADDRESS=0.0.0.0 \
  -e SECRET_KEY='a-very-secret-key' \
  -e PORT='9191' \
  -e SQLA_DB_USER='powerdns_admin_user' \
  -e SQLA_DB_PASSWORD='exceptionallysecure' \
  -e SQLA_DB_HOST='192.168.0.100' \
  -e SQLA_DB_NAME='powerdns_admin_test' \
  -v /data/node_modules:/var/www/powerdns-admin/node_modules
  -d -p 9191:9191 really/powerdns-admin:latest