FROM debian:buster-slim
USER root

# 日本時間に設定
ENV TZ=Asia/Tokyo

# cronを入れる
RUN apt-get update && apt-get -y install busybox-static

COPY crontab /var/spool/cron/crontabs/root
# COPY script.php /app/script.php

# Postgress クライアントをインストール
RUN apt -y install lsb-release wget gnupg2 &&\
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - 
RUN  echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" | tee  /etc/apt/sources.list.d/pgdg.list &&\
  apt update &&\
  apt -y install postgresql-client-12

# バックアップに使用するツール
RUN apt-get -y install p7zip-full emacs-nox

# postgressのバックアップ設定
WORKDIR /root
RUN echo "*:*:*:*:mysecretpassword1234" > /root/.pgpass
RUN chmod 600 .pgpass
COPY pg_backup.sh /var/backup_sh/pg_backup.sh

CMD busybox crond -l 2 -L /dev/stderr -f
