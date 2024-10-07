ARG VERSION

# FROM archlinux:${VERSION:-latest}
FROM archlinux:latest
# LABEL MAINTAINER="ARMG0268XZ59"
LABEL maintainer="Alex-Mahdi=ARMG0268XZ59"

# ENV noVNC_version=1.2.0
# ENV websockify_version=0.9.0

# Local debug
# COPY ./mirrorlist /etc/pacman.d/mirrorlist 
# COPY ./websockify-${websockify_version}.tar.gz /websockify.tar.gz
# COPY ./noVNC-${noVNC_version}.tar.gz /noVNC.tar.gz

# Install apps
RUN pacman -vSyu --debug --noconfirm plasma-meta \
	kde-accessibility-meta kde-system-meta konsole \
	chromium vim wget tigervnc xorg-server \
	python-numpy python-setuptools \
	&& pacman -vScc --debug --noconfirm


# Set the Environment Variables

# Setup demo environment variables

    ENV HOME=/root/ \

   #  DEBIAN_FRONTEND=noninteractive \

    LANG=en_US.UTF-8 \

    LANGUAGE=en_US.UTF-8 \

    LC_ALL=C.UTF-8 \

   # DISPLAY=:0.0 \

    DISPLAY=:0 \

    DISPLAY_WIDTH=1920 \

    DISPLAY_HEIGHT=1080 \

    RUN_XTERM=yes \

   #  RUN_FLUXBOX=yes


# Install noVNC
# RUN	wget https://github.com/novnc/websockify/archive/v${websockify_version}.tar.gz -O /websockify.tar.gz \
#	&& tar -xvf /websockify.tar.gz -C / \
#	&& cd /websockify-${websockify_version} \
#	&& python setup.py install \
#	&& cd / && rm -r /websockify.tar.gz /websockify-${websockify_version} \
#	&& wget https://github.com/novnc/noVNC/archive/v${noVNC_version}.tar.gz -O /noVNC.tar.gz \
#	&& tar -xvf /noVNC.tar.gz -C / \
#	&& cd /noVNC-${noVNC_version} \
#	&& ln -s vnc.html index.html \
#	&& rm /noVNC.tar.gz


   # Install and configure Virtual Display, VNC, Proxy, Server

   # noVNC cooking

   WORKDIR=/home

   WORKDIR /opt/

   RUN git clone https://github.com/kanaka/websockify websockify

   WORKDIR /opt/

   RUN git clone https://github.com/kanaka/noVNC.git novnc

   # Avoid another checkout when launching noVnc

   WORKDIR /opt/novnc/utils/

   RUN git clone https://github.com/kanaka/websockify websockify

   # RUN export DISPLAY=:0.0

   RUN export DISPLAY=:1

   # RUN Xwayland :1

   # RUN Xvfb :1 -screen 0 1920x1080x24
   
   # RUN startplasma-x11

   # RUN x11vnc -ncache 0 -noxdamage --display :1

   # RUN /opt/novnc/utils/novnc_proxy --vnc localhost:5900 --listen 6080

   # RUN websockify --web /opt/novnc 6080 localhost:5900
   

COPY ./config/xstartup /root/.vnc/
COPY ./start.sh /

WORKDIR /root

EXPOSE 5900 6080

CMD [ "/start.sh" ]
