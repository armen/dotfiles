#!/bin/bash

# Give vim a pseudo-terminal so it doesn't print "Input/Output is not ... a
# terminal" — those warnings, emitted after vim switches the terminal to raw
# mode, stair-step all following output when the installer runs non-interactively
# (e.g. piped over SSH). Feeding `script` the real terminal on stdin (<&1) also
# sizes the pty to the window, so vim isn't stuck at the default 80 columns.
vim_headless() {
    if [ -t 0 ] && [ -t 1 ]; then
        vim "$@"
    else
        script -qec "vim $*" /dev/null <&1
    fi
}

if [ ! -d "$HOME/.dotfiles" ]; then
    echo "Installing .dotfiles"

    if [ -d "$HOME/.vim" -o -e "$HOME/.vimrc" -o -e "$HOME/.tmux.conf" ]; then
        echo "Already got a .vim/.vimrc, make a backup and remove the original one"
        exit 1
    fi

    git clone https://github.com/armen/dotfiles.git "$HOME/.dotfiles"
    git clone https://github.com/gmarik/vundle "$HOME/.dotfiles/vim/bundle/Vundle.vim"

    ln -s "$HOME/.dotfiles/vim" "$HOME/.vim"
    ln -s "$HOME/.dotfiles/vimrc" "$HOME/.vimrc"
    ln -s "$HOME/.dotfiles/tmux.conf" "$HOME/.tmux.conf"

    vim_headless +PluginInstall +qall

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

    vim_headless +PluginClean +PluginInstall +PluginUpdate +qall
    cd -
fi

## Sync with the following
# curl -s "https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.ansi-dark" -o dircolors.ansi-dark
cp "$HOME/.dotfiles/dircolors.ansi-dark" "$HOME/.dircolors.ansi-dark"

## zsh theme + PATH

# Make the "armen" theme discoverable by oh-my-zsh and select it in ~/.zshrc.
if [ -d "$HOME/.oh-my-zsh" ]; then
    mkdir -p "$HOME/.oh-my-zsh/custom/themes"
    ln -sfn "$HOME/.dotfiles/oh-my-zsh/themes/armen.zsh-theme" \
            "$HOME/.oh-my-zsh/custom/themes/armen.zsh-theme"
fi

touch "$HOME/.zshrc"
if grep -q '^ZSH_THEME=' "$HOME/.zshrc"; then
    sed -i 's/^ZSH_THEME=.*/ZSH_THEME="armen"/' "$HOME/.zshrc"
else
    echo 'ZSH_THEME="armen"' >> "$HOME/.zshrc"
fi

touch "$HOME/.zshenv"
if ! grep -qF '# dotfiles: PATH' "$HOME/.zshenv"; then
    cat >> "$HOME/.zshenv" <<'ZSHENV'

# dotfiles: PATH
for d in "$HOME/bin" "$HOME/.local/bin" "$HOME/.dotfiles/bin"; do
    case ":$PATH:" in
        *":$d:"*) ;;
        *) PATH="$d:$PATH" ;;
    esac
done
export PATH
ZSHENV
fi

## crontab

# Save tmux sessions every 5 minutes.
if command -v crontab >/dev/null; then
    CRON_LINE='*/5 * * * * ~/.dotfiles/bin/tmux-session save'
    ( crontab -l 2>/dev/null | grep -Fv 'tmux-session save'; echo "$CRON_LINE" ) | crontab -
fi
