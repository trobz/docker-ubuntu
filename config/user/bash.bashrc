
# load additional bash scripts
if [ -d /etc/bash.d ]; then
  for i in /etc/bash.d/*.sh; do
    if [ -r $i ]; then
      . $i
    fi
  done
  unset i
fi
