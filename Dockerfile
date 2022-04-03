FROM openjdk:8-jdk-alpine3.9

# setup ssh service
RUN apk add --no-cache openrc && apk add --no-cache openssh-server && apk add build-base && \
    mkdir -p /run/openrc && touch /run/openrc/softlevel && \
    rc-update add sshd && rc-status && \
    adduser -h "/home/run" -s "/app/run" -D run && \
    echo "run:123456" | chpasswd && \
    rm -f /etc/motd && \
    echo -e "#\!/bin/sh\nrc-service sshd stop || true\nrc-service sshd restart\n/bin/sh" > /entry.sh && chmod +x /entry.sh

COPY app/* /app/

RUN gcc /app/run.c -o /app/run

EXPOSE 22

ENTRYPOINT [ "/bin/sh", "/entry.sh"]