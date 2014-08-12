Dotfiles
====

## Installation

### Install by executing remote bash script 

This is insecure, make sure you read the bash script first.

	curl --silent https://raw.githubusercontent.com/armen/dotfiles/master/install.bash | bash

### golang integration

To enable golang integration comment out following line from the ~/.dotfiles/vim/settings.vim file

	let g:go_disable_autoinstall = 1
