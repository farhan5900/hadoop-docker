FROM ubuntu:16.04

RUN apt-get update -qq \
    && apt-get install -qqy --no-install-recommends openjdk-8-jdk \
         openssh-server \
         openssh-client \
         curl \
    && rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
ENV HADOOP_VERSION 2.7.7
ENV HADOOP_URL https://www-us.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz

RUN set -x \
    && curl -fSL "$HADOOP_URL" -o /tmp/hadoop.tar.gz \
    && tar -xf /tmp/hadoop.tar.gz -C /opt/ \
    && rm /tmp/hadoop.tar.gz*

RUN ln -s /opt/hadoop-$HADOOP_VERSION/etc/hadoop /etc/hadoop
RUN cp /etc/hadoop/mapred-site.xml.template /etc/hadoop/mapred-site.xml
RUN mkdir /opt/hadoop-$HADOOP_VERSION/logs /hdfs

ENV HADOOP_PREFIX=/opt/hadoop-$HADOOP_VERSION
ENV HADOOP_CONF_DIR=/etc/hadoop
ENV PATH $HADOOP_PREFIX/bin/:$PATH

ADD hadoop-fg $HADOOP_PREFIX/bin/hadoop-fg
ADD entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh $HADOOP_PREFIX/bin/hadoop-fg

EXPOSE 8020

ENTRYPOINT ["/entrypoint.sh"]
