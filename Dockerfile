#FROM debian
#MAINTAINER Alexander Reitzel
#ADD script/docker/provision.sh /root/provision.sh
#RUN chmod +x /root/provision.sh
#RUN /root/provision.sh
#ADD . /java-skeleton
#ENTRYPOINT ["/java-skeleton/bin/js"]
FROM maven:3.8.6-openjdk-18
ADD . /java-skeleton
WORKDIR /java-skeleton
