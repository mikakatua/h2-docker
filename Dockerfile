FROM eclipse-temurin:11

ENV JAVA_OPTIONS=""
ENV H2_OPTIONS=""
ENV H2_VERSION="2.1.214"
ENV DATA_DIR=/data 

RUN curl -L -o /opt/h2.jar https://github.com/h2database/h2database/releases/download/version-${H2_VERSION}/h2-${H2_VERSION}.jar

# Web Console port
EXPOSE 8082
# H2 Server port
EXPOSE 9092

# Volume containing the H2 data
VOLUME $DATA_DIR

CMD java $JAVA_OPTIONS -cp /opt/h2.jar org.h2.tools.Server \
    -web -webPort 8082 -webAllowOthers \
    -tcp -tcpPort 9092 -tcpAllowOthers \
    -baseDir $DATA_DIR $H2_OPTIONS
