#!/bin/bash

postgres_image=sameersbn/postgresql:9.4-12
redmine_image=fayehuang/redmine:1.0
redmine_port=80
postgres_port=5432
redmine_file=/root/redmine/data/files
postgres_data=/root/redmine/data/pg_data
postgres_passwd=password
postgres_user=redmine
postgres_db=redmine_production

pg_cid=$(docker run -d --volume $postgres_data:/var/lib/postgresql -e DB_NAME=$postgres_db -e DB_USER=$postgres_user -e DB_PASS=$postgres_passwd --name redmine-postgres $postgres_image)
pg_ip=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $pg_cid)

while [[ $(docker exec $pg_cid psql -d $postgres_db -U $postgres_user -c '\echo ok') != "ok" ]];
do
    sleep 1
    echo "wait postgresql ready, wait 1s ..."
done

echo $(docker exec $pg_cid psql -d $postgres_db -U $postgres_user -c '\echo ok')

docker run -d -p $redmine_port:80 -e REDMINE_PORT=$redmine_port -v $redmine_file:/home/redmine/data --name redmine --link redmine-postgres:postgresql $redmine_image
