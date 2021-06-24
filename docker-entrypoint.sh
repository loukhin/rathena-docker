#!/bin/sh
set -e

_main() {
    files="conf db npc athena-start char-server login-server map-server function.sh"
    for file in $files
    do
    cp -rn /opt/src/rathena/$file /opt/rathena
    done
    cp -r /opt/rathena/custom-conf/* /opt/rathena/conf

    exec "$@"
}

_main "$@"
