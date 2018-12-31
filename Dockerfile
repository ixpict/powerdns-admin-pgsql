FROM alpine:3.8

RUN apk update && \
    apk add --no-cache \
    python3 \
    python3-dev \
    libffi-dev \
    openldap-dev \
    build-base \
    mariadb-dev \
    postgresql-libs \
    postgresql-dev \
    git \
    npm \
    yarn \
    libxslt-dev \
    xmlsec-dev &&\
    mkdir -p /var/www/powerdns-admin && cd /var/www/powerdns-admin && \
    rm -rf /var/cache/apk/*

RUN pip3 install --upgrade pip && \
    pip3 install psycopg2 && \
    git clone https://github.com/ngoduykhanh/PowerDNS-Admin.git /var/www/powerdns-admin
RUN pip3 install -r /var/www/powerdns-admin/requirements.txt
RUN mkdir /uploads

COPY config.py /var/www/powerdns-admin/config.py
COPY entrypoint.sh /var/www/powerdns-admin/entrypoint.sh

WORKDIR /var/www/powerdns-admin

VOLUME ["/uploads", "/var/www/powerdns-admin/node_modules"]

EXPOSE 9191

ENTRYPOINT ["/var/www/powerdns-admin/entrypoint.sh"]