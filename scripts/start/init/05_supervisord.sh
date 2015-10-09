#!/bin/bash

info "Config supervisor with $USERNAME, HTTP access enabled on port 8011"

chown $USERNAME: /var/log/supervisor -R
replace_env /etc/supervisor/supervisord.conf

success "Supervisord process manager configured"