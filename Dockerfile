FROM ubuntu:18.04

USER root

# this is a non-interactive automated build - avoid some warning messages
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update && \
	apt-get -y upgrade && \
	apt-get install -y \
		software-properties-common unzip \
                ca-certificates \
                openssh-client \
                curl \
		openssl \
		wget \
		gnupg2 \
		openjdk-8-jre \
		openjdk-8-jdk

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/

# remove download archive files
RUN apt-get clean

# Download Talend Open Studio for ESB
RUN curl -sSo /opt/TOS_ESB-20181026_1147-V7.1.1.zip https://download-mirror2.talend.com/esb/release/V7.1.1/TOS_ESB-20181026_1147-V7.1.1.zip > /dev/null

# Install Talend Open Studio for ESB
RUN unzip /opt/TOS_ESB-20181026_1147-V7.1.1.zip -d /opt/TOS_ESB && \
	rm /opt/TOS_ESB-20181026_1147-V7.1.1.zip && \
	rm -rf /opt/TOS_ESB/Studio && \	
	chmod 777 /opt/TOS_ESB/Runtime_ESBSE/container/bin/trun && \
 	chmod 777 /opt/TOS_ESB/Runtime_ESBSE/container/bin/start

VOLUME ["/opt/TOS_ESB/Runtime_ESBSE/container/deploy"]

EXPOSE 1099 8040/tcp 8080 8101 8181 8443 9001 44444
