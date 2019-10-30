
# docker rm -f arch-mirror; docker build -t arch-mirror . && docker run --rm --name arch-mirror -d arch-mirror && docker exec -it arch-mirror sh

FROM nginx:stable-alpine

RUN rm /etc/nginx/conf.d/default.conf && mkdir -p /pacman/db /pacman/root && chown -R nginx: /pacman

COPY server.conf /etc/nginx/conf.d/2-server.conf

COPY *.sh /usr/bin/

VOLUME ["/pacman"]

ENTRYPOINT ["/usr/bin/entrypoint.sh"]
CMD ["https://mirrors.edge.kernel.org/archlinux", "https://mirrors.lug.mtu.edu/archlinux", "https://mirrors.rit.edu/archlinux", "https://mirrors.rutgers.edu/archlinux"]
