alias lal='ls -lAh'
alias dua='du -sh `ls -A | grep . | cut -d "'" "'" -f6-`'

function meteo
{
    curl -4 "wttr.in/$1"
}

alias gnd='git diff --name-only'
compdef _git gnd=git-checkout
alias gu='git fetch --prune && git up'
alias gf='git fetch --tags'
alias gda='git diff --cached'
alias gb='git blist'
alias gbm='git branch --merged'
alias gbnm='git branch --no-merged'
alias gcm='git commit -m'
alias gcob='git checkout -b'
alias gcot='git checkout -t'
# alias gbpurge='git branch --merged | grep -vE "(master|\*)" | xargs git branch -d'
alias gmb='git merge-base `git rev-parse --abbrev-ref HEAD`'

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

function vv
{
    local FILE=$(fzf)
    [ -z $FILE ] || vim $FILE
}

