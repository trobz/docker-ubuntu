#!/bin/bash

info "Clean up temporary setup folder"
rm -fr /tmp/setup

# reset /tmp permissions (seems compromised by docker...)
chown root:root /tmp && chmod 1777 /tmp 

success "Temporary data removed"
