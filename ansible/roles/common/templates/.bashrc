if [ -f /etc/bashrc ]; then                                                              │[ccostache@use-stagingpcs-3 ~]$ git glog^C
  . /etc/bashrc                                                                        │[ccostache@use-stagingpcs-3 ~]$ Write failed: Broken pipe
fi

if [ -f ~/.bashrc.local ]; then
  . ~/.bashrc.local
fi

. {{ basedir }}/env/bin/activate
