#!/bin/bash -xe

dnf install mariadb105-server -y
systemctl enable mariadb
systemctl start mariadb

mysqladmin -u root password "${db_root_password}"

cat <<EOF > /tmp/db.sql
CREATE DATABASE ${db_name};
CREATE USER '${db_user}' IDENTIFIED BY '${db_password}';
GRANT ALL PRIVILEGES ON *.* TO '${db_user}'@'%';
FLUSH PRIVILEGES;
EOF

mysql -u root -p${db_root_password} < /tmp/db.sql