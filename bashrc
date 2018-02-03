cat << EOS

  ██╗   ██╗ ██████╗ ██╗   ██╗     █████╗ ██████╗ ███████╗    ██╗███╗   ██╗
  ╚██╗ ██╔╝██╔═══██╗██║   ██║    ██╔══██╗██╔══██╗██╔════╝    ██║████╗  ██║
   ╚████╔╝ ██║   ██║██║   ██║    ███████║██████╔╝█████╗      ██║██╔██╗ ██║
    ╚██╔╝  ██║   ██║██║   ██║    ██╔══██║██╔══██╗██╔══╝      ██║██║╚██╗██║
     ██║   ╚██████╔╝╚██████╔╝    ██║  ██║██║  ██║███████╗    ██║██║ ╚████║
     ╚═╝    ╚═════╝  ╚═════╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝    ╚═╝╚═╝  ╚═══╝

  ██████╗ ███████╗██╗   ██╗███████╗███╗   ██╗██╗   ██╗
  ██╔══██╗██╔════╝██║   ██║██╔════╝████╗  ██║██║   ██║
  ██║  ██║█████╗  ██║   ██║█████╗  ██╔██╗ ██║██║   ██║
  ██║  ██║██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╗██║╚██╗ ██╔╝
  ██████╔╝███████╗ ╚████╔╝ ███████╗██║ ╚████║ ╚████╔╝██╗
  ╚═════╝ ╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═══╝  ╚═══╝ ╚═╝

  ██████╗  ██████╗ ███╗   ██╗████████╗    ██████╗  █████╗ ███╗   ██╗██╗ ██████╗
  ██╔══██╗██╔═══██╗████╗  ██║╚══██╔══╝    ██╔══██╗██╔══██╗████╗  ██║██║██╔════╝
  ██║  ██║██║   ██║██╔██╗ ██║   ██║       ██████╔╝███████║██╔██╗ ██║██║██║
  ██║  ██║██║   ██║██║╚██╗██║   ██║       ██╔═══╝ ██╔══██║██║╚██╗██║██║██║
  ██████╔╝╚██████╔╝██║ ╚████║   ██║       ██║     ██║  ██║██║ ╚████║██║╚██████╗██╗
  ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝   ╚═╝       ╚═╝     ╚═


EOS


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
export PATH=~/.fzf/bin:$PATH


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

