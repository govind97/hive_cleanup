#!/bin/bash

CONF_FILE=conf/hive_tables.conf
CURRENT_DATE=`date -u "+%Y-%m-%d %H:%M:%S"`
CURRENT_EPOCH=`date -j -f "%Y-%m-%d %H:%M:%S" "$CURRENT_DATE" +%s` 

function delete_hive_table()
{
    `$HIVE_HOME/bin/hive -e "drop table $1"`
}

# Get the difference between the fs stat and the
# current date. If that is greater than the
# retention period, drop the table

while IFS=':' read table time; do
  
  retention_period=$(($time*86400))
  created_date=`$HADOOP_HOME/bin/hadoop fs -stat /user/hive/warehouse/$table`
  created_epoch=`date -j -f "%Y-%m-%d %H:%M:%S" "$created_date" +%s`
  difference=$(($CURRENT_EPOCH - $created_epoch))
  if [ $difference -le $retention_period ]
  then
    delete_hive_table $table  
  fi

done < $CONF_FILE
