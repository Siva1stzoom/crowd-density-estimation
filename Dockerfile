FROM ubuntu:focal-20210416
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    tzdata \
    sudo
RUN apt-get update && apt-get install software-properties-common -y 
RUN add-apt-repository -y ppa:deadsnakes/ppa
RUN apt-get install -y python3.8 \
    python3-pip \
    python-is-python3
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.8 1
RUN apt-get install ffmpeg libsm6 libxext6  -y
ENV TZ="America/New_York"
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
COPY ./flaskapp /usr/src/flaskapp
RUN chmod +x -R /usr/src/
WORKDIR /usr/src/flaskapp
RUN pip install -r requirements.txt
CMD ["/usr/src/flaskapp/run.sh"]