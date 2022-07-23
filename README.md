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

## Using the web console
Open the url http://localhost:8082 in your browser
