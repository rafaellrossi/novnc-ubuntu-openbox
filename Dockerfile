FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt upgrade -y && \
    apt install -y curl && \
    curl -o /usr/local/bin/install.sh https://raw.githubusercontent.com/rafaellrossi/novnc-ubuntu-openbox/main/install.sh && \
    chmod +x /usr/local/bin/install.sh

CMD ["/bin/bash", "-c", "/usr/local/bin/install.sh && tail -f /dev/null"]
