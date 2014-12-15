FROM ubuntu:14.04
MAINTAINER Jacob Vallejo <jake@jahkeup.com>

RUN apt-get update && \
    apt-get install -y python-software-properties software-properties-common && \
    apt-add-repository ppa:saltstack/salt && \
    apt-get update && \
    apt-get install -y salt-minion && \
    apt-get clean
RUN echo "file_client: local" >> /etc/salt/minion

CMD ["/bin/bash"]

