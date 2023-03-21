rm -f /swapfile
dd if=/dev/zero of=/swapfile bs=1024 count=524288
mkswap /swapfile
chmod 600 /swapfile

exec "$@"
