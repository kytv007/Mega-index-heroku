FROM ubuntu:latest
ARG DEBIAN_FRONTEND=noninteractive
RUN DEBIAN_FRONTEND=noninteractive
RUN apt update -y
RUN apt install unzip curl wget git expect -y

RUN git clone https://github.com/krishd9895/Mega-index-heroku; chmod +x /Mega-index-heroku/entrypoint.sh
CMD /Mega-index-heroku/entrypoint.sh
