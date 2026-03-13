# includes
source ~/.zsh/env
source ~/.zsh/compinstall
source ~/.zsh/aliases
source ~/.zsh/functions
source ~/.zsh/private
source ~/.zsh/host
for completion_file in ~/.zsh/completions/*; do
  source "$completion_file"
done

## prompt
setopt PROMPT_SUBST

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

PROMPT='[%9c]%{%F{green}%}$(parse_git_branch)%{%F{none}%} # '

## history
bindkey '^R' history-incremental-search-backward

## edit command line in $EDITOR with ctrl-e
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^E' edit-command-line

## colors
eval `gdircolors ~/.dir_colors`

## direnv
export DIRENV_BASH="/opt/homebrew/bin/bash"
eval "$(direnv hook zsh)"

## asdf
. /opt/homebrew/opt/asdf/libexec/asdf.sh

export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"

# finch
export DOCKER_HOST="unix:///Applications/Finch/lima/data/finch/sock/finch.sock"

# bun completions
[ -s "/Users/nclark/.bun/_bun" ] && source "/Users/nclark/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

## atuin
eval "$(atuin init zsh)"
# restore default up-arrow (atuin overrides it)
bindkey '^[[A' up-line-or-history
bindkey '^[OA' up-line-or-history
