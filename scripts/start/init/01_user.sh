#!/bin/bash

export USERNAME=${USERNAME:-docker}
export PASSWORD=${PASSWORD:-docker}
export USER_UID=${USER_UID:-1000}
export USER_GID=${USER_GID:-1000}
export FORCE_CHOWN=${FORCE_CHOWN:-0}

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

# only change home owner if UID is not the default one on major system
if [[ $USER_UID -ne 1000 ]] && [[ $FORCE_CHOWN -ne 1 ]]; then
  info "Force chown of ${USER_HOME} to $USERNAME"
  chown $USERNAME: $USER_HOME -R &>/dev/null
fi

chown $USERNAME: $USER_HOME &>/dev/null

# prepare bash.bashrc to have a nice default prompt with bash
cat /tmp/setup/user/bash.bashrc >> /etc/bash.bashrc


success "User $USERNAME configured"
