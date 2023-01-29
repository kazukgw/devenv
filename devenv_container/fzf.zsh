# Setup fzf
# ---------
if [[ ! "$PATH" == */home/devenv/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/devenv/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/devenv/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/devenv/.fzf/shell/key-bindings.zsh"
