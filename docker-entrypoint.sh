#!/bin/sh
set -e

_main() {
    echo "Updating config files..."
    cp -r /opt/rathena/custom-conf/* /opt/rathena/conf

    if [ $@ == "map" ]; then
        echo "Updating npc files..."
        cp -r /opt/rathena/custom-npc/* /opt/rathena/npc
    fi

    chown -R rathena:rathena /opt/rathena

    setpriv --reuid=rathena --regid=rathena --init-groups "/opt/rathena/$@-server"
}

_main "$@"
