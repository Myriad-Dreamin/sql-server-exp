docker pull microsoft/mssql-server-linux:latest
docker run -d -p 1433:1433 --name sql-server -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=<xX123456>' microsoft/mssql-server-linux:latest
# docker cp ./create-database-source.sql sql-server:/
# docker cp ./drop-database-source.sql sql-server:/
chmod +x ./open-sql.sh
docker cp ./open-sql.sh sql-server:/
chmod +x ./exec.sh
docker cp ./exec.sh sql-server:/
