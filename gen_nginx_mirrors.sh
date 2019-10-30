#!/bin/sh

# gen_nginx_mirrors.sh https://mirrors.edge.kernel.org/archlinux https://mirrors.lug.mtu.edu/archlinux https://mirrors.rit.edu/archlinux https://mirrors.rutgers.edu/archlinux

set -euo pipefail

i=0
backup=""

cat <<EOF
    upstream arch_mirror {
EOF

for mirror in "$@"
do

cat <<EOF
        server unix:/var/run/nginx-arch$i.sock$backup;
EOF

i=$((i+1))
backup=' backup'

done

cat <<EOF
    }

EOF

i=0

for mirror in "$@"
do

cat <<EOF
    # Arch Mirror $i Proxy Configuration
    server
    {
        listen unix:/var/run/nginx-arch$i.sock;

        location / {
            proxy_pass       $mirror\$request_uri;
            proxy_set_header Host $(echo "$mirror" | sed -e 's@^https*://@@' -e 's@/.*$@@');

            add_header X-Upstream $mirror;
        }
    }
EOF

i=$((i+1))
backup=' backup'

done

exit 0
