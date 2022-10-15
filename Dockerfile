FROM debian:bullseye-20221004

RUN apt update && apt install -y tightvncserver novnc python3-websockify dwm
RUN ln -s vnc.html /usr/share/novnc/index.html
RUN adduser vncuser
ADD start.sh /
ADD xstartup /home/vncuser/.vnc/
RUN chown -R vncuser /home/vncuser/.vnc
USER vncuser
RUN echo "#!/bin/bash" > /home/vncuser/.xsession && chmod +x /home/vncuser/.xsession

ARG PASSWORD=asdasd
RUN bash -c "echo '${PASSWORD}' | vncpasswd -f > /home/vncuser/.vnc/passwd && chmod 600 /home/vncuser/.vnc/passwd"

ENV VNCSERVER_ARGS # e.g. -geometry 1280x1024
CMD ["/start.sh"]
