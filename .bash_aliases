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
# Search pip way more easily
alias pips="pip search"

# Emacs org aliases
#
#  TODO: aliases for quickly getting things from org-files to std-out
#
# open emacs to org agenda list from command line
alias org='emacs -nw -f org-agenda-list'
# TODO: modify org command so it dumps to agenda to stdout 


