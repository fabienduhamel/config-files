alias lal='ls -lAh'
alias dua='du -sh `ls -A | grep . | cut -d "'" "'" -f6-`'

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
