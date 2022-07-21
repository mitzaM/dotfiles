# Add ~/.local/ to PATH
export PATH=$HOME/.local/bin:$PATH

source ~/.bashrc

##################################

source $HOME/projects/web/profile

# source $HOME/.bash_prompt
function parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}
setopt PROMPT_SUBST
export PROMPT='%F{grey}%n%f %F{cyan}%~%f %F{green}$(parse_git_branch)%f %F{normal}$%f '

# [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

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

