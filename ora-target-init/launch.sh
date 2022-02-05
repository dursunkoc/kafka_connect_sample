##setup database
echo "Entering Launch"
export ORACLE_SID=XE

echo "Generating database."
$ORACLE_HOME/bin/sqlplus sys/oracle as sysdba @/docker-entrypoint-initdb.d/db-init/setup_database.sql