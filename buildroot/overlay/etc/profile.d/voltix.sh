# Voltix OS - Shell profile
# Green-on-black hacker theme

export PS1='\[\033[0;32m\]voltix\[\033[0m\]@\[\033[0;32m\]\h\[\033[0m\]:\[\033[0;36m\]\w\[\033[0m\]\$ '
export PS2='\[\033[0;32m\]> \[\033[0m\]'

alias ll='ls -la --color=auto'
alias la='ls -A'
alias voltix-info='uname -a && echo "" && cat /etc/motd'
