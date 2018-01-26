FROM ubuntu

RUN apt-get update
RUN apt-get install -y \
  flex \
  bison \
  g++ \
  make

WORKDIR /code
CMD /bin/bash
