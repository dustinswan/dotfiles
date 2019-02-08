#/bin/bash

cat /var/lib/acme/dustinswan.com/key.pem \
    /var/lib/acme/dustinswan.com/fullchain.pem > \
    /home/dustinswan/.weechat/ssl/relay.pem

chown dustinswan.users /home/dustinswan/.weechat/ssl/relay.pem
