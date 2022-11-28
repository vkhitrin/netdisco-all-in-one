FROM alpine:3.13.5

ENV PERL_LOCAL_LIB_ROOT=/usr/lib/perl5/

USER root
# Add edge testing repository
# RUN echo 'https://dl-cdn.alpinelinux.org/alpine/edge/testing/' >> /etc/apk/repositories
# Install netdisco
RUN apk add --update --no-cache make \
                                gcc \
                                libc-dev \
                                perl-app-cpanminus \
                                perl-utils \
                                perl-dev \
                                postgresql \
                                postgresql-dev \
                                net-snmp-dev \
                                openssl \
                                openssl-dev \
                                zlib \
                                zlib-dev \
                                libnet \
                                libnet-dev \
                                perl-net-ssleay \
                                perl-crypt-ssleay \
                                libssl1.1 \
                                curl \
                                wget \
                                expect \
                                net-snmp-libs \
                                net-snmp-perl \
                                tini

# Install Netdisco from CPAN
RUN curl -L https://cpanmin.us/ | perl - --notest App::Netdisco NetSNMP::default_store

# Create directory for PostgreSQL unix socket and change ownership
RUN mkdir /run/postgresql;chown postgres:postgres /run/postgresql/

USER postgres

# Create directory for PostgreSQL data, set permissions and initialize database
RUN mkdir /var/lib/postgresql/data; \
          chmod 0700 /var/lib/postgresql/data; \
          initdb -D /var/lib/postgresql/data; \
          pg_ctl start -D /var/lib/postgresql/data; \
          createuser netdisco; \
          createdb netdisco -O netdisco; \
          psql -e -c "alter user netdisco with encrypted password 'netdisco';"

USER root

# Copy configurationfiles
COPY container_files/ /root

ENTRYPOINT ["/sbin/tini", "--", "/root/init.sh"]