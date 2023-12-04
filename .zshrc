## includes
source ~/.zsh/env
source ~/.zsh/compinstall
source ~/.zsh/aliases
source ~/.zsh/functions
source ~/.zsh/private
source ~/.zsh/host

## prompt
setopt PROMPT_SUBST

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

PROMPT='[%9c]%{%F{green}%}$(parse_git_branch)%{%F{none}%} # '


## history
bindkey '^R' history-incremental-search-backward

## colors
eval `gdircolors ~/.dir_colors`

## direnv
export DIRENV_BASH="/opt/homebrew/bin/bash"
eval "$(direnv hook zsh)"

