#!/usr/bin/env bash

PROJECT_ROOT="$(dirname $(realpath "$0"))"

# install configuration files

cp -rT "$PROJECT_ROOT/terminfo" ~/.terminfo
cp "$PROJECT_ROOT/vimrc" ~/.vimrc
cp "$PROJECT_ROOT/bashrc" ~/.bashrc


# install Xresources if not present
mkdir -p $HOME/.Xresources.d/
cp "$PROJECT_ROOT/Xdefaults" ~/.Xresources.d/franciscoda.files
if ! grep -F -q -s '#include ".Xresources.d/franciscoda.files"' $HOME/.Xdefaults ; then
	echo '#include ".Xresources.d/franciscoda.files"' >> $HOME/.Xdefaults
fi
xrdb ~/.Xdefaults

# install badwolf vim colorscheme
VIM_COLOR_DIR=$(realpath ~/.vim/colors)
mkdir -p "$VIM_COLOR_DIR"
for file in badwolf.vim goodwolf.vim ; do
	if ! [ -a "$VIM_COLOR_DIR/$file" ]; then
		curl "https://raw.githubusercontent.com/sjl/badwolf/master/colors/$file" -o "$VIM_COLOR_DIR/$file"
	fi
done


# install vim vundle
if ! [ -d ~/.vim/bundle/Vundle.vim ]; then
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

# install vundle plugins
vim +PluginInstall +qall

# install distro packages
DISTRO_ID=$(bash -c 'source /etc/os-release && echo $ID')
PACKAGES_TO_INSTALL=()

function arch_add_missing_pkgs() {
	for PKG in $@; do
		if ! pacman -Qi $PKG >/dev/null 2>/dev/null ; then
			PACKAGES_TO_INSTALL+=("$PKG")
		fi
	done
}

case $DISTRO_ID in
arch)
	arch_add_missing_pkgs bash-completion
	if [ -z "$SSH_CLIENT" ]; then
		# install packages that are only useful in a graphic setup
		arch_add_missing_pkgs adobe-source-code-pro-fonts powerline-fonts
	fi
	if [ ${#PACKAGES_TO_INSTALL[@]} -gt 0 ]; then
		sudo pacman -S ${PACKAGES_TO_INSTALL[@]}
	fi
	;;
*)
	echo "Could not install distro-specific packages for distro id: $DISTRO_ID"
	;;
esac

