# This initialisation script will be invoked when bash runs as an
# interactive shell (but not a login shell nor a script shell).

[ ! -r ~/.xsessionrc ] || . ~/.xsessionrc

# 256 colour support
#
# http://askubuntu.com/questions/233280/gnome-terminal-reports-term-to-be-xterm
#
[ x"$TERM" != x"xterm" ] || TERM=xterm-256color

# Directory aliases
#
alias ll='ls --color=auto -FCl '
alias ls='ls --color=auto -FC '

# Configure the PS1 prompt and constrain it to something reasonable
#
PS1='${debian_chroot:+($debian_chroot)}'
PS1="$PS1\[$(tput bold | sed -e 's/\o033/\\033/g')\]"
PS1="$PS1\u@\h"
PS1="$PS1\[$(tput sgr0 | sed -e 's/\o033/\\033/g')\] "
PS1="$PS1\w\$ "
PROMPT_DIRTRIM=2
