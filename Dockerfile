ARG IMAGE=intersystemsdc/iris-community
FROM $IMAGE
USER root   

COPY  ECP_iris.key /usr/irissys/mgr/iris.key
COPY  messages.log /usr/irissys/mgr/

WORKDIR /opt/irisapp

RUN chmod 666 /usr/irissys/mgr/messages.log
RUN chmod 666 /usr/irissys/mgr/iris.key 
RUN chown irisowner:irisuser /opt/irisapp      

USER irisowner

COPY src src
COPY module.xml module.xml
COPY iris.script iris.script

RUN iris start IRIS \
	&& iris session IRIS < iris.script \
    && iris stop IRIS quietly
