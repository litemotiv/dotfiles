HISTFILE=~/.zhistory
HISTSIZE=1000
SAVEHIST=1000
#LS_COLORS='di=1;94:ln=1;36:bd=5:or=1;31:ex=1;32'

#alias ls='ls --group-directories-first --color=auto -Ap --si'
alias ls='ls -Gph'
alias grep='grep -n --color=auto'

setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
setopt AUTO_CD
setopt NOMATCH
setopt NOTIFY
setopt CORRECT
setopt extended_glob
unsetopt BEEP

bindkey '\e[3~' delete-char
bindkey '^[[5~' beginning-of-line
bindkey '^[[6~' end-of-line
bindkey "^[[H" backward-word
bindkey "^[[F" forward-word 
bindkey '^[[3;5~' delete-word
bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

autoload -Uz compinit
compinit

autoload -U colors
colors

PROMPT="[%{$fg_bold[green]%}%n@%m %{$fg_bold[blue]%}%~%{$reset_color%}]%% "

if [[ ${TERM} != "linux" ]] then
	precmd () { print -Pn "\e]0;[%m] %~\a" }
	preexec () { print -Pn "\e]0;[%m] $1\a" }
fi

# if we're not inside tmux, attach or start new session
if [[ -z "$TMUX" ]]; then
#	tmux att 
fi
