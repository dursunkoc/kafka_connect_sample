ARG DEBEZIUM_VERSION
FROM debezium/connect:$DEBEZIUM_VERSION
ENV KAFKA_CONNECT_JDBC_DIR=$KAFKA_CONNECT_PLUGINS_DIR/kafka-connect-jdbc \
    INSTANT_CLIENT_DIR=/instant_client/ \
    DEBEZIUM_CONNECTOR_ORACLE_DIR=$KAFKA_CONNECT_PLUGINS_DIR/debezium-connector-oracle

ARG POSTGRES_VERSION=42.2.8
ARG KAFKA_JDBC_VERSION=10.2.0
ARG KAFKA_ELASTICSEARCH_VERSION=5.3.2
ARG JMX_AGENT_VERSION

# Deploy PostgreSQL JDBC Driver
RUN cd /kafka/libs && curl -sO https://jdbc.postgresql.org/download/postgresql-$POSTGRES_VERSION.jar

# Deploy Kafka Connect JDBC
RUN mkdir $KAFKA_CONNECT_JDBC_DIR && cd $KAFKA_CONNECT_JDBC_DIR &&\
	curl -sO https://packages.confluent.io/maven/io/confluent/kafka-connect-jdbc/$KAFKA_JDBC_VERSION/kafka-connect-jdbc-$KAFKA_JDBC_VERSION.jar &&\
    cp $DEBEZIUM_CONNECTOR_ORACLE_DIR/* .

RUN mkdir /kafka/etc && cd /kafka/etc &&\
        curl -so jmx_prometheus_javaagent.jar \
        https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/$JMX_AGENT_VERSION/jmx_prometheus_javaagent-$JMX_AGENT_VERSION.jar

COPY config.yml /kafka/etc/config.yml
COPY connect-distributed.properties /kafka/config/connect-distributed.properties

RUN mkdir /kafka/connect/multiple-field-timestamp-converter/
COPY multiple-field-timestamp-converter-1.0.0-jar-with-dependencies.jar /kafka/connect/multiple-field-timestamp-converter/multiple-field-timestamp-converter-1.0.0-jar-with-dependencies.jar

USER root
RUN microdnf -y install libaio && microdnf clean all

USER kafka
# Deploy Oracle client and drivers

COPY oracle_instantclient/* $INSTANT_CLIENT_DIR
COPY oracle_instantclient/xstreams.jar /kafka/libs
COPY oracle_instantclient/ojdbc8.jar /kafka/libs
