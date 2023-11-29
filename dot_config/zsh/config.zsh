# - loaded automatically by the init script, in alphabetical order
# - loaded last, after all built-ins in the lib/ directory, to override them
# - ignored by git by default
# 
alias cat=bat
alias ls=eza
alias rm='echo "This is not the command you are looking for."; false'

[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh

eval "$(zoxide init zsh)"
gpg-connect-agent updatestartuptty /bye >/dev/null
