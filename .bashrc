# welcome to my .bashrc, nothing much interesting and most of it is pilfered from
# looking at others .bashrc and running google-copy-paste cycles.



# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples



# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac


# "in my .bashrc allows me to start typing a command (like "vim ") 
# and then use my up and down arrows to search through my history 
# (think ctrl-r) " - http://www.reddit.com/r/linuxadmin/comments/1x0ql2/whats_a_linux_command_you_wish_you_had_known/cf7tbne
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# open emacs to org agenda list from command line
alias org='emacs -nw -f org-agenda-list'
# TODO modify org command so it dumps to agenda to stdout 


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

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

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


export PERL_LOCAL_LIB_ROOT="/home/malaparte/perl5";
export PERL_MB_OPT="--install_base /home/malaparte/perl5";
export PERL_MM_OPT="INSTALL_BASE=/home/malaparte/perl5";
export PERL5LIB="/home/malaparte/perl5/lib/perl5/x86_64-linux-gnu-thread-multi:/home/malaparte/perl5/lib/perl5";
export PATH="/home/malaparte/perl5/bin:$PATH";



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

# possible idea for torifying emacs
# alias emacs='torify emacs'


PATH="$PATH:$(readlink -f .)/bin/"
