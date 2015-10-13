#!/bin/bash

info "Clean up temporary setup folder"
apt-get clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# reset /tmp permissions (seems compromised by docker...)
chown root:root /tmp && chmod 1777 /tmp

success "Temporary data removed"
