alias lal='ls -lAh'
alias dua='du -sh `ls -A | grep . | cut -d "'" "'" -f6-`'

alias azerty='setxkbmap fr'
alias bepo='setxkbmap fr bepo'
alias dvorak='setxkbmap dvorak'

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

