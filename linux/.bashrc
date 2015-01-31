
# Check for an interactive session
[ -z "$PS1" ] && return

# Aliases
alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -a'
alias lal='ls -al'
alias dua='du `ls -A | grep . | cut -d "'" "'" -f6-`'
alias cd..='cd ..'
alias clean-temp-files='rm *~ ; rm .*~'

# Custom prompt
PS1='\
\[\033[00m\][\
\[\033[31m\]\u\
\[\033[00m\]@\
\[\033[037m\]\h\
\[\033[00m\]:\
\[\033[32m\]\w\
\[\033[00m\]]\
\[\033[00m\]\$\
'

