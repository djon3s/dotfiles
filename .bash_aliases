# convenient alias to tell us how mime interprets the type of a file 
alias typeof='mimedb -t'

# less keystrokes than ps -e | grep <name>
alias fps='ps -e | grep'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
# Will alert via what ever notify is hooked up to in xfce/gnome whatever
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Searching Things
#
#   TODO: there's a set of stuff for which I don't care if command-line
#   program or library for a scripting language
#   do a search over those things
#
# Search apt-cache way more easily
alias acs="apt-cache search"
alias acs-v="apt-cache show" 
# Search pip way more easily
alias pips="pip search"

# Emacs org aliases
#
#  TODO: aliases for quickly getting things from org-files to std-out
#
# open emacs to org agenda list from command line
alias org='emacs -nw -f org-agenda-list'
# TODO: modify org command so it dumps to agenda to stdout 

# PRETTY COLOR aliases
# 
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

#alias man_e 'emacsclient --eval "(woman (shell-quote-argument \"$1\"))"'

# find big files I could delete
alias fbf="du -chs * | sort -h | tail -n 10"
alias find_big_files="du -chs * | sort -h | tail -n 10"

# to stop annoyances of difference between emacs and nano
# using emacs -q over zile because zile less likely to be installed
if which emacs >> /dev/null
   then
	alias nano="emacs -nw -q" #load emacs without X11 and a configuration file
fi
