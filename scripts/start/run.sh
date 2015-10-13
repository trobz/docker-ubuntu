#!/bin/bash

success "Run supervisord services..."
/usr/bin/supervisord -c /etc/supervisor/supervisord.conf