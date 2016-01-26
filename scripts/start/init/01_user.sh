#!/bin/bash

export USERNAME=${USERNAME:-docker}
export PASSWORD=${PASSWORD:-docker}
export USER_UID=${USER_UID:-1000}
export USER_GID=${USER_GID:-1000}
export FORCE_CHOWN=${FORCE_CHOWN:-0}
export USER_SHELL=${USER_SHELL:-/bin/bash}

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
useradd -d $USER_HOME --uid $USER_UID --gid $USER_GID -G sudo -s $USER_SHELL -m $USERNAME &>/dev/null
echo -e "$PASSWORD\n$PASSWORD\n" | passwd $USERNAME &>/dev/null

home_user_ids=(`ls -lan "$USER_HOME" | awk '{print $3}'`)
home_group_ids=(`ls -lan "$USER_HOME" | awk '{print $4}'`)
already_chowned=$(val_in_array "$USER_UID" "${home_user_ids[@]}" && val_in_array "$USER_GID" "${home_group_ids[@]}" && echo 1 || echo 0)

if [[ $USER_UID -ne 1000 ]] && [[ $already_chowned -eq 0 ]] || [[ $FORCE_CHOWN -eq 1 ]]; then
  info "Force chown of ${USER_HOME} to $USERNAME"
  chown "$USERNAME:" "$USER_HOME" -R &>/dev/null
fi

chown $USERNAME: $USER_HOME &>/dev/null

# prepare bash.bashrc to have a nice default prompt with bash
cat /tmp/setup/user/bash.bashrc >> /etc/bash.bashrc


success "User $USERNAME configured"

