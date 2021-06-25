#!/bin/sh
set -e

_main() {
    echo "Updating config files..."
    cp -r /opt/rathena/custom-conf/* /opt/rathena/conf

    chown -R rathena:rathena /opt/rathena

    setpriv --reuid=rathena --regid=rathena --init-groups "$@"
}

_main "$@"
