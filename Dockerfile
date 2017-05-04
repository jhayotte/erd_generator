FROM omerio/graphviz-server

ENV PATH=${PATH}:${GOPATH}/bin

RUN apt-get update

RUN apt-get --assume-yes install \
    python-pip python-dev\
    build-essential \
    graphviz-dev \
    ttf-freefont \
    && pip install --upgrade pip
    
RUN apt-get --assume-yes install \
    pkg-config \
    && pip install psycopg2 eralchemy

