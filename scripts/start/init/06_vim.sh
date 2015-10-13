set -e

if [[ $VIM_SETUP -eq 1 ]]; then
  info 'Install preconfigured VIM plugins (neobundle, bufexplorer, nerdtree, syntastic, airline, fugitive, python-mode)'

  mv /tmp/setup/vim/.vim* $USER_HOME
  echo "export TERM='xterm-256color'" >> $USER_HOME/.bashrc

  info 'VIM support powerline custom font, if your terminal is configured with a custom powerfont,'
  info 'you can set the environement variable LC_POWERFONT=1 on the your client and powerfont will '
  info 'be automatically activated on VIM at your next container SSH connection.'
  info 'see: https://github.com/bling/vim-airline'

  success "VIM configured"
fi
