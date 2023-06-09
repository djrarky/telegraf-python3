FROM telegraf:latest
LABEL org.opencontainers.image.source="https://github.com/djrarky/telegraf-python3"

RUN \
# Install python3, git & pip
  apt update && \
  apt install -y git python3-pip && \
# make script directory
  mkdir /opt/scripts && \
# download my scripts
  git config --global --add safe.directory /opt/scripts && \
  git clone https://github.com/djrarky/huawei-lte-telegraf.git /opt/scripts/huawei-lte-telegraf && \
  git clone https://github.com/djrarky/huawei-hg612-telegraf.git /opt/scripts/huawei-hg612-telegraf && \
  git clone https://github.com/djrarky/tplink-hs110-telegraf.git /opt/scripts/tplink-hs110-telegraf && \
# install python requirements
  pip install -r /opt/scripts/tplink-hs110-telegraf/requirements.txt && \
  pip install -r /opt/scripts/huawei-lte-telegraf/requirements.txt && \
# cleanup
  apt clean
  
VOLUME /opt/scripts
