FROM debian:buster
RUN apt-get update ; apt-get install -yqq build-essential curl unzip
RUN curl -L https://github.com/storj/storj/releases/latest/download/identity_linux_amd64.zip -o identity_linux_amd64.zip ; unzip -o identity_linux_amd64.zip ; chmod +x identity ; mv identity /usr/local/bin/identity ; identity create storagenode
RUN identity authorize storagenode xx@xx.com:xxx
