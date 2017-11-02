[ -r ~/.zsh_private ] && source ~/.zsh_private

export VISUAL="vim"
export GOPATH=~/go
export GOBIN=$GOPATH/bin
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/go/bin:$HOME/bin:$GOBIN:$PATH"

alias k=kubectl
alias kpo="k get pods|grep"

ZSH=/usr/share/oh-my-zsh/
ZSH_THEME="robbyrussell"
DISABLE_AUTO_UPDATE="false"
plugins=(git kubectl)

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh
