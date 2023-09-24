FROM centos:7
MAINTAINER Nedorezov Alexander <alserned@gmail.com>

ENV ELASTIC_VERSION="8.10.2"

# Local files instead of wget
COPY elasticsearch-${ELASTIC_VERSION}-linux-x86_64.tar.gz /tmp
COPY elasticsearch-${ELASTIC_VERSION}-linux-x86_64.tar.gz.sha512 /tmp

# Install elasticsearch
RUN yum update -y \
    && cd /tmp \
    && yum -y install wget perl-Digest-SHA \
#    && wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${ELASTIC_VERSION}-linux-x86_64.tar.gz \
#    && wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${ELASTIC_VERSION}-linux-x86_64.tar.gz.sha512 \
    && shasum -a 512 -c elasticsearch-${ELASTIC_VERSION}-linux-x86_64.tar.gz.sha512 \
    && tar -xzvf ./elasticsearch-${ELASTIC_VERSION}-linux-x86_64.tar.gz -C / \
    && rm elasticsearch-${ELASTIC_VERSION}-linux-x86_64.tar.gz elasticsearch-${ELASTIC_VERSION}-linux-x86_64.tar.gz.sha512 \
    && mkdir /var/lib/data \
    && yum -y remove wget perl-Digest-SHA \
    && yum clean all



RUN groupadd elastic \
    && useradd -r -g elastic elastic \
    && chown -R elastic:elastic /elasticsearch-${ELASTIC_VERSION} /var/lib/data

USER elastic
WORKDIR /elasticsearch-${ELASTIC_VERSION}/
COPY --chmod=644 ./config/elasticsearch.yml  config/

EXPOSE 9200 9300
ENTRYPOINT ["bin/elasticsearch"]