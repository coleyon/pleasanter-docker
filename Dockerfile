FROM mcr.microsoft.com/mssql/server:2017-latest
ARG ACCEPT_EULA
ARG SA_PASSWORD
ARG MSSQL_PID
ENV ACCEPT_EULA=${ACCEPT_EULA}
ENV SA_PASSWORD=${SA_PASSWORD}
ENV MSSQL_PID=${MSSQL_PID}

USER root

WORKDIR /tmp
RUN wget -q https://packages.microsoft.com/config/ubuntu/16.04/packages-microsoft-prod.deb \
	&& dpkg -i packages-microsoft-prod.deb \
	&& rm -f packages-microsoft-prod.deb \
	&& apt update \
	&& apt install -y \
	dotnet-sdk-2.2 \
	git \
	curl \
	supervisor \
	locales \
	tzdata \
	&& git clone https://github.com/implem/implem.Pleasanter.NetCore /home/Pleasanter.NetCore
RUN apt-get clean \
	&& rm -rf /var/apt/cache/* /tmp/* /var/tmp/* \
	&& locale-gen en_US.UTF-8

WORKDIR /home/Pleasanter.NetCore
COPY supervisord.conf /usr/local/etc/supervisord.conf
COPY Rds.json Implem.Pleasanter.NetCore/App_Data/Parameters/Rds.json
COPY pleasanter.sh cmdnetcore/pleasanter.sh
RUN chmod 744 cmdnetcore/*.sh \
	&& cmdnetcore/build.sh

EXPOSE 80 1433
CMD ["/usr/bin/supervisord", "-n", "-c", "/usr/local/etc/supervisord.conf"]
