alias lal='ls -lAh'
alias dua='du -sh `ls -A | grep . | cut -d "'" "'" -f6-`'

alias starship='play -n -c1 synth whitenoise band -n 100 20 band -n 50 20 gain +30 fade h 1 86400 1'
alias azerty='setxkbmap fr'
alias bepo='setxkbmap fr bepo'
alias dvorak='setxkbmap dvorak'

# alias grr='git reset --hard `git rev-parse --abbrev-ref --symbolic-full-name @{u}`'
alias gu='git up'
alias gf='git fetch --tags'
alias gda='git diff --cached'
alias gb='git blist'
alias gbm='git branch --merged'
alias gbnm='git branch --no-merged'
alias gcob='git checkout -b'
alias gcot='git checkout -t'
alias gbpurge='git branch --merged | grep -vE "(master|\*)" | xargs git branch -d'

# Find and vim if one result found.
function vfind
{
    FILES=$(find $1 -type f -name "$2")
    FILE_COUNT=`echo $FILES | wc -l`
    if [ $FILE_COUNT -eq 1 ] && [ ! -z $FILES ]; then
        vim $FILES
    else
        echo $FILES
    fi
}

function ffind
{
    find $1 -type f -iname \*$2\* 2>/dev/null | grep --color -i $2
}

function dfind
{
    find $1 -type d -iname \*$2\* 2>/dev/null | grep --color -i $2
}

function grr
{
    BRANCH=`git rev-parse --abbrev-ref --symbolic-full-name @{u}`
    QUESTION='git reset --hard '$BRANCH;
    read -q "REPLY?$QUESTION? (y/n) "
    if [ $REPLY = 'y' ]; then
        echo ""
        git reset --hard $BRANCH
    fi
}

