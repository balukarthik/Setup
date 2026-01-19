#!/bin/bash

alias s="sync-one.sh"
alias vi="vim"
alias t="todo.sh"
alias gls="git ls-tree --name-only HEAD -z | TZ=UTC xargs -0 -I_ git --no-pager log -1 --date=iso-local --format=\"%ad _\" -- _ | sort"

#Technically not an alias but I need a calculator
c() { printf "%s\n" "$@" | bc -l; }


