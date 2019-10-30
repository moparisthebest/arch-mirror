#!/bin/sh

# https://trac.nginx.org/nginx/ticket/658
echo "resolver $(grep "nameserver" /etc/resolv.conf | awk '{print $2}' | tr '\n' ' ');" > /etc/nginx/conf.d/0-resolver.conf

/usr/bin/gen_nginx_mirrors.sh "$@" > /etc/nginx/conf.d/1-mirrors.conf

exec nginx '-g' 'daemon off;'
