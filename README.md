# Repository to build ConfD docker container with custom YANG module

To create the docker container add the ConfD installer to this directory. Dockerfile uses "confd-basic-6.6.linux.x86_64.installer.bin". If you are using different installer, change the docker file.

To build the container use the following command:

```docker build -t <container_name> . --build-arg yangfile=<YANG_file_name>```

The Dockerfile tries to use the <YANG_file_name>.yang, if arg is not specified, the Dockerfile will try to use the configuration.yang.

You can start containers by using the following command:

```./docker-start.sh start <#_of_instances>```

To stop and delete all containers use the following command:

```./docker-start.sh stop```

The script will map the NETCONF and SSH ports:
* NETCONF port: (4000 + instance_id)
* SSH port: (5000 + instance_id)


