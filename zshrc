ZSH=/usr/share/oh-my-zsh/
ZSH_THEME="robbyrussell"
DISABLE_AUTO_UPDATE="true"


ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source ~/.zsh_private

export EDITOR="nvim"

export GOPATH=~/go
export GOBIN=$GOPATH/bin

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/go/bin:$HOME/bin:$GOBIN:$PATH"

export MONGO_CONNECTION_STRING=localhost
#ZSH_THEME="ys"
HIST_STAMPS="mm/dd/yyyy"

plugins=(git git-extras httpie jsontools mvn aws docker kubectl)

source $ZSH/oh-my-zsh.sh

export MOZ_ALLOW_GTK_DARK_THEME=true

alias k=kubectl
alias nano=nvim
alias vim=nvim

agp () {
	echo $AWS_DEFAULT_PROFILE
}

asp () {
    local rprompt=${RPROMPT/<aws:$(agp)>/}
    export AWS_DEFAULT_PROFILE=$1
    export AWS_PROFILE=$1
    export RPROMPT="<aws:$AWS_DEFAULT_PROFILE>$rprompt"
}

alias snip="pbpaste | gist -p | pbcopy"

dclean () {
    docker stop $(docker ps -a -q)
    docker rm $(docker ps -a -q)
    docker rmi $(docker images -q)
}

alias gpf="git push --force-with-lease"
alias gc="git commit -m"
alias gs="git status -s"
alias gd="git diff"

alias gupdate="go get -u all"

alias gmaster="find . -name \".git\" -type d | sed 's/\/.git//' |  xargs -P10 -I{} git -C {} checkout master"
alias gpull="find . -name \".git\" -type d | sed 's/\/.git//' |  xargs -P10 -I{} git -C {} pull"
alias greset="find . -name \".git\" -type d | sed 's/\/.git//' |  xargs -P10 -I{} git -C {} reset --hard origin/master"

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
precmd() {
    vcs_info
}

local k8s_info='k8s:$fg[cyan]`grep current ~/.kube/config | cut -d " " -f 2`'
# Prompt format:
#
# PRIVILEGES USER @ MACHINE in DIRECTORY on git:BRANCH STATE [TIME] C:LAST_EXIT_CODE
# $ COMMAND
#
# For example:
#
# % ys @ ys-mbp in ~/.oh-my-zsh on git:master x [21:47:42] C:0
# $
#PROMPT="
#%{$terminfo[bold]$fg[blue]%}#%{$reset_color%} \
#%(#,%{$bg[yellow]%}%{$fg[black]%}%n%{$reset_color%},%{$fg[cyan]%}%n) \
#%{$fg[white]%}@ \
#%{$fg[green]%}%m \
#%{$fg[white]%}in \
#%{$terminfo[bold]$fg[yellow]%}%~%{$reset_color%}\
#${hg_info}\
#${git_info}\
# ${k8s_info} \
#%{$fg[white]%}[%*] $exit_code
#%{$terminfo[bold]$fg[red]%}$ %{$reset_color%}"

export KUBE_EDITOR="nvim"
export VISUAL="nvim"

#eval $(thefuck --alias)

alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

alias yinstall='yaourt -S --noconfirm'
alias yupdate='yaourt -Syu --aur --noconfirm'

# colours
export bold="$(tput bold)"
export underline="$(tput smul)"
export standout="$(tput smso)"
export normal="$(tput sgr0)"
export black="$(tput setaf 0)"
export red="$(tput setaf 1)"
export green="$(tput setaf 2)"
export yellow="$(tput setaf 3)"
export blue="$(tput setaf 4)"
export magenta="$(tput setaf 5)"
export cyan="$(tput setaf 6)"
export white="$(tput setaf 7)"

# funcs

yclean() {
	yaourt -Rsn --noconfirm $(yaourt -Qdtq --noconfirm)
	yaourt -Scc --noconfirm
}

# ##kgp() {
#  kubectl get pods "$@" \
#        | sed "s/Running/${green}Running${normal}/g" \
#        | sed "s/Pending/${yellow}Pending${normal}/g" \
#        | sed "s/Completed/${blue}Completed${normal}/g" \
#        | sed "s/Error/${red}Error${normal}/g" \
#        | sed "s/CrashLoopBackOff/${red}CrashLoopBackOff${normal}/g"
#}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
