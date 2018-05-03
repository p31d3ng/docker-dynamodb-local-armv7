FROM openjdk:8-jre

MAINTAINER Pei Deng

RUN mkdir /var/dynamodb_local

WORKDIR /var/dynamodb_local

VOLUME ["/dynamodb_local_db"]

ENV DYNAMODB_VERSION=2018-04-11

RUN curl -O https://s3-us-west-2.amazonaws.com/dynamodb-local/dynamodb_local_${DYNAMODB_VERSION}.tar.gz && \
    tar zxvf dynamodb_local_${DYNAMODB_VERSION}.tar.gz && \
    rm dynamodb_local_${DYNAMODB_VERSION}.tar.gz

EXPOSE 8000

RUN wget https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/sqlite4java/libsqlite4java-linux-armv7a.so -O ./DynamoDBLocal_lib/libsqlite4java-linux-arm.so

CMD ["java","-Djava.library.path=./","-jar", "DynamoDBLocal.jar","-port", "8000","--sharedDb", "-dbPath", "/dynamodb_local_db"]
