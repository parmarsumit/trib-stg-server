
FROM ubuntu:16.04

RUN apt-get update -y && \
    apt-get install -y python3 python3-pip python3-pil python3-dev build-essential git curl wget && \
    git clone https://github.com/Tribute-coop/server && \
    cd server/ && \
    ln -s /usr/bin/python3 /usr/local/bin/python && \
    python3 -m pip install --upgrade pip && \
    python3 -m pip install -e . && \
    python3 -m ilot.manage migrate && \
    python3 -m ilot.manage update && \
    python3 -m ilot.manage collectstatic

WORKDIR /server

CMD ["bash" "serve"]
EXPOSE 9999
