#!/bin/bash

ls /usr/local/ssh 2>/dev/null | grep id_rsa &> /dev/null
SSH_AVAILABLE=$?

if [[ $SSH_AVAILABLE -ne 0 ]]; then
    warn "Please, run this image with your public SSH key mounted on /usr/local/ssh/id_rsa.pub"
else
    info "Add public SSH key into $USERNAME user authorized keys..."
    mkdir $USER_HOME/.ssh && cat /usr/local/ssh/id_rsa.pub >> $USER_HOME/.ssh/authorized_keys 2>/dev/null
fi

chmod 775 /var/run/screen

success "SSH Server daemon configured"
