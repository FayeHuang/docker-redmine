#/bin/bash
BACKUP_REDMINE_DATA=/home/redmine/scripts/redmine_data_backup.sh

sed -i "/redmine_data_backup/d" /etc/crontab
# everyday 00:00
echo "0 0 * * * root $BACKUP_REDMINE_DATA >> /dev/null 2>&1" >> /etc/crontab
# every 5 minuites
#echo "*/5 * * * * root $BACKUP_REDMINE_DATA >> /dev/null 2>&1" >> /etc/crontab
echo "done"