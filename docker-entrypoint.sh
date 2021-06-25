#!/bin/bash
set -e

_main() {
    files=( "conf" "db" "npc" "athena-start" "char-server" "login-server" "map-server" "function.sh" )
    for file in "${$files[@]}"
    do
        cp -rn /opt/src/rathena/$file /opt/rathena
    done
    cp -r /opt/rathena/custom-conf/* /opt/rathena/conf

    chown -R rathena /opt/rathena
    chmod -R a+w /opt/rathena

    exec setpriv --reuid=rathena --regid=rathena --init-groups "$@"
}

_main "$@"
