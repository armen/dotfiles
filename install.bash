#!/bin/bash

if [ ! -d "$HOME/.dotfiles" ]; then
    echo "Installing .dotfiles"
    #git clone https://github.com/armen/dotfiles.git "$HOME/.dotfiles"

	git clone https://github.com/gmarik/vundle "$HOME/.dotfiles/vim/bundle/Vundle.vim"

    ln -s "$HOME/.dotfiles/vim" "$HOME/.vim"
    ln -s "$HOME/.dotfiles/vimrc" "$HOME/.vimrc"

	vim +PluginInstall +qall
else
    echo ".dotfiles is already installed"
fi
