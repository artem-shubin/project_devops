#!/bin/bash
echo "Backup started"
time_stamp=$(date +%d.%m.%g__%H.%M.%S)
cd /home/ubuntu/dumps/
sudo cp -a /var/lib/mysql/zabbix /home/ubuntu/dumps/zabbix
sudo rm /home/ubuntu/dumps/zabbix/widget.ibd
sudo zip -r zabbix.zip zabbix
file=production_database_$time_stamp.zip
sudo mv zabbix.zip $file
aws s3 cp $file s3://bucket-for-dump-database-mysql/$file
sudo rm -r $file
sudo rm -r zabbix
