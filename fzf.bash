# Setup fzf
# ---------
if [[ ! "$PATH" == */home/devenv/.fzf/bin* ]]; then
  export PATH="$PATH:/home/devenv/.fzf/bin"
fi

# Man path
# --------
if [[ ! "$MANPATH" == */home/devenv/.fzf/man* && -d "/home/devenv/.fzf/man" ]]; then
  export MANPATH="$MANPATH:/home/devenv/.fzf/man"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/devenv/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/devenv/.fzf/shell/key-bindings.bash"

