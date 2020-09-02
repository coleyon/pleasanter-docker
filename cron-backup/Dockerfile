FROM debian:buster-slim
USER root

# 日本時間に設定
ENV TZ=Asia/Tokyo

# cronを入れる
RUN apt-get update && apt-get -y install busybox-static

COPY crontab /var/spool/cron/crontabs/root

# Postgress クライアントをインストール
RUN apt -y install lsb-release wget gnupg2 &&\
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - 
RUN  echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" | tee  /etc/apt/sources.list.d/pgdg.list &&\
  apt update &&\
  apt -y install postgresql-client-12

# バックアップに使用するツール
RUN apt-get -y install p7zip-full

# pg_rmanのビルドツールをインストール
WORKDIR /root
RUN apt update &&\ 
  apt-get install -y gcc make libpq-dev zlib1g-dev libpam0g-dev libssl-dev libselinux1-dev libkrb5-dev libedit-dev postgresql-server-dev-12
RUN wget https://github.com/ossc-db/pg_rman/releases/download/V1.3.9/pg_rman-1.3.9-pg12.tar.gz &&\
  tar xvfz pg_rman-1.3.9-pg12.tar.gz && \
  cd pg_rman-1.3.9-pg12 && \
  make &&\
  make install 

# キャッシュを消去
RUN apt-get -y clean \
  && rm -rf /var/lib/apt/lists/*

# postgressのバックアップ設定
WORKDIR /root
RUN echo "*:*:*:*:mysecretpassword1234" > /root/.pgpass
RUN chmod 600 .pgpass
COPY pg_dumpall.sh /var/backup_sh/pg_dumpall.sh

CMD busybox crond -l 2 -L /dev/stderr -f
