ARG IMAGE=containers.intersystems.com/intersystems/iris:2022.1.0.209.0
FROM $IMAGE
USER root   

COPY  ECP_iris.key /usr/irissys/mgr/iris.key
COPY  messages.log /usr/irissys/mgr/

WORKDIR /opt/irisapp

RUN chmod 666 /usr/irissys/mgr/messages.log
RUN chmod 666 /usr/irissys/mgr/iris.key 
RUN chown irisowner:irisowner /opt/irisapp      

USER irisowner

COPY src src
COPY module.xml module.xml
COPY iris.script iris.script

RUN iris start IRIS \
	&& iris session IRIS < iris.script \
    && iris stop IRIS quietly
