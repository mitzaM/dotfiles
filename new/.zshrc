# ~/.zshrc

autoload -Uz compinit
compinit

# Find and set branch name var if in git repository.
function git_branch_name()
{
  branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
  if [[ $branch == "" ]];
  then
    :
  else
    echo ' - ('$branch')'
  fi
}

# Enable substitution in the prompt.
setopt prompt_subst

# Config for prompt. PS1 synonym.
# prompt='%2/ $(git_branch_name) > '
prompt='%F{grey}%n%f %F{cyan}%~%f%F{green}$(git_branch_name)%f %F{normal}$%f '

[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
# [ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

source $HOME/projects/web/profile

nuke() {
  echo '######## removing containers ########'
  echo '#####################################'
  docker rm --force $(docker ps --all -q)
  echo ''

  echo '######## removing images ########'
  echo '#################################'
  docker rmi --force $(docker images --all -q)
  echo ''

  echo '######## pruning ########'
  echo '#########################'
  docker system prune --all --volumes
  echo ''

  echo '######## dsync coming up ########'
  echo '########      enjoy      ########'
  echo '#################################'
  dsync
}

alias me="man"
eval $(thefuck --alias fuck)
