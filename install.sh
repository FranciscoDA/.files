#!/usr/bin/env bash

PROJECT_ROOT="$(dirname $(readlink -f "$0"))"

# install configuration files

cp -rT "$PROJECT_ROOT/terminfo" ~/.terminfo
cp "$PROJECT_ROOT/vimrc" ~/.vimrc
cat "$PROJECT_ROOT/Xdefaults" >> ~/.Xdefaults
cp "$PROJECT_ROOT/bashrc" ~/.bashrc

mkdir -p ~/.vim/colors

# install badwolf vim colorscheme
for file in badwolf.vim goodwolf.vim ; do
	curl "https://raw.githubusercontent.com/sjl/badwolf/master/colors/$file" -o ~/.vim/colors/$file
done


# install vim vundle
if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

# install vundle plugins
vim +PluginInstall +qall

DISTRO_ID=$(bash -c 'source /etc/os-release && echo $ID')

# install distro packages

case $DISTRO_ID in
arch)
	sudo pacman -S bash-completion
	if [ -z "$SSH_CLIENT" ] ; then
		# install packages that are only useful in a graphic setup
		sudo pacman -S adobe-source-code-pro-fonts
	fi
	;;
*)
	echo "Could not install distro-specific packages for distro id: $DISTRO_ID"
	;;
esac

