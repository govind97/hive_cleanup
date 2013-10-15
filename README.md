# Script for cleaning up hive tables

This is a simple script that can be run as a cron to delete hive tables after a 
predetermined number of days.

The git repository contains the following files:
* **README.md**  - A brief description of what this repository is for
* **cleanup_hdfs.sh**  - The script file that checks for the retention of hive tables as specified in the conf file
* **conf/hive_tables.conf**  - The configuration file used to specify the retention period. Each line in this file is an entry of the form
  `table_name:retention_period_in_days`

# How to Run:

The script can plainly be run by invoking it as `cleanup_hdfs.sh`

# Things to note:

For this to do the clean up succesfully, the script should be run by users who have permissions to delete hive tables
and the environment variables `HADOOP_HOME` and `HIVE_HOME` should be set correctly
