FROM alpine

MAINTAINER Guoguo (i@qwq.trade)
 
# 替换阿里云的源
RUN echo "http://mirrors.aliyun.com/alpine/latest-stable/main/" > /etc/apk/repositories && \
    echo "http://mirrors.aliyun.com/alpine/latest-stable/community/" >> /etc/apk/repositories

RUN apk update && \
    apk add --no-cache openssh tzdata git rsync expect && \ 
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
       ssh-keygen -t dsa -P "" -f /etc/ssh/ssh_host_dsa_key && \
    ssh-keygen -t rsa -P "" -f /etc/ssh/ssh_host_rsa_key && \
    ssh-keygen -t ecdsa -P "" -f /etc/ssh/ssh_host_ecdsa_key && \
    ssh-keygen -t ed25519 -P "" -f /etc/ssh/ssh_host_ed25519_key
# sed -i "s/#PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config && \

 
# 开放22端口
EXPOSE 22
COPY docker-entrypoint.sh /usr/local/bin/
COPY custom.sh /usr/local/bin/
RUN ["chmod", "+x", "/usr/local/bin/docker-entrypoint.sh"]
ENTRYPOINT ["docker-entrypoint.sh"]
 
# 执行ssh启动命令
#CMD ["/usr/sbin/sshd", "-D"]

