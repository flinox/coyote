
FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive
ENV GOPATH /go
ENV PATH ${PATH}:${GOPATH}/bin:/usr/local/go/bin


RUN apt-get update && apt-get install -y apt-utils

RUN apt-get install -y net-tools netcat curl wget apt-transport-https

RUN apt-get install -y git nano python3 jq gnupg2 zip unzip sqlite3 libsqlite3-dev

RUN apt-get install -y default-jre default-jdk

RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list

RUN wget -qO - http://packages.confluent.io/deb/3.1/archive.key | apt-key add - && echo "deb [arch=amd64] http://packages.confluent.io/deb/3.1 stable main" | tee -a /etc/apt/sources.list.d/confluent.list

RUN apt-get update && apt-get install -y kubectl kafkacat confluent-platform-oss-2.11

RUN wget https://dl.google.com/go/go1.12.5.linux-amd64.tar.gz -P /tmp/ && tar -C /usr/local -xzf /tmp/go1.12.5.linux-amd64.tar.gz && go version

# RUN mkdir /opt/gradle && wget https://services.gradle.org/distributions/gradle-5.4.1-bin.zip -P /opt/gradle && unzip -d /opt/gradle /opt/gradle/gradle-5.4.1-bin.zip

#RUN mkdir /git && cd /git && git clone https://github.com/Landoop/kafka-connect-tools.git 

#RUN cd /git/kafka-connect-tools && gradle buildCli


WORKDIR /go


# docker build -t flinox/kafka_client .
# docker run -it --rm --hostname go --name go flinox/go

