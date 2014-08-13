#!/bin/bash

replace_env () {
    for ENV_VAR in `env`; do
        ENV_VAR=`echo "$ENV_VAR" | sed -e "s/=.*//"`
        replace="s|{$ENV_VAR}|${!ENV_VAR}|g"
        sed -i "$replace" $1
    done
}