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

## PATH
export PATH=$HOME/.fzf/bin:$PATH
export PATH=$HOME/.sdkman/bin:$PATH
export PATH=$HOME/.google-cloud-sdk/bin:$PATH


if [ "$PS1" ]; then
  if [ "$BASH" ] && [ "$BASH" != "/bin/sh" ]; then
    # The file bash.bashrc already sets the default PS1.
    if [ -f ~/.bashrc ]; then
      . ~/.bashrc
    fi
  fi
fi
