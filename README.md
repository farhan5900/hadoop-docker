# Apache Hadoop Docker image

This docker image is most suitable for DC/OS. Container of this image start by accepting hadoop daemon name (namenode|secondarynamenode|datanode|journalnode|dfs|dfsadmin|fsck|balancer|zkfc) as a parameter. It will run image with given hadoop-daemon. You can also run image by passing any valid executable shell name (bash|sh).

## Quick Start

To build the docker image, run:
```
  docker build -t <docker_id>/hadoop:2.7.7 .
```

To run the docker image, run:
```
  docker run -ti <docker_id>/hadoop:2.7.7 <hadoop_daemon> <args>
```

## Configure Environment Variables

The configuration parameters can be specified as environmental variables for specific services (e.g. namenode, datanode etc.):
```
  CORE_CONF_fs_defaultFS=hdfs://namenode:8020
```

CORE_CONF corresponds to core-site.xml. fs_defaultFS=hdfs://namenode:8020 will be transformed into:
```
  <property><name>fs.defaultFS</name><value>hdfs://namenode:8020</value></property>
```
To define dash inside a configuration parameter, use triple underscore, such as YARN_CONF_yarn_log___aggregation___enable=true (yarn-site.xml):
```
  <property><name>yarn.log-aggregation-enable</name><value>true</value></property>
```

The available configurations are:
* /etc/hadoop/core-site.xml CORE_CONF
* /etc/hadoop/hdfs-site.xml HDFS_CONF
* /etc/hadoop/yarn-site.xml YARN_CONF
* /etc/hadoop/httpfs-site.xml HTTPFS_CONF
* /etc/hadoop/kms-site.xml KMS_CONF

If you need to extend some other configuration file, refer to entrypoint.sh script.

