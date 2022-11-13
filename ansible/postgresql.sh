#!/bin/bash
#update cache & upgrade
apt -y update && sudo apt -y upgrade
#instull GnuPG
apt install -y gnupg2
# add PostgreSQL APT Repository
sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
# Download PostgreSQL ASC Key
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
# Update APT Cache
apt -y update
#install PostgreSQL
apt -y install postgresql-15
#Create database
sudo -i -u postgress psql -c "CREATE DATABASE ansdb WITH ENCODING 'UTF8' TEMPLATE template0"
# Create user
sudo -i -u postgres psql -c "CREATE USER altschool WITH ENCRYPTED PASSWORD 'AnSdb12'"
# Grant user priviledge on database
sudo -i -u postgres psql -c "GRANT ALL PRIVILEDGES ON DATABASE ansdb to  altschool"
#configure user login method in pg_hba.conf
echo -e 'local\tall\t\altschool\t\t\t\t\tmds' >> /etc/postgresql/15/main/pg_hba.conf
#restart PostgreSQL
systemctl restart postgresql
#login as user
#psql -h localhost -U altschool -d ansdb

