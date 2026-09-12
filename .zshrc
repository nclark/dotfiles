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

## mise
eval "$(mise activate zsh)"

export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"

# finch
export DOCKER_HOST="unix:///Applications/Finch/lima/data/finch/sock/finch.sock"

# bun completions
[ -s "/Users/nclark/.bun/_bun" ] && source "/Users/nclark/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

## atuin -- ctrl-r ONLY, nothing else
## --disable-up-arrow  drops up-arrow (emacs/viins/vicmd) and vicmd 'k'
## --disable-ai        drops the '?' binding to Atuin AI
export PATH="$HOME/.atuin/bin:$PATH"
eval "$(atuin init zsh --disable-up-arrow --disable-ai)"
## Leaves only: ^r in emacs+viins, and '/' in vicmd. Take '/' back.
bindkey -M vicmd '/' vi-history-search-backward

. "$HOME/.cargo/env"
export CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1

unalias br 2>/dev/null  # br installer - remove conflicting alias
export TESSDATA_PREFIX=/opt/homebrew/share/tessdata
