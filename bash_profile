## variables
export HISTCONTROL=ignoreboth
export HISTSIZE=10000
export TERM=xterm-color
export EDITOR=nvim
export PATH=$HOME/.local/bin:$PATH


if [ "$PS1" ]; then
  if [ "$BASH" ] && [ "$BASH" != "/bin/sh" ]; then
    # The file bash.bashrc already sets the default PS1.
    if [ -f ~/.bashrc ]; then
      . ~/.bashrc
    fi
  fi
fi
