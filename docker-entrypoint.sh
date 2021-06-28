#!/bin/sh
set -e

_main() {
    echo "Updating config files..."
    cp -r /opt/rathena/custom-conf/* /opt/rathena/conf
    echo "Updating npc files..."
    cp -r /opt/rathena/custom-npc/* /opt/rathena/npc

    chown -R rathena:rathena /opt/rathena

    setpriv --reuid=rathena --regid=rathena --init-groups "$@"
}

_main "$@"
