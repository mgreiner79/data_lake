# ms_neo4j
FROM alpine:3.14

# setup linux
RUN adduser -S neo4j \
	&& apk --update upgrade \
	&& apk add --no-cache bash curl lsof openjdk8-jre-base

# download and install neo
RUN curl --fail --silent --show-error --location --output neo4j.tar.gz http://dist.neo4j.org/neo4j-community-3.5.26-unix.tar.gz \
	&& tar -xzf neo4j.tar.gz -C /var/lib \
	&& mv /var/lib/neo4j-* /var/lib/neo4j \
	&& rm neo4j.tar.gz \
	&& chown -R neo4j /var/lib/neo4j

# copy configuration file 
COPY conf/neo4j.conf conf/var/lib/neo4j/conf/

RUN mkdir /data \
	&& mkdir /data/databases \
	&& chown -R neo4j /data

# setup workdir and run
WORKDIR /var/lib/neo4j
USER neo4j
CMD bin/neo4j console
