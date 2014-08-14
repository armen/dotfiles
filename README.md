Dotfiles
====

### Installation

#### Install by cloning the repository


	git clone https://github.com/armen/dotfiles.git ~/.dotfiles
	cd ~/.dotfiles
    # Read the installation script first
	./install.bash
	cd -

#### Install by executing remote installation bash script 

This is insecure, make sure you read the bash script first.

	curl --silent https://raw.githubusercontent.com/armen/dotfiles/master/install.bash | bash

#### golang integration

To enable golang integration comment out following line from the ~/.dotfiles/vim/settings.vim file

	let g:go_disable_autoinstall = 1
