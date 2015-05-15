FROM debian:latest
MAINTAINER Thomas Labarussias <https://github.com/Issif>

# Env variables
ENV es_version 1.5.2
ENV kibana_version 3.1.2

# Install java & python
RUN apt-get update
RUN apt-get install -y -q wget curl openjdk-7-jre-headless python2.7
RUN ln -s /usr/bin/python2.7 /usr/bin/python
RUN apt-get install -y -q python-pip
RUN pip install tornado

# Install elasticsearch
EXPOSE 9200
RUN useradd -m elasticsearch

WORKDIR /home/elasticsearch

RUN wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-${es_version}.tar.gz -O - | tar --strip 1 -xzf -
RUN mkdir /home/elasticsearch/kibana
RUN wget https://download.elastic.co/kibana/kibana/kibana-${kibana_version}.tar.gz -O - | tar --strip 1 -xzf - -C /home/elasticsearch/kibana/

RUN echo "http.cors.enabled: true" >> /home/elasticsearch/elasticsearch.yml 

# Ports to exposes
EXPOSE 8080 
EXPOSE 9200 

# Add import script
ADD src/index_emails.py /home/elasticsearch/index_emails.py
ADD start.sh /home/elasticsearch/start.sh
RUN chmod +x index_emails.py && chmod +x start.sh

ENTRYPOINT /home/elasticsearch/start.sh
