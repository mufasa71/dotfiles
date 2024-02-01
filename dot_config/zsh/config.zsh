# - loaded automatically by the init script, in alphabetical order
# - loaded last, after all built-ins in the lib/ directory, to override them
# - ignored by git by default
# 
alias cat=bat
alias ls=eza
alias rm='echo "This is not the command you are looking for."; false'

bindkey '^X' create_completion
