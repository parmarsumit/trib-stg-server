
FROM ubuntu:latest
RUN apt-get update -y && \
    apt-get install -y python3-pip python3-pil python3-dev build-essential git curl wget nfs-common && \
    mkdir /efs && \
    mount -t nfs4 -o vers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 fs-d1fda718.efs.eu-west-1.amazonaws.com:/ /efs && \
    mount | grep efs && \
    cp /etc/fstab /etc/fstab.bak && \
    echo 'fs-d1fda718.efs.eu-west-1.amazonaws.com:/ /efs nfs4 nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 0 0' | sudo tee -a /etc/fstab && \
    mount -a && \
    git clone https://github.com/Tribute-coop/server && \
    cd server/ && \
    ln -s /usr/bin/python3 /usr/local/bin/python && \
    pip3 install --upgrade pip && \
    pip install -e . && \
    mkdir -p media/CACHE && \
    ilot migrate && \
    ilot update && \
    ilot collectstatic  
    
WORKDIR /server

CMD ["ilot", "serve" ,"--ip=0.0.0.0", "--port=9999", "--no-ssl" ]
EXPOSE 9999
