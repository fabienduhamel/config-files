alias lal='ls -lAh'
alias dua='du -sh `ls -A | grep . | cut -d "'" "'" -f6-`'

alias azerty='setxkbmap fr'
alias bepo='setxkbmap fr bepo'
alias dvorak='setxkbmap dvorak'

# Find and vim if one result found.
function vfind
{
    FILE_COUNT=`find "$@" | wc -l`
    FILES=`find "$@"`
    if [ $FILE_COUNT -eq 1 ]; then
        vim $FILES
    else
        echo -e $FILES
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

