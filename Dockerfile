FROM pytorch/pytorch:latest

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get autoremove -y

RUN apt-get install nano

ENV SERVICE_DIR=/opt/terratorch
ENV ROOT_SERVICE=/opt/
ENV DEBIAN_FRONTEND=noninteractive
ENV PIP_ROOT_USER_ACTION=ignore 
ENV SRC_DIR=${SERVICE_DIR}/src

RUN mkdir -p ${SERVICE_DIR}/
WORKDIR ${SERVICE_DIR}

COPY . .
RUN chmod -R 777 ${SERVICE_DIR}

RUN pip install --upgrade pip
RUN pip install -r requirements/required.txt -r requirements/dev.txt
RUN pip install -e .

RUN pip cache purge