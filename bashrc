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
██║  ██║██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╗██║╚██╗ ██╔╝ ██████╔╝███████╗ ╚████╔╝ ███████╗██║ ╚████║ ╚████╔╝██╗
╚═════╝ ╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═══╝  ╚═══╝ ╚═╝

██████╗  ██████╗ ███╗   ██╗████████╗    ██████╗  █████╗ ███╗   ██╗██╗ ██████╗
██╔══██╗██╔═══██╗████╗  ██║╚══██╔══╝    ██╔══██╗██╔══██╗████╗  ██║██║██╔════╝
██║  ██║██║   ██║██╔██╗ ██║   ██║       ██████╔╝███████║██╔██╗ ██║██║██║
██║  ██║██║   ██║██║╚██╗██║   ██║       ██╔═══╝ ██╔══██║██║╚██╗██║██║██║
██████╔╝╚██████╔╝██║ ╚████║   ██║       ██║     ██║  ██║██║ ╚████║██║╚██████╗██╗
╚═════╝  ╚═════╝ ╚═╝  ╚═══╝   ╚═╝       ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝ ╚═════╝╚═╝




EOS


## git config
if [[ -n "$GIT_NAME" ]]; then git config --global user.name "$GIT_NAME"; fi
if [[ -n "$GIT_EMAIL" ]]; then git config --global user.email "$GIT_EMAIL"; fi
if [[ -n "$GITHUB_USER" ]]; then git config --global github.user "$GITHUB_USER"; fi
if [[ -n "$http_proxy" ]]; then git config --global http.proxy "$http_proxy"; fi
if [[ -n "$https_proxy" ]]; then git config --global https.proxy "$https_proxy"; fi


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


## prompt
source ~/.git-prompt
source ~/.bash_prompt


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
if [[ -f "~/.config/devenv_profile" ]]; then
  source ~/.config/devenv_profile
fi

