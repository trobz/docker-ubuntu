history -a

source /etc/bash/color.sh
source /etc/bash/ps_function.sh

function get_prompt {
    local CODE=""
    if [ $RET -eq 0 ]; then
        CODE=${Green}$RET${Off}
    else
        CODE=${Red}$RET${Off}
    fi

    local GIT=""
    if [ $HAS_GIT -eq 0 ]; then
	GIT_STATUS=$(git status --porcelain --branch 2>/dev/null)
	if [ $? -eq 0 ]; then
            local GIT_BRANCH=$(git_branch)
            local GIT_COLOR=$(git_color "$GIT_STATUS")
            if [ ! -z $GIT_BRANCH ]; then
                GIT="${BBlack}(${Off}$GIT_COLOR$GIT_BRANCH${Off}${BBlack})${Off} "
	    fi
        fi
    fi

    local TIME="${BBlack}[\t]${Off}"
    local HOST="${Blue}${HOSTNAME}${Off}"
    local CPATH="${Yellow}\w${Off}"
    local USER="$(user_color)"
    local TIDLE="$(user_tilde)"

    echo "$TIME $USER@$HOST:$CPATH $GIT$CODE
$TIDLE "
}

function get_term_title {
    echo "[\t] \u@\h:\w"
}

PS1="$(get_prompt)"

case $TERM in
    xterm*)
        echo -ne "\033]0;[$(date +%T)] ${USER}@${HOSTNAME}:${PWD/$HOME/~}\007"
        ;;
esac
