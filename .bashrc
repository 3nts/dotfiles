[[ $- != *i* ]] && return

shopt -s globstar histappend

alias vim='nvim'
alias ls='ls --color=auto'
alias ssh='TERM=xterm-256color ssh'

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

[[ -r /opt/homebrew/etc/profile.d/bash_completion.sh ]] \
  && source /opt/homebrew/etc/profile.d/bash_completion.sh

eval "$(uv generate-shell-completion bash)"
eval "$(uvx --generate-shell-completion bash)"
eval "$(just --completions bash)"

eval "$(starship init bash)"
eval "$(direnv hook bash)"
eval "$(fzf --bash)"

# shell history configuration must come after hooks;
# these are not environment variables
HISTCONTROL=ignoreboth
HISTIGNORE="clear:history:[bf]g:exit:* --help"
HISTSIZE=10000
HISTFILESIZE=400000000
PROMPT_COMMAND="${PROMPT_COMMAND:-:} ; history -a"
