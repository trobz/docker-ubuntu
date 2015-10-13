### Allow user can use custom bash shell inside docker ###
### From @anhvu request ###

echo -e "\n# Your customize: aliases, functions .v.v." >> $USER_HOME/.bashrc
echo -e "\n[[ -s $USER_HOME/.trobzer_shell ]] && source $USER_HOME/.trobzer_shell" >> $USER_HOME/.bashrc
