# ms_superset
FROM alpine:3.14

# overridden when started from docker compose
ENV TZ Europe/Berlin
ENV FLASK_APP superset

# setup linux 
RUN adduser -S superset \
	&& apk --update upgrade \
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
	  py3-six \
	  py3-wheel \
	  py3-pytest \
	  py3-psycopg2 \
	  py3-arrow \
	  py3-flask \
	  py3-pandas \
	  py3-virtualenv \
	  cython \
	  openssh \
	  libffi-dev \
	  libxml2-dev \
	  libxslt-dev \
	  libressl-dev sdl2-dev openldap-dev cyrus-sasl-dev \
	  cmake bash boost-dev autoconf zlib-dev flex bison jpeg-dev g++

# setup python specific for superset
RUN pip3 install --upgrade pip \
	&& pip3 install --no-cache-dir virtualenv numpy==1.22.0 pandas==1.2.5 cython MarkupSafe==2.0.0 Pillow==8.3.0 Flask-Caching

# install libjemalloc needed for superset 
RUN wget -O - https://github.com/jemalloc/jemalloc/releases/download/5.2.1/jemalloc-5.2.1.tar.bz2 | tar -xj && \
    cd jemalloc-5.2.1 && \
    ./configure && \
    make && \
    make install

# install arrow; todo maybe try py3-arrow instead
ENV ARROW_BUILD_TYPE=release
ENV ARROW_HOME=/usr/local
ENV PARQUET_HOME=/usr/local
ENV PYARROW_WITH_DATASET 1
ENV PYARROW_WITH_PARQUET 1

RUN git clone -b release-4.0.1 https://github.com/apache/arrow.git \
	&&  mkdir /arrow/cpp/build    

WORKDIR /arrow/cpp/build
#disable backtrace
RUN sed -i -e '/_EXECINFO_H/,/endif/d' -e '/execinfo/d' ../src/arrow/util/logging.cc
# run cmake and make
RUN cmake -DCMAKE_BUILD_TYPE=$ARROW_BUILD_TYPE \
          -DCMAKE_INSTALL_LIBDIR=lib \
          -DCMAKE_INSTALL_PREFIX=$ARROW_HOME \
          -DARROW_PARQUET=on \
          -DARROW_PYTHON=on \
          -DARROW_PLASMA=on \
          -DARROW_BUILD_TESTS=off \
		  ..\
		&& make -j$(nproc) \
		&& make install

WORKDIR /arrow/python
RUN python3 setup.py build_ext --build-type=$ARROW_BUILD_TYPE --with-parquet \
	&& python3 setup.py install

WORKDIR /
# finally install superset
RUN pip3 install --no-cache-dir apache-superset==1.4.0

# setup and run superset 
ENV CACHE_TYPE SimpleCache
ENV FLASK_ENV development
ENV SUPERSET_ENV development
ENV SUPERSET_LOAD_EXAMPLES yes
ENV CYPRESS_CONFIG false
ENV SUPERSET_PORT 8088
ENV PYTHONPATH /usr/lib/python3.9/site-packages
#ENV FLASK_APP superset

RUN superset db upgrade \
	&& superset init \
	&& superset fab create-admin --username admin --firstname admin --lastname admin --email admin@admin.de --password admin 


# runs only as root...
#USER superset
WORKDIR /home/superset
CMD superset run --host=0.0.0.0 -p 8088 --with-threads --reload --debugger
