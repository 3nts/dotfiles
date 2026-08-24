export BROWSER=firefox
export EDITOR=nvim

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export CLAUDE_CONFIG_DIR="${XDG_CONFIG_HOME}/claude"
export DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"
export STARSHIP_CONFIG="${XDG_CONFIG_HOME}/starship/config.toml"

export CARGO_HOME="${XDG_DATA_HOME}"/cargo
export GNUPGHOME="${XDG_DATA_HOME}"/gnupg
export GOPATH="${XDG_DATA_HOME}"/go

export HISTFILE="${XDG_STATE_HOME}"/bash_history
export PSQL_HISTORY="${XDG_STATE_HOME}"/psql_history
export PYTHON_HISTORY="${XDG_STATE_HOME}"/python_history
export SQLITE_HISTORY="${XDG_STATE_HOME}"/sqlite_history

export CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=1
export GOPROXY=direct
export GOSUMDB=off

PATH=$PATH:$HOME/bin
PATH=$PATH:$HOME/.local/bin
PATH=$PATH:$GOPATH/bin

PATH=$PATH:'/opt/homebrew/opt/libpq/bin'

eval "$(/opt/homebrew/bin/brew shellenv bash)"

[[ -f ~/.bashrc ]] && . ~/.bashrc
