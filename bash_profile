# This initialisation script will be invoked when bash is run
# as login shell and should contain settings that apply to the whole
# login session.

[ ! -r ~/.profile ] || . ~/.profile

case "$-" in *i*) [ ! -r ~/.bashrc ] || . ~/.bashrc ;; esac
