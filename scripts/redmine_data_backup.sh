#/bin/bash
LOG=/home/redmine/backup/backup.log

datetime=$(date +"%Y-%m-%d, %H:%M")
source_dir=/root/redmine/data
destination_dir=/home/redmine/backup
redmine_cid=eb2048fb04cf
rm -rf $destination_dir/*
docker exec $redmine_cid cat /usr/src/redmine/config/configuration.yml > $destination_dir/configuration.yml
response=$(cp -r $source_dir $destination_dir)

if [ -z $response ]
then
  echo "$datetime copy $source_dir to $destination_dir" >> $LOG
else
  echo "$datetime $response" >> $LOG
fi