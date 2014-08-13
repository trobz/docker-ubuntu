#!/bin/bash

export USERNAME=${USERNAME:-docker}
export PASSWORD=${PASSWORD:-docker}
export USER_UID=${USER_UID:-1000}
export USER_GID=${USER_GID:-1000}

if [[ "$USERNAME" != "docker" ]] && [[ "$USER_HOME" == "/home/docker" ]]; then
    export USER_HOME=/home/$USERNAME
fi


if [[ -d $USER_HOME ]]; then
    info "$USER_HOME already exists, copy default user profile files manually"
    cp /etc/skel/.* $USER_HOME &>/dev/null
fi

info "Create user $USERNAME with UID: $USER_UID, GID: $USER_GID, home path: $USER_HOME"

# setup openerp user
groupadd --gid $USER_GID $USERNAME
useradd -d $USER_HOME --uid $USER_UID --gid $USER_GID -G sudo -s /bin/bash -m $USERNAME &>/dev/null
echo -e "$PASSWORD\n$PASSWORD\n" | passwd $USERNAME &>/dev/null

chown $USERNAME: $USER_HOME -R &>/dev/null

# prepare bash.bashrc to have a nice default prompt with bash
cat /tmp/setup/user/bash.bashrc >> /etc/bash.bashrc


success "User $USERNAME configured"