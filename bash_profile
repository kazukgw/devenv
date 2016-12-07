export HISTCONTROL=ignoreboth
export HISTSIZE=10000
export TERM=xterm-color
export EDITOR=nvim

source $HOME/.functions

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export PATH=~/.fzf/bin:$PATH

source ~/.git-completion

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash  ]; then
    complete -o default -o nospace -F _git g;
  fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config"  ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

export ENHANCD_COMMAND=cdd
source ~/.config/enhancd/init.sh

source ~/.bash_prompt

