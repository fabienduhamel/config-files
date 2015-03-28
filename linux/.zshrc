# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git safe-paste)

# User configuration

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias lal='ls -lAh'
alias dua='du -sh `ls -A | grep . | cut -d "'" "'" -f6-`'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Custom functions

# Find and vim if one result.
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

# Sinks can be found with: pactl list |grep "Sortie audio" -2
# Switches video and audio to a dual screen with TV cloned from monitor.
function hdmi
{
    xrandr --output DVI-I-3 --off
    xrandr --output DVI-I-2 --mode 1920x1080 --pos 0x0 --primary\
           --output HDMI-0 --mode 1920x1080 --pos 0x0

    pactl set-default-sink alsa_output.pci-0000_01_00.1.hdmi-stereo-extra1
    INPUTS=($(pactl list sink-inputs | grep Input | awk '{print $3}' | sed -r 's/^.{1}//'))
    pactl set-card-profile 0 output:hdmi-stereo-extra1
    pactl set-default-sink alsa_output.pci-0000_01_00.1.hdmi-stereo-extra1
    for i in ${INPUTS[*]}; do pactl move-sink-input $i alsa_output.pci-0000_01_00.1.hdmi-stereo-extra1; done
}

# Switches video and audio to a dual monitor screen.
function normal
{
    xrandr --output HDMI-0 --off
    xrandr --output DVI-I-2 --mode 1920x1080 --pos 1920x0 --primary\
           --output DVI-I-3 --mode 1920x1080 --pos 0x0

    pactl set-default-sink alsa_output.pci-0000_00_1b.0.analog-stereo
    INPUTS=($(pactl list sink-inputs | grep Input | awk '{print $3}' | sed -r 's/^.{1}//'))
    pactl set-card-profile 0 output:analog-stereo
    pactl set-default-sink alsa_output.pci-0000_00_1b.0.analog-stereo
    for i in ${INPUTS[*]}; do pactl move-sink-input $i alsa_output.pci-0000_00_1b.0.analog-stereo; done
}


# History search
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# Better zsh git prompt with zsh-git-prompt 
source $ZSH/plugins/zsh-git-prompt/zshrc.sh
# Overriding colors
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_bold[red]%}"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[green]%}%{●%G%}"
ZSH_THEME_GIT_PROMPT_CONFLICTS="%{$fg[magenta]%}%{✖%G%}"
ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg[red]%}%{✚%G%}"
# Set zsh-git-prompt and time in $PROMPT
PROMPT='${ret_status}%{$fg_bold[green]%}[%*] %{$fg[cyan]%}%c %{$fg_bold[blue]%}$(git_super_status)%{$fg_bold[blue]%} %{$reset_color%}'

