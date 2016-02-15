#!/bin/bash

ls /usr/local/ssh 2>/dev/null | grep id_rsa &> /dev/null
SSH_AVAILABLE=$?

if [[ $SSH_AVAILABLE -ne 0 ]]; then
    warn "Your personal SSH keys are not mounted on this image"
    warn "Please run this image with your personal SSH keys mounted as a volume on /usr/local/ssh"
else
    info "Copy your personal SSH keys into $USERNAME user .ssh folder..."
    /bin/mkdir "$USER_HOME"/.ssh -p
    /bin/rm -f "$USER_HOME"/.ssh/{id_rsa,id_rsa.pub,authorized_keys}
    /bin/cp -f /usr/local/ssh/{id_rsa,id_rsa.pub} "$USER_HOME"/.ssh/
    cat "$USER_HOME"/.ssh/id_rsa.pub > "$USER_HOME"/.ssh/authorized_keys 2>/dev/null
    chown -R "$USERNAME":"$USERNAME" "$USER_HOME"/.ssh
    chmod -rwx,u+rwx -R "$USER_HOME"/.ssh
fi

chmod 775 /var/run/screen

success "SSH Server daemon configured"
