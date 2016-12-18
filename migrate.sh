#!/bin/bash -x

MYSQL=`which mysql`
MYSQLDUMP=`which mysqldump`

REMOTEUSER="root"
REMOTEPASS="remotepasshere"
REMOTESERVER="remoteiphere"
IGNOREDBS="(Database|information_schema|performance_schema)"

databases=`$MYSQL -e "SHOW DATABASES;" | grep -Ev "$IGNOREDBS"`

for db in $databases; do
  echo "backup for $db started".
  echo  `date`
  $MYSQL -h "$REMOTESERVER" -u "$REMOTEUSER" -p"$REMOTEPASS" -e "create database $db" && $MYSQLDUMP --force --opt --databases $db | $MYSQL -h $"REMOTESERVER" -u "REMOTEUSER" -p"$REMOTEPASS" $db
  echo "backup for $db finished"
  echo `date`
  echo ==================
done

flush=`$MYSQL -h "$REMOTESERVER" -u "$REMOTEUSER" -p"$REMOTEPASS" -e "flush privileges"`
