#!/bin/bash
postgres_image=postgres:9
redmine_image=redmine:3.0.5
# 設定 redmine port
redmine_port=18888
# 設定 postgres port
postgres_port=15432
# 設定 redmine 附加檔案 data 路徑
redmine_file=/home/redmine/backup/data/files
# 設定 redmine DB 路徑
postgres_data=/home/redmine/backup/data/pg_data
# 設定 redmine 組態檔路徑
redmin_config_file=/home/redmine/backup/configuration.yml

pg_cid=$(docker run -d -p $postgres_port:5432 -v $postgres_data:/var/lib/postgresql/data -e POSTGRES_PASSWORD=redmine -e POSTGRES_USER=redmine $postgres_image)
pg_ip=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $pg_cid)

while [[ $(sh pg_connection_test.sh $pg_ip) != "ok" ]];
do
    sleep 1
    echo "wait postgresql ready, wait 1s ..."
done

redmine_cid=$(docker run -d -p $redmine_port:3000 -v $redmine_file:/usr/src/redmine/files --link $pg_cid:postgres $redmine_image)

echo "$redmine_cid" > containers
echo "$pg_cid" >> containers

cat $redmin_config_file | docker exec -i $redmine_cid /bin/bash -c 'cat >'/usr/src/redmine/config/configuration.yml