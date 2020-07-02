FROM debian:jessie
RUN apt-get update && apt-get install -y wget && apt-get clean
RUN cd /root && wget http://incrediblepbx.com/IncrediblePBX15-Wazo.sh
RUN chmod a+x /root/IncrediblePBX15-Wazo.sh
RUN /root/IncrediblePBX15-Wazo.sh
RUN /root/IncrediblePBX15-Wazo.sh
