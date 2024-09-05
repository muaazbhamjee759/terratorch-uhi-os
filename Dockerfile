#FROM pytorch/pytorch:latest
FROM ghcr.io/foundation-model-stack/base:pytorch-compile-latest-nightly-20240825

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get autoremove -y

RUN apt-get install nano -y
RUN apt-get install git -y

ENV SERVICE_DIR=/opt/terratorch
ENV ROOT_SERVICE=/opt/
ENV DEBIAN_FRONTEND=noninteractive
ENV PIP_ROOT_USER_ACTION=ignore 
ENV SRC_DIR=${SERVICE_DIR}/src

RUN mkdir -p ${SERVICE_DIR}/
WORKDIR ${SERVICE_DIR}

COPY . .
RUN chmod -R 777 ${SERVICE_DIR}

#RUN python -m pip install --upgrade pip
#RUN git clone https://github.com/open-mmlab/mmcv.git
#RUN pip install -r mmcv/requirements/optional.txt
#RUN nvcc --version
#RUN cd ${SERVICE_DIR}
RUN pip install -r requirements/required.txt 
RUN pip install -r requirements/dev.txt
RUN pip install -e .

RUN pip cache purge