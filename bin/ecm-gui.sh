#!/usr/bin/env bash
function realpath()
{
    f=$@
    if [ -d "$f" ]; then
        base=""
        dir="$f"
    else
        base="/$(basename "$f")"
        dir=$(dirname "$f")
    fi
    dir=$(cd "$dir" && pwd)
    echo "$dir$base"
}

_bindir=$(dirname $(realpath $0))

gxi -e '(import
        :ecm/gui/endpoints/login
        :ecm/gui/endpoints/report/pmi
        :ecm/gui/server/httpd
        )'\
            -e '(begin (ensure-ecm-httpd!) (display "ECM Gui v0.42"))'\
            -
