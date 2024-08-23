FROM ubuntu:latest

RUN apt update && apt upgrade -y
RUN apt install -y curl
RUN curl https://raw.githubusercontent.com/rafaellrossi/novnc-ubuntu-openbox/main/install.sh | bash

CMD ["tail", "-f", "/dev/null"]
