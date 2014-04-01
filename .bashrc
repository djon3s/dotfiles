# welcome to my .bashrc, nothing much interesting and most of it is pilfered from
# looking at others .bashrc and running google-copy-paste cycles.

# TODO combine bashes readline kill/copy with emacs kill ring
# maybe try http://stackoverflow.com/questions/994563/integrate-readlines-kill-ring-and-the-x11-clipboard given we have emacs kill ring integrated with the X11 clipboard
# if you're reading this and know how to do it please open an issue!


# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# start irssi in screen in detatched mode for session name "irc"
if ! ps -e | grep "irssi" > /dev/null
then
    screen -S irc -d -m usewithtor irssi
fi

# "in my .bashrc allows me to start typing a command (like "vim ") 
# and then use my up and down arrows to search through my history 
# (think ctrl-r) " - http://www.reddit.com/r/linuxadmin/comments/1x0ql2/whats_a_linux_command_you_wish_you_had_known/cf7tbne
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=200000

# ignore commands from task warrior - they are common 
HISTIGNORE='task *'

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# for commands that give info we don't necessarily want on github
if [ -f ~/.bash_aliases_private ]; then
    . ~/.bash_aliases_private
fi

# for some random perl cruft I'm not sure I use, if anything breaks, uncomment
#if [ -f ~/.perl ]; then
#    . ~/.perl
#fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# So we have access to go. From the go binary distribution README file
export GOROOT=$HOME/src/go
export PATH=$PATH:$GOROOT/bin

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

#to enable RVM to load the right environment
function rvm_enable { 
    source $(rvm 2.0.0 do rvm env --path)
}

#caps lock as control key - end emacs pinky!
setxkbmap -option ctrl:nocaps

# Save and reload the history after each command finishes (for shared history)
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# TODO there is some way to do this that I learnt recently
# that is completely ridiculous, obvious and simple that when
# I remember this cruft can be deleted
export MARKPATH=$HOME/.marks
function jump { 
    cd -P $MARKPATH/$1 2>/dev/null || echo "No such mark: $1"
}
function mark { 
    mkdir -p $MARKPATH; ln -s $(pwd) $MARKPATH/$1
}
function unmark { 
    rm -i $MARKPATH/$1 
}
function marks {
    ls -l $MARKPATH | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
}

# shorter command to move just files of type file
alias mvfiles='find . -maxdepth 1 -type f -exec mv {} sort/ \;';

#shorter command to activate virtual env in python
alias actenv='source env/bin/activate'

#shorter command to open with emacs
alias e='emacs -nw'
alias eg='emacs &'

# alias emacs='torify emacs'

PATH="$PATH:$(readlink -f .)/bin/"

