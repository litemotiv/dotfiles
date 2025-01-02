# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

export EDITOR=/usr/bin/vim
RANGER_LOAD_DEFAULT_RC=false

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

#alias ls="ls --color=auto --hyperlink=auto"
alias la="ls -a"
alias ll="ls -la"
alias icat="kitten icat"

if [ -x "$(command -v eza)" ]; then
	alias ls="eza --hyperlink --group-directories-first --icons"
fi

TZ="Europe/Amsterdam"
COLOR1='\[\033[35m\]'
COLOR2='\[\033[36m\]'
COLOR3='\[\033[31m\]'
COLRESET='\[\033[0m\]'

if [ -n "$container" ]; then
	COLOR3='\[\033[0;37m\]'
	ICON='⏣ '

	if [ -n "$CONTAINER_ID" ]; then
		LABEL=" [${CONTAINER_ID}]"
	fi
fi

PROMPT_COMMAND='printf "\033]0;${ICON}%s\007" "${PWD/#$HOME/\~}"'
PS1="\n${COLOR1}\w \n${COLOR2}\D{%H:%M} ${COLOR3}\u@\h${LABEL} →${COLRESET} "
