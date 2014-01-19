RC = .bash_profile:bash_profile \
     .bashrc:bashrc             \
     .dircolorsrc:dircolorsrc   \
     .profile:profile           \
     .vimrc:vimrc               \
     .emacs:emacs               \
     .xsessionrc:xsessionrc     \
     .gitconfig:gitconfig       \
     .remote-terminal-config:remote-terminal-config

all:
install:
	DIR="$${PWD#$$HOME/}" ; \
	for RC in $(RC) ; do \
	    SRC="$${RC%%:*}" ; \
	    DST="$${RC##*:}" ; \
	    ln -sf "$$DIR/$$DST" "$$HOME/$$SRC" ; \
	done
