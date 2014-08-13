#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
READY="/usr/local/docker/ready"

LOG_LEVEL=4
INIT_LOG="/var/log/docker/init.log"

source /etc/bash/logger.sh
source /etc/bash/replace.sh


ping -c 1 8.8.8.8 &> /dev/null
IS_ONLINE=$?

if [[ ! -f "$READY" ]]; then
  info "First run, initalize the container..."
  source $DIR/init.sh
fi

source $DIR/run.sh
