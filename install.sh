#/bin/sh
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

host=`hostname -s`
os=`uname`

ln -sf ~/.files/vimrc ~/.vimrc
ln -sf ~/.files/tmux.conf ~/.tmux.conf
ln -sf ~/.files/Xmodmap ~/.Xmodmap
ln -sf ~/.files/gitconfig ~/.gitconfig
ln -sf ~/.files/muttrc~/.muttrc

if [ "$os" == "OpenBSD" ]; then
	ln -sf ~/.files/$host/xsesssion ~/.xsession
	ln -sf ~/.files/$host/Xdefaults ~/.Xdefaults
fi


if [ "$os" == "Arch" ]; then
	ln -sf ~/.files/zshrc ~/.zshrc
fi


# In vim type :PlugInstall
# Then :GoInstallBinaries

