#!/bin/bash

if [ ! -d "$HOME/.dotfiles" ]; then
    echo "Installing .dotfiles"

    if [ -d "$HOME/.vim" -o -e "$HOME/.vimrc" ]; then
        echo "Already got a .vim/.vimrc, make a backup and remove the original one"
        exit 1
    fi

    git clone https://github.com/armen/dotfiles.git "$HOME/.dotfiles"
    git clone https://github.com/gmarik/vundle "$HOME/.dotfiles/vim/bundle/Vundle.vim"

    ln -s "$HOME/.dotfiles/vim" "$HOME/.vim"
    ln -s "$HOME/.dotfiles/vimrc" "$HOME/.vimrc"

    vim +PluginInstall +qall

    git clone git://github.com/ndbroadbent/scm_breeze.git ~/.scm_breeze
    ~/.scm_breeze/install.sh

	[ -f "$HOME/.zshrc" ] && echo "[ -f \"$HOME/.dotfiles/bin/init-ssh-agent\" ] && source \"$HOME/.dotfiles/bin/init-ssh-agent\"" >> $HOME/.zshrc
	[ -f "$HOME/.bashrc" ] && echo "[ -f \"$HOME/.dotfiles/bin/init-ssh-agent\" ] && source \"$HOME/.dotfiles/bin/init-ssh-agent\"" >> $HOME/.bashrc

    source ~/.zshrc
else
    echo ".dotfiles is already installed"
    echo "Upgrading current .dotfiles"

    cd $HOME/.dotfiles
    git pull


    if [ ! -d "$HOME/.dotfiles/vim/bundle/Vundle.vim" ]; then
        git clone https://github.com/gmarik/vundle "$HOME/.dotfiles/vim/bundle/Vundle.vim"
    fi

    vim +PluginClean +PluginInstall +PluginUpdate +qall
    cd -
fi

curl -s "https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.ansi-dark" -o ~/.dircolors.ansi-dark
curl -s "https://raw.githubusercontent.com/brantb/solarized/master/xresources/solarized" -o ~/.Xresources
