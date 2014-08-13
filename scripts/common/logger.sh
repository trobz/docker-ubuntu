#!/bin/bash

#TODO: switch to color.sh
if [ ${libout_color:-1} -eq 1 ]; then
  DEF_COLOR="\x1b[0m"
  BLUE="\x1b[34;01m"
  CYAN="\x1b[36;01m"
  GREEN="\x1b[32;01m"
  RED="\x1b[31;01m"
  GRAY="\x1b[37;01m"
  YELLOW="\x1b[33;01m"
fi

function log(){
    if [ -n "$INIT_LOG" ]; then
        if [[ ! -f "$INIT_LOG" ]]; then
            mkdir -p ${INIT_LOG%/*}
        fi
        echo $(date +%Y-%m-%d:%H:%M:%S) - "$@" >> "$INIT_LOG"
    fi
}


debug() {
  if [ ${LOG_LEVEL:-0} -gt 3 ]; then
    level=$(printf '%7s:' "DEBUG")
    echo -e "$CYAN${level}$DEF_COLOR $@"
    log "$level" "$@"
  fi
}

success() {
  if [ ${LOG_LEVEL:-0} -gt 2 ]; then
    level=$(printf '%7s:' "SUCCESS")
    echo -e "$GREEN${level}$DEF_COLOR $@"
    log "$level" "$@"
  fi
}

warn() {
  if [ ${LOG_LEVEL:-0} -gt 1 ]; then
    level=$(printf '%7s:' "WARN")
    echo -e "$YELLOW${level}$DEF_COLOR $@"
    log "$level" "$@"
  fi
}

info() {
  if [ ${LOG_LEVEL:-0} -gt 0 ]; then
    level=$(printf '%7s:' "INFO")
    echo -e "$GRAY${level}$DEF_COLOR $@"
    log "$level" "$@"
  fi
}

error() {
  level=$(printf '%7s:' "ERROR")
  echo -e "$RED${level}$DEF_COLOR $@"
  log "$level" "$@"
}

prompt() {
  val=""
  def_val=${!1:-""}

  while [[ -z "$val" ]]; do
    level=$(printf '%7s:' "INPUT")
    printf "$BLUE${level}$DEF_COLOR ${@:2:${#@}}"
    read val
    if [[ -n "$def_val" ]]; then
        break
    fi
  done

  if [[ -n "$val" ]]; then
    eval "$1=\"$val\""
  fi
}


die() {
  error "EXIT with status 1"
  exit 1
}