# looks like we need to version pin on 11.3 from the requirements.txt
FROM nvidia/cuda:11.3.1-cudnn8-devel-ubuntu20.04 as base

#RUN apt-get update
#RUN apt-get install -y wget vim

RUN apt update && \
    apt upgrade -y

RUN apt install -y --no-install-recommends wget vim python3 pip

ENV APP=/app
RUN mkdir -p $APP
WORKDIR $APP

# upgrade pip & install
RUN pip install --upgrade pip
COPY ./requirements.txt .
RUN pip install -r requirements.txt

COPY . $APP
RUN python3 setup.py install

RUN addgroup --gid 1000 --system app && adduser --system --uid 1000 --group app
RUN chown -R app:app /home/app
ENV APP_HOME=/home/app
WORKDIR $APP_HOME
RUN chown -R app:app $APP_HOME
USER app
