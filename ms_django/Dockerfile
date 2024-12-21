# ms_django
FROM python:3.8-alpine

# setup linux system
RUN adduser -S django \
	&& apk --update upgrade \
	&& apk add --no-cache py3-psycopg2 py3-pip py3-django libffi-dev linux-headers build-base ca-certificates cmake bash autoconf

# setup env. 
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# define workdir 
WORKDIR /code

# install python libs 
COPY requirements.txt /code/
RUN pip install --upgrade pip \
	&& pip install -r /code/requirements.txt \
	&& chown -R django /code

# container is used for django and celery therefore entrypoint is defined in docker-compose.yml
USER django
