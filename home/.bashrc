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
alias ls="eza --hyperlink --icons"
alias icat="kitten icat"

TZ="Europe/Amsterdam"
PS1="\n\[\033[35m\]\w \[\033[0m\] \n\033[36m\]\D{%H:%M} \[\033[31m\]\u@\h → \[\033[0m\]"
