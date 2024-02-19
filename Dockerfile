FROM debian:bookworm-20240211

ARG TARGETARCH

ADD https://github.com/kasmtech/KasmVNC/releases/download/v1.2.0/kasmvncserver_bookworm_1.2.0_$TARGETARCH.deb /tmp
RUN apt update && apt install -y dwm /tmp/kasmvncserver_*.deb expect
ADD kasmvnc.yaml /etc/kasmvnc
RUN adduser vncuser
RUN adduser vncuser ssl-cert
ADD start.sh /
ADD xstartup /home/vncuser/.vnc/
ADD expectfile /
RUN chown -R vncuser /home/vncuser/.vnc
USER vncuser
RUN touch /home/vncuser/.vnc/.de-was-selected; echo "#!/bin/bash" > /home/vncuser/.xsession && chmod +x /home/vncuser/.xsession

 # e.g. -geometry 1280x1024
ENV VNCSERVER_ARGS=""
ENV PASSWORD=asdasd
CMD ["/start.sh"]
