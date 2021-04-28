FROM ubuntu

WORKDIR /opt/
COPY * /opt/
EXPOSE 3310
RUN apt update && apt install -fy clamav-freshclam clamav-daemon && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /var/run/clamav/ /var/lib/clamav/


CMD ["bash", "/opt/startup.sh"]
