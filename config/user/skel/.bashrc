#!/bin/bash

# base-files version 3.7-1

# To pick up the latest recommended .bashrc content,
# look in /etc/defaults/etc/skel/.bashrc

# Modifying /etc/skel/.bashrc directly will prevent
# setup from updating it.

# The copy in your home directory (~/.bashrc) is yours, please
# feel free to customise it to create a shell
# environment to your liking.  If you feel a change
# would be benificial to all, please feel free to send
# a patch to the cygwin mailing list.

# User dependent .bashrc file


# Shell Options
# #############

# See man bash for more options...

# Don't wait for job termination notification
# set -o notify

# Don't use ^D to exit
# set -o ignoreeof

# Use case-insensitive filename globbing
# shopt -s nocaseglob

# Make bash append rather than overwrite the history on disk
shopt -s histappend

# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
shopt -s cdspell


# Completion options
# ##################

# These completion tuning parameters change the default behavior of bash_completion:

# Define to access remotely checked-out files over passwordless ssh for CVS
# COMP_CVS_REMOTE=1

# Define to avoid stripping description in --option=description of './configure --help'
# COMP_CONFIGURE_HINTS=1

# Define to avoid flattening internal contents of tar files
# COMP_TAR_INTERNAL_PATHS=1

# If this shell is interactive, turn on programmable completion enhancements.
# Any completions you add in ~/.bash_completion are sourced last.
case $- in
  *i*) [[ -f /etc/bash_completion ]] && . /etc/bash_completion ;;
esac


# History Options
# ###############

# Don't put duplicate lines in the history.
export HISTCONTROL="ignoredups"

# Ignore some controlling instructions
# export HISTIGNORE="[   ]*:&:bg:fg:exit"

# Whenever displaying the prompt, write the previous line to disk
# export PROMPT_COMMAND="history -a"


# Aliases
# #######

# Some example alias instructions
# If these are enabled they will be used instead of any instructions
# they may mask.  For example, alias rm='rm -i' will mask the rm
# application.  To override the alias instruction use a \ before, ie
# \rm will call the real rm not the alias.

# Interactive operation...
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Default to human readable figures
alias df='df -h'
alias du='du -h'
alias dul='du -h --max-depth=1'


# Misc :)
# alias less='less -r'                          # raw control characters
# alias whence='type -a'                        # where, of a sort
# alias grep='grep --color'                     # show differences in colour

# Some shortcuts for different directory listings
alias ls='ls -hF --color=tty'                 # classify files in colour
alias dir='ls --color=auto --format=vertical'
alias vdir='ls --color=auto --format=long'
alias ll='ls -l'                              # long list
alias la='ls -lhA'                              # all but . and ..
alias l='ls -lh'                               #
#alias e='emacs -fn *courier-medium-r-normal--14-140-*-iso8859-1'
alias e='emacs -nw'
alias mv='mv -v'
alias cp='cp -v'
alias rm='rm -v'


# GIT

alias git-b='git branch -a'
git-ck () { git checkout --track -b $1 origin/$1; }
alias git-cc='git clean -f'
git-br () {
echo -e "branches                                          last commit"
for b in `git branch -r`
do
        log_date=`git log remotes/$b 2> /dev/null | head -n4 | grep Date | grep -o -P ' .*'`
        if [ "${#log_date}" -gt 0 ]
        then
                log_date=`date --date="${log_date:0:${#log_date}-5}" +"%D %T" 2> /dev/null`

                diff=$((50-${#b})); number=$(printf "%${diff}s"); spaces=${number// / };
                echo -e "$b$spaces$log_date"
        fi
done
}

alias git-slog='git log --oneline | head -n 10'

# Docker
alias fig="sudo fig"
alias docker="sudo docker"
alias docker-stc='docker stop $(docker ps -a -q)'
alias docker-rmc='docker rm $(docker ps -a -q)'
alias docker-att='docker attach --sig-proxy=false'
alias docker-access=' nsenter -m -u -i -n -p -t'



# Config
##############################################


export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_PAPER="en_US.UTF-8"
export LC_NAME="en_US.UTF-8"
export LC_ADDRESS="en_US.UTF-8"
export LC_TELEPHONE="en_US.UTF-8"
export LC_MEASUREMENT="en_US.UTF-8"
export LC_IDENTIFICATION="en_US.UTF-8"

export PYTHONSTARTUP="$HOME/.pythonrc.py"
