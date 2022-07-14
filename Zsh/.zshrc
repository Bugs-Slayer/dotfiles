# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="robbyrussell"

# Plugins
plugins=(git)
source $ZSH/oh-my-zsh.sh

# Opening a new tab/pane in the same directory in Windows Terminal
keep_current_path() {
  # printf "\e]9;9;%s\e\\" "$(wslpath -w "$PWD")"
  printf "\e]9;9;%s\e\\" "$PWD"
}
precmd_functions+=(keep_current_path)