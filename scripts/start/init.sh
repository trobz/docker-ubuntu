#!/bin/bash

for file in $DIR/init/*.sh; do
    source $file
done

touch $READY

success "Container is configured and ready to be used !"
