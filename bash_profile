cat << EOS
 █████████████████████████████████████████████████████████████████████████████╗
 ╚════════════════════════════════════════════════════════════════════════════╝

 ██████╗  ██████╗ ███╗   ██╗████████╗    ██████╗  █████╗ ███╗   ██╗██╗ ██████╗
 ██╔══██╗██╔═══██╗████╗  ██║╚══██╔══╝    ██╔══██╗██╔══██╗████╗  ██║██║██╔════╝
 ██║  ██║██║   ██║██╔██╗ ██║   ██║       ██████╔╝███████║██╔██╗ ██║██║██║
 ██║  ██║██║   ██║██║╚██╗██║   ██║       ██╔═══╝ ██╔══██║██║╚██╗██║██║██║
 ██████╔╝╚██████╔╝██║ ╚████║   ██║       ██║     ██║  ██║██║ ╚████║██║╚██████╗
 ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝   ╚═╝       ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝ ╚═════╝

 █████████████████████████████████████████████████████████████████████████████╗
 ╚════════════════════════════════════════════════════════════════════════════╝

EOS


## variables
export HISTCONTROL=ignoreboth
export HISTSIZE=10000
export TERM=xterm-color
export EDITOR=nvim
export PATH=$HOME/.local/bin:$PATH


## git config
if [[ -n "$GIT_NAME" ]]; then git config --global user.name "$GIT_NAME"; fi
if [[ -n "$GIT_EMAIL" ]]; then git config --global user.email "$GIT_EMAIL"; fi
if [[ -n "$GITHUB_USER" ]]; then git config --global github.user "$GITHUB_USER"; fi
if [[ -n "$http_proxy" ]]; then git config --global http.proxy "$http_proxy"; fi
if [[ -n "$https_proxy" ]]; then git config --global https.proxy "$https_proxy"; fi


## custom functions
source $HOME/.functions


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


## prompt
source ~/.bash_prompt

