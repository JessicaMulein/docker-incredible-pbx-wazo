FROM ubuntu:18.04
# export DEBIAN_FRONTEND="noninteractive"
ARG DEBIAN_FRONTEND=noninteractive
RUN mkdir -p /root
WORKDIR /root
RUN apt-get update && apt-get -qq -y install wget sudo iptables build-essential ca-certificates apt-utils logrotate subversion

RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main" >> /etc/apt/sources.list.d/postgresql.list
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
ADD packages.list /root/packages.list
RUN apt-get update && cat /root/packages.list | xargs apt-get -q -y install

RUN wget http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-16-current.tar.gz
RUN tar -zxf asterisk-16-current.tar.gz
RUN cd asterisk-16.*/ && contrib/scripts/get_mp3_source.sh && contrib/scripts/install_prereq install && ./configure 
RUN cd asterisk-16.*/ && make -j2
RUN cd asterisk-16.*/ && make install

RUN wget http://incrediblepbx.com/IncrediblePBX15-Wazo.sh
RUN chmod a+x IncrediblePBX15-Wazo.sh
RUN ./IncrediblePBX15-Wazo.sh
RUN ./IncrediblePBX15-Wazo.sh
RUN apt-get clean
#RUN dpkg-query -f '${binary:Package}\n' -W > packages.list && echo "----" && cat packages.list && echo "----"
# Add Tini
ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

