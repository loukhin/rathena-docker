#!/bin/sh
set -e

_main() {
    echo "Updating config files..."
    cp -r /opt/rathena/custom-conf/* /opt/rathena/conf

    setpriv --reuid=rathena --regid=rathena --init-groups "$@"
}

_main "$@"
