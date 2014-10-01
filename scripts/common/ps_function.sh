source /etc/bash/color.sh

function git_color {
  local status=$1
  if [[ "$status" =~ (UU ) ]]; then
    echo -e $On_Red
  elif [[ "$status" =~ (M )|(D ) ]]; then
    echo -e $Red
  elif [[ "$status" =~ (\?\?) ]]; then
    echo -e $IGreen
  elif [[ "$status" == *ahead* ]]; then
    echo -e $Yellow
  else
    echo -e $Green
  fi
}

function git_branch {
  local on_branch=$(git rev-parse --abbrev-ref HEAD 2>&1) 
  if [[ "$on_branch" == *unknown* ]]; then
    echo "no head"
  elif [[ "$on_branch" != 'HEAD' ]]; then
    echo "$on_branch"
  else
    echo $(git rev-parse --short HEAD 2>/dev/null)
  fi
}

function user_color {
  if [ $(id -u) -eq 0 ]; then
    echo "${Red}\u${Off}"
  else
    echo "${Green}\u${Off}"
  fi
}

function user_tilde {
  if [ $(id -u) -eq 0 ]; then
    echo "${Red}#${Off}"
  else
    echo "${Green}\$${Off}"
  fi
}

command -v git &>/dev/null
HAS_GIT=$?
