ARG BUILD_FROM
FROM $BUILD_FROM

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

RUN echo $BUILD_FROM
RUN apt-get update && \
  apt-get install --no-install-recommends -y \
    ca-certificates \
    git \
    golang \
    librtlsdr-dev \
    python3-paho-mqtt \
    rtl-sdr && \
    rm -rf /var/lib/apt/lists/*
RUN go get github.com/bemasher/rtlamr

COPY settings_docker.py /amridm2mqtt/settings.py
COPY run.sh /amridm2mqtt/
RUN chmod a+x /amridm2mqtt/run.sh
COPY amridm2mqtt /amridm2mqtt/
RUN chmod a+x /amridm2mqtt/amridm2mqtt

ENTRYPOINT ["/amridm2mqtt/run.sh"]
