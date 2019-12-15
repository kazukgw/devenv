if [ -z "$NVIM_LISTEN_ADDRESS" ]; then

cat << EOS


  ██████╗  ██████╗ ███╗   ██╗████████╗    ██████╗  █████╗ ███╗   ██╗██╗ ██████╗
  ██╔══██╗██╔═══██╗████╗  ██║╚══██╔══╝    ██╔══██╗██╔══██╗████╗  ██║██║██╔════╝
  ██║  ██║██║   ██║██╔██╗ ██║   ██║       ██████╔╝███████║██╔██╗ ██║██║██║
  ██║  ██║██║   ██║██║╚██╗██║   ██║       ██╔═══╝ ██╔══██║██║╚██╗██║██║██║
  ██████╔╝╚██████╔╝██║ ╚████║   ██║       ██║     ██║  ██║██║ ╚████║██║╚██████╗██╗
  ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝   ╚═╝       ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝ ╚═════╝╚═╝
EOS
fi

## variables
export HISTCONTROL=ignoreboth
export HISTSIZE=10000
export TERM=xterm-color
export EDITOR=nvim
export PATH=$HOME/.local/bin:$PATH
export DOCKER_HOST=tcp://$(ip route | head -n 1 | awk '{print $3}'):1234

## env go
export GOROOT=$HOME/.go
export GOPATH=$HOME
export PATH=$GOPATH/bin:$GOROOT/bin:/usr/local/go/bin:$PATH

## env node
export N_PREFIX=$HOME/.n
export PATH=$HOME/.n/bin:$PATH

## env pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

## PATH
export PATH=$HOME/.fzf/bin:$PATH
export PATH=$HOME/.sdkman/bin:$PATH
export PATH=$HOME/.google-cloud-sdk/bin:$PATH


## prompt
source ~/.git-prompt
source ~/.bash_prompt


## git config
[ -n "$GIT_NAME" ] && git config --global user.name "$GIT_NAME"
[ -n "$GIT_EMAIL" ] && git config --global user.email "$GIT_EMAIL"
[ -n "$GITHUB_USER" ] && git config --global github.user "$GITHUB_USER"
[ -n "$http_proxy" ] && git config --global http.proxy "$http_proxy"
[ -n "$https_proxy" ] && git config --global https.proxy "$https_proxy"


## completion
source ~/.git-completion


# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f $HOME/.git-completion ]; then
  complete -o default -o nospace -F _git g;
fi;


# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config"  ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;


## init tools
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export PATH=~/.fzf/bin:$HOME/.google-cloud-sdk/bin:$PATH


## sdkman
source ~/.sdkman/bin/sdkman-init.sh


## custom functions
source $HOME/.functions


# alias
alias l='ls -G -a --color=auto'
alias ls='ls -G -a --color=auto'
alias ll='ls -G -lah --color=auto'
alias tmux='tmux -u'
alias t='tmux'
alias ttt='tmux new -s dev'
alias g='git'
alias tiga='tig --all'

alias vim=nvim
alias vi=nvim
alias v=nvim
alias vimrc='nvim $HOME/.config/nvim/init.vim'


## devenv_profile
[ -f "~/.config/devenv_profile" ] && source ~/.config/devenv_profile

## extenstion
[ -f ~/.bashrc_extension ] && source $HOME/.bashrc_extension


