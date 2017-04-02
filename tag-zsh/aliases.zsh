# Mercurial
alias hgc='hg commit'
alias hgb='hg branch'
alias hgba='hg branches'
alias hgbk='hg bookmarks'
alias hgco='hg checkout'
alias hgd='hg diff'
alias hged='hg diffmerge'
# pull and update
alias hgi='hg incoming'
alias hgl='hg pull -u'
alias hglr='hg pull --rebase'
alias hgo='hg outgoing'
alias hgp='hg push'
alias hgs='hg status'
alias hgsl='hg log --limit 20 --template "{node|short} | {date|isodatesec} | {author|user}: {desc|strip|firstline}\n" '
alias hgca='hg commit --amend'
# list unresolved files (since hg does not list unmerged files in the status command)
alias hgun='hg resolve --list'

function hgic() {
    hg incoming "$@" | grep "changeset" | wc -l
}

function hgoc() {
    hg outgoing "$@" | grep "changeset" | wc -l
}

function fe() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

function fbr() {
  local branches branch
  branches=$(hg branches -vv) &&
    branch=$(echo "$branches" | fzf +m) &&
    hg up $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

alias ls="ls --color -F"
alias ll="ls --color -lh"
alias la='ls -a'
alias l="ls"
alias tree='tree -C'
alias grep='grep --color=auto'

# coloured manuals
man() {
	env \
		LESS_TERMCAP_mb=$(printf "\e[1;31m") \
		LESS_TERMCAP_md=$(printf "\e[1;31m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;32m") \
		man "$@"
}
