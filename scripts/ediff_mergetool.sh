#!/bin/bash

###########################################################################
# Pilfered from								  #
# http://stackoverflow.com/questions/1817370/using-ediff-as-git-mergetool #
# Credit completely to the author 'u-punkt' there.			  #
###########################################################################

# Add the following to your ~/.gitconfig

##########################################################################
# [merge]								 #
#         tool = ediff							 #
# 									 #
# [mergetool "ediff"]							 #
#         cmd = /path/to/ediff-merge-script $LOCAL $REMOTE $MERGED $BASE #
#         trustExitCode = true						 #
##########################################################################

# test args
if [ ! ${#} -ge 3 ]; then
    echo 1>&2 "Usage: ${0} LOCAL REMOTE MERGED BASE"
    echo 1>&2 "       (LOCAL, REMOTE, MERGED, BASE can be provided by \`git mergetool'.)"
    exit 1
fi

# tools
_EMACSCLIENT=/usr/local/bin/emacsclient
_BASENAME=/bin/basename
_CP=/bin/cp
_EGREP=/bin/egrep
_MKTEMP=/bin/mktemp

# args
_LOCAL=${1}
_REMOTE=${2}
_MERGED=${3}
if [ -r ${4} ] ; then
    _BASE=${4}
    _EDIFF=ediff-merge-files-with-ancestor
    _EVAL="${_EDIFF} \"${_LOCAL}\" \"${_REMOTE}\" \"${_BASE}\" nil \"${_MERGED}\""
else
    _EDIFF=ediff-merge-files
    _EVAL="${_EDIFF} \"${_LOCAL}\" \"${_REMOTE}\" nil \"${_MERGED}\""
fi

# console vs. X
if [ "${TERM}" = "linux" ]; then
    unset DISPLAY
    _EMACSCLIENTOPTS="-t"
else
    _EMACSCLIENTOPTS="-c"
fi

# run emacsclient
${_EMACSCLIENT} ${_EMACSCLIENTOPTS} -a "" -e "(${_EVAL})" 2>&1

# check modified file
if [ ! $(egrep -c '^(<<<<<<<|=======|>>>>>>>|####### Ancestor)' ${_MERGED}) = 0 ]; then
    _MERGEDSAVE=$(${_MKTEMP} --tmpdir `${_BASENAME} ${_MERGED}`.XXXXXXXXXX)
    ${_CP} ${_MERGED} ${_MERGEDSAVE}
    echo 1>&2 "Oops! Conflict markers detected in $_MERGED."
    echo 1>&2 "Saved your changes to ${_MERGEDSAVE}"
    echo 1>&2 "Exiting with code 1."
    exit 1
fi

exit 0
