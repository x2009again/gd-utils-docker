FROM alpine
MAINTAINER Tdtool
ARG VERSION=2020-09-15

ENV USERPWD mysec55rdet9966
USER root

ADD start.sh /
# COPY alpine.patch /alpine.patch



RUN set -ex \
        && apk update \
        && apk add --no-cache nodejs npm \
        && apk add ca-certificates mailcap curl bash unzip \
        && apk add --no-cache --virtual .build-deps make gcc g++ python3 git \
        && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
        && echo "Asia/Shanghai" > /etc/timezone \
        && wget https://rclone.org/install.sh && chmod +x ./install.sh && ./install.sh \
        && rm -f ./install.sh && chmod +x /start.sh \
        && git clone https://github.com/iwestlin/gd-utils /gd-utils \
        && cd /gd-utils \
        && npm install \
        && apk del python3 mailcap \
        && rm -rf /gd-utils/node_modules/*/LICENSE /gd-utils/node_modules/*/README.md \
        && apk del .build-deps && rm -rf /var/cache/apk/ \
        && rm -rf /tmp/* && rm -rf ./.git

# ARG VERSION
# RUN set -ex \
#         && git clone https://github.com/iwestlin/gd-utils /gd-utils \
#         && cd /gd-utils \
#         && npm install \
#         && apk del .build-deps && rm -rf /var/cache/apk/ && rm -rf ./.git


COPY onedrive.js tg.js /gd-utils/src/
COPY config.js /gd-utils/

# RUN apk add --no-cache --update --virtual build-deps alpine-sdk autoconf automake libtool curl tar git && \
#         adduser -D -H shusr && \
#         git clone https://github.com/shellinabox/shellinabox.git /shellinabox && \
#         cd /shellinabox && \
#         git apply /alpine.patch && \
#         autoreconf -i && \
#         ./configure --prefix=/shellinabox/bin && \
#         make && make install && cd / && \
#         #mv /shellinabox/bin/bin/shellinaboxd /gd-utils/sa/shellinaboxd && \
#         #rm -rf /shellinabox && \
#         apk del build-deps && rm -rf /var/cache/apk/
# COPY filebrowser.json /.filebrowser.json
# RUN curl -fsSL https://filebrowser.xyz/get.sh | bash
# RUN chmod +x /start.sh && \
# 	chmod 777 /shellinabox/bin/bin/shellinaboxd
#添加gd账号,设置密码
#RUN  adduser  gd -u 20001 -D -S -s /bin/bash -G root && \
#	echo -e "${USERPWD}\n${USERPWD}" | passwd root && \
#	echo -e "${USERPWD}\n${USERPWD}" | passwd gd && \
#	chmod 4755 /bin/busybox	
#对外暴露tg、shellinabox、filebrowser端口
# EXPOSE 23333 4200 80 
EXPOSE 23333
VOLUME ["/gd-utils","/root/.config/rclone"]


ENTRYPOINT [ "/start.sh" ]
