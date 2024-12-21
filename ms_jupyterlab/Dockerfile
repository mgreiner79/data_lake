# ms_jupyterlab
FROM alpine:3.14

# setup linux system
RUN adduser -S jupyterlab \
	&& apk --update upgrade \
	&& apk add --virtual=build_dependencies --no-cache alpine-sdk autoconf automake bash boost-dev build-base ca-certificates cmake cyrus-sasl-dev cython dumb-init gcc g++ gfortran jpeg-dev lapack lapack-dev libc-dev libffi-dev libgcc libgfortran libquadmath libressl-dev libstdc++ libxml2-dev libxslt-dev linux-headers make musl musl-dev nodejs npm openblas openblas-dev openldap-dev openssh py3-arrow py3-libxml2 py3-numpy py3-pandas py3-pip py3-psycopg2 py3-pytest py3-scipy py3-matplotlib py3-setuptools py3-six py3-wheel python3 python3-dev sdl2-dev tzdata zlib-dev 

# setup python libs and jupyter extensions
COPY python_libs.txt .
RUN pip install --upgrade pip
RUN pip install cython jupyter jupyterlab jupyterlab-git \
	&& pip install -r ./python_libs.txt
	

# gitlab extension not working	
#RUN /usr/bin/jupyter serverextension enable --py jupyterlab --sys-prefix
#RUN jupyter labextension install @jupyterlab/git
#RUN jupyter lab build
#RUN jupyter serverextension enable --py jupyterlab_git

# notebook dir to be mounted
RUN mkdir /notebooks \
	&& chown -R jupyterlab /notebooks 

# switch user and run command 
USER jupyterlab
CMD /usr/bin/jupyter lab --no-browser --ip=0.0.0.0 --NotebookApp.notebook_dir=/notebooks --allow-root --NotebookApp.token=''