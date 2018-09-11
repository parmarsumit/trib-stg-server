
FROM ubuntu:16.04

RUN apt-get update
RUN add-apt-repository ppa:jonathonf/python-3.6
RUN apt-get update -y && \
    apt-get install -y python3.6 python3-pip python3-pil python3.6-dev build-essential git curl wget && \
    git clone https://github.com/Tribute-coop/server && \
    cd server/ && \
    ln -s /usr/bin/python3 /usr/local/bin/python && \
    pip3 install --upgrade pip && \
    python3.6 -m pip install pip --upgrade && \
    pip install -e . && \
    mkdir -p media/CACHE && \
    ilot migrate && \
    ilot update && \
    ilot collectstatic 
    
WORKDIR /server

CMD ["ilot", "serve" ,"--ip=0.0.0.0", "--port=9999", "--no-ssl" ]
EXPOSE 9999
