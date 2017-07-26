FROM parity/parity:v1.6.9
MAINTAINER Dennis-Florian Herr <herrdeflo@gmail.com>

RUN sudo apt-get update -y && sudo apt-get install -y curl git build-essential
RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
RUN sudo apt-get update -y && sudo apt-get install -y nodejs

ADD /src /petichain

RUN cd /petichain && sudo npm i -g webpack && ./init.sh && webpack
RUN cp /petichain/app/manifest.json /petichain/build/manifest.json
RUN sudo mkdir -p /root/.local/share/io.parity.ethereum/dapps
RUN cp /petichain/config.toml /root/.local/share/io.parity.ethereum/config.toml
RUN sudo ln -s /petichain/build /root/.local/share/io.parity.ethereum/dapps/PetiChain
