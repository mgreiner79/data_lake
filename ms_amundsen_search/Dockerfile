# ms_amundsen
FROM alpine:3.14

RUN adduser -S amundsen \
	&& apk --update upgrade \
	&& apk add --virtual=build_dependencies --no-cache alpine-sdk python3 python3-dev py3-flask py3-pip git libffi-dev

WORKDIR /home
RUN git clone -b search-3.1.0 https://github.com/amundsen-io/amundsen \
	&& chown -R amundsen /home/amundsen

# run further packages as amundsen user
USER amundsen
WORKDIR /home/amundsen
RUN pip install --upgrade pip \
	&& pip install gunicorn flasgger==0.9.5 flask_cors==3.0.10 flask-restful==0.3.9 boto3==1.21.29 marshmallow3_annotations==1.0.0 requests_aws4auth==1.1.2 \
	&& pip install -r /home/amundsen/search/requirements.txt \
	&& pip install -r /home/amundsen/metadata/requirements.txt \
	&& pip install -r /home/amundsen/frontend/requirements.txt

ENV PYTHONPATH /home/amundsen/metadata:/home/amundsen/search:/home/amundsen/databuilder:/home/amundsen/common:/home/amundsen/frontend
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/amundsen/.local/bin

WORKDIR /home/amundsen

CMD gunicorn -w 2 --bind :5000 search_service.search_wsgi
