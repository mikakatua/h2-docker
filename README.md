# Containerized H2 database
The container runs an H2 database in server mode.

## Build the container image
```
docker build -t h2-server .
```

## Run the H2 container
```
docker run -d -p 8082:8082 -p 9092:9092 --name h2 h2-server
```

## Create a database
```
docker exec h2 java -cp /opt/h2.jar org.h2.tools.Shell -url jdbc:h2:/data/db1 -user sa -password pass -sql ""
```

## Connect to the database
Open the url http://localhost:8082 in your browser to access the web console. The JDBC urls are:
* Embedded: `jdbc:h2:/data/db1`
* Server: `jdbc:h2:tcp://localhost:9092/db1`

## Online backup
The `BACKUP` SQL statement creates a zip file with the database file. The resulting backup is transactionally consistent.
```
docker exec h2 sh -c "NOW=$(date +%F_%R); \
  java -cp /opt/h2.jar org.h2.tools.Shell \
  -url jdbc:h2:tcp://localhost:9092/db1 -user sa -password pass \
  -sql \"BACKUP TO '\$DATA_DIR/db1-\$NOW.zip'\""
```

The Backup tool (`org.h2.tools.Backup`) can not be used to create a online backup; the database must not be in use while running this program.

> :warning: Creating a backup by copying the database files while the database is running is not supported, except if the file systems support creating snapshots. With other file systems, it can't be guaranteed that the data is copied in the right order.

