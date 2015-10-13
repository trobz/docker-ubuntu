### Keychain ###
# Let re-use ssh-agent between logins
eval $(keychain --eval -Q --quiet --attempts 5 id_rsa)
source $HOME/.keychain/$HOSTNAME-sh
