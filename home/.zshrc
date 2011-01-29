HISTFILE=~/.config/zhistory
HISTSIZE=1000
SAVEHIST=1000
LS_COLORS='di=1;94:ln=1;36:bd=5:or=1;31:ex=1;32'

alias ls='ls --color=auto -h'
alias grep='grep -n --color=auto'
alias www='/usr/bin/chromium --proxy-server=127.0.0.1:8118'

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
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
bindkey '^[[3;5~' delete-word
bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

autoload -Uz compinit
compinit

autoload -U colors
colors

PROMPT="[%{$fg_bold[black]%}%n@%m %{$fg_bold[blue]%}%~%{$reset_color%}]%% "

if [[ ${TERM} != "linux" ]] then
	precmd () { print -Pn "\e]0;[%m] %~\a" }
	preexec () { print -Pn "\e]0;[%m] $1\a" }
fi

# if we're not inside tmux, attach or start new session
if [[ -z "$TMUX" ]]; then
	tmux att 
fi
