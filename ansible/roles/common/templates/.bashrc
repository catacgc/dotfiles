if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

if [ -f ~/.bashrc.local ]; then
  . ~/.bashrc.local
fi

. {{ basedir }}/env/bin/activate
