#!/bin/bash

source /etc/bash/color.sh

# run a command until it retrieve a 0 status code, timeout set to 10s by default
# usage: timeout command [timeout in second]
timeout () {
    set +e
    declare -i TIMEOUT=${2:-10}
    declare -i SLEEP_TIME=1
    declare -i COUNT=0
    declare -i STATUS=0
    declare -i CURRENT_TIME=$(expr $SLEEP_TIME \* $COUNT)
    while [[ $TIMEOUT -gt $CURRENT_TIME ]]; do
        COUNT=$(expr $COUNT \+ 1)
        CURRENT_TIME=$(expr $SLEEP_TIME \* $COUNT)
        eval "$1"
        STATUS=$?
        if [[ $STATUS -eq 0 ]]; then
                return 0
                set -e
        fi
        sleep $SLEEP_TIME
    done
    return 1
    set -e
}



# prompt for user input, ask until a value is enter. The variable doesn't have to be set before.
# usage: prompt variable text
# ie:    prompt FOO "What is foo ?" ; echo $FOO
prompt() {
  val=""
  def_val=${!1:-""}

  while [[ -z "$val" ]]; do
    level=$(printf '%7s:' "INPUT")
    printf "$Blue${level}$Off ${@:2:${#@}}"
    read val
    if [[ -n "$def_val" ]]; then
        break
    fi
  done

  if [[ -n "$val" ]]; then
    eval "$1=\"$val\""
  fi
}

