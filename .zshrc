## includes
source ~/.zsh/env
source ~/.zsh/compinstall
source ~/.zsh/aliases
source ~/.zsh/autocomplete
source ~/.zsh/functions
source ~/.zsh/private
source ~/.zsh/host

## prompt
setopt prompt_subst

PS1='[%n]%15<...<%~%<<% $(git_prompt_info) # '

## history
bindkey '^R' history-incremental-search-backward

## colors
eval `gdircolors ~/.dir_colors`

## direnv
eval "$(direnv hook zsh)"

## asdf
test -s "/usr/local/opt/asdf/asdf.sh" && source "/usr/local/opt/asdf/asdf.sh"

