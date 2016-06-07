FROM debian:jessie

MAINTAINER Francois Raubenheimer <cois.io>

RUN apt-get update && apt-get install -y varnish && apt-get clean
ADD ./start.sh /start.sh
RUN chmod +x /start.sh

COPY varnish.vcl    /etc/varnish/default.vcl

ENV VCL_CONFIG      /etc/varnish/default.vcl
ENV CACHE_SIZE      256M
ENV VARNISHD_PARAMS -p default_ttl=3600 -p default_grace=3600 -T 0.0.0.0:8080 -S /etc/varnish/secret

EXPOSE 80 8080

CMD /start.sh