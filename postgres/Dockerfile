FROM postgres:12-alpine
ENV LANG ja_JP.utf8

USER postgres

# WALを使えるようにモードの設定を行う
#RUN echo "#WAL settings " >>  /var/lib/postgresql/data/postgresql.conf &&\
#  echo "archive_mode = on" >>  /var/lib/postgresql/data/postgresql.conf &&\
#  echo "wal_level = archive" >>  /var/lib/postgresql/data/postgresql.conf &&\
#  echo "archive_command = 'cp %p /var/lib/postgresql/arclog/%f'" >>  /var/lib/postgresql/data/postgresql.conf
