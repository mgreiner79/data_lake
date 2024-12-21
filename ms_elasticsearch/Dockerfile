# ms_elastic can only be installed on ubi minimal 
FROM redhat/ubi8-minimal:8.5-240

# set up linux system
RUN microdnf update \
	&& microdnf install java-11-openjdk-devel curl bash openssl tar gzip shadow-utils sudo procps \
	&& microdnf clean all \
	&& useradd elastic

# download and install elastic
RUN curl --fail --silent --show-error --location --output ess.tar.gz https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.17.0-linux-x86_64.tar.gz \
	&& tar -xzf ess.tar.gz -C /var/lib \
	&& mv /var/lib/elasticsearch-* /var/lib/elasticsearch \
	&& rm ess.tar.gz

# export as user elastic
RUN mkdir /var/lib/elasticsearch/data \
	&& chgrp -R elastic /var/lib/elasticsearch \
	&& chown -R elastic /var/lib/elasticsearch

# copy config file
COPY elasticsearch.yml /var/lib/elasticsearch/config/

# dont run from root user
USER elastic
WORKDIR /var/lib/elasticsearch

# sentup elastic env vars 
ENV ES_JAVA_HOME /usr/lib/jvm/java-11-openjdk
ENV ES_HOME /var/lib/elasticsearch

CMD bin/elasticsearch
