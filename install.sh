#/bin/sh
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

ln -s ~/.files/bashrc ~/.bashrc
ln -s ~/.files/vimrc ~/.vimrc
ln -s ~/.files/tmux.conf ~/.tmux.conf
ln -s ~/.files/Xmodmap ~/.Xmodmap
ln -s ~/.files/gitconfig ~/.gitconfig


# In vim type :PlugInstall
# Then :GoInstallBinaries

