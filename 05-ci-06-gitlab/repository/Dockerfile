FROM centos:7 as builder
LABEL authors="nedorezov"

ARG PYTHON_VERSION=3.9.18
ARG APP_PORT=5290

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN yum install gcc openssl-devel bzip2-devel libffi libffi-devel wget make -y && \
    wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz  && \
    tar -xzf Python-${PYTHON_VERSION}.tgz &&  \
    rm Python-${PYTHON_VERSION}.tgz && \
    yum clean all &&  \
    rm -rf /var/cache/yum/*

WORKDIR /Python-${PYTHON_VERSION}
RUN ./configure --enable-optimizations && \
    make altinstall && \
    cd ../ && rm -rf /Python-${PYTHON_VERSION}

FROM centos:7

EXPOSE ${APP_PORT}
COPY --from=builder /usr/local/include/python3.9/ /usr/local/include/python3.9/
COPY --from=builder /usr/local/lib/python3.9/ /usr/local/lib/python3.9/
COPY --from=builder /usr/local/bin/python3.9 /usr/local/bin/python3.9
RUN groupadd --gid 1001 --system app &&  \
    adduser --uid 1001 --gid app --create-home --system app
USER app

WORKDIR /python_api
COPY --chown=app requirements.txt requirements.txt
RUN python3.9 -m pip install -r requirements.txt
COPY --chown=app python-api.py python-api.py

ENTRYPOINT ["python3.9", "python-api.py"]