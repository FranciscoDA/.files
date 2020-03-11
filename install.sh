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

function http_install_into() {
	local FS_PATH="$1"
	local HTTP_URL="$2"
	if [ -e "$PATH" ] ; then
		local ZFLAG="-z '$FS_PATH'"
	else
		local ZFLAG=''
	fi
	curl -o "$FS_PATH" $ZFLAG "$HTTP_URL"
}

# install urxvt extensions
URXVT_EXT_DIR="$HOME/.urxvt/ext"
mkdir -p "$URXVT_EXT_DIR"
http_install_into "$URXVT_EXT_DIR/tabbedex" "https://raw.githubusercontent.com/shaggytwodope/tabbedex-urxvt/master/tabbedex"

# install badwolf vim colorscheme
VIM_COLOR_DIR="$HOME/.vim/colors"
mkdir -p "$VIM_COLOR_DIR"
for file in badwolf.vim goodwolf.vim ; do
	http_install_into "$VIM_COLOR_DIR/$file" "https://raw.githubusercontent.com/sjl/badwolf/master/colors/$file"
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

