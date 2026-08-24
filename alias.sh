#!/bin/bash

alias s="sync-one.sh"
alias vi="vim"
alias t="todo.sh"
alias gls='git ls-tree --name-only HEAD trackers/ -z | TZ=UTC xargs -0n1 -I_ git --no-pager log -1 --date=iso-local --format="%ad _" -- _ | sort'

#Technically not an alias but I need a calculator
c() { printf "%s\n" "$@" | bc -l; }



# Launch Chromium detached from the terminal, with no output.
# Chromium's own noise is handled by --log-level=3 in ~/.config/chromium-flags.conf;
# this also drops the library-level stderr (Mesa, dbus) that the log level misses,
# and setsid keeps the browser alive when the launching terminal closes.
chrome() {
    if command -v setsid >/dev/null 2>&1; then
        setsid chromium "$@" </dev/null >/dev/null 2>&1 &
    else
        # setsid is util-linux; fall back for macOS / msys
        nohup chromium "$@" </dev/null >/dev/null 2>&1 &
    fi
}
