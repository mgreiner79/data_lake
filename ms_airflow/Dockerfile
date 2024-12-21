# ms_airflow
FROM alpine:3.14

# define airflow env variables which can be overridden from docker compose
ENV AIRFLOW_HOME /home/airflow
ENV AIRFLOW_LOAD_EXAMPLES no
ENV AIRFLOW__CORE__LOAD_EXAMPLES false
ENV TZ Europe/Berlin


# setup linux with minimal libraries
RUN adduser -S airflow \
	&& apk --update upgrade \
	&& mkdir -p $AIRFLOW_HOME/dags \
	&& apk add --no-cache mariadb-dev dumb-init musl tzdata \
	  linux-headers \
	  alpine-sdk \
	  build-base \
	  ca-certificates \
	  python3 \
	  python3-dev \
	  py3-pip \
	  py3-setuptools \
	  py3-libxml2 \
	  openssh \
	  libffi-dev \
	  libxml2-dev \
	  libxslt-dev

# setup python libs
COPY requirements.txt $AIRFLOW_HOME/requirements.txt
RUN pip3 install --upgrade pip \
	&& pip3 install markupsafe==2.0.1 apache-airflow virtualenv \
	&& pip3 install -r $AIRFLOW_HOME/requirements.txt

ENV PYTHONPATH=/home/airflow/dags


# setup airflow
COPY run.sh /bin/run_af.sh
RUN chmod 555 /bin/run_af.sh \
	&& chown -R airflow $AIRFLOW_HOME

ARG AIRFLOW_ADMIN_USERNAME

ARG AIRFLOW_ADMIN_PASSWORD

	
# run as user airflow
USER airflow
