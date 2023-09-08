FROM debian:bookworm-20230904

RUN apt update && apt install -y tigervnc-standalone-server novnc python3-websockify dwm
RUN ln -s vnc.html /usr/share/novnc/index.html
RUN adduser vncuser
ADD start.sh /
ADD xstartup /home/vncuser/.vnc/
RUN chown -R vncuser /home/vncuser/.vnc
USER vncuser
RUN touch /home/vncuser/.Xresources
RUN echo "#!/bin/bash\nsleep infinity" > /home/vncuser/.xsession && chmod +x /home/vncuser/.xsession

ARG PASSWORD=asdasd
RUN bash -c "echo '${PASSWORD}' | vncpasswd -f > /home/vncuser/.vnc/passwd && chmod 600 /home/vncuser/.vnc/passwd"

 # e.g. -geometry 1280x1024
ENV VNCSERVER_ARGS=""
CMD ["/start.sh"]
