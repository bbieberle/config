# X11 Forwarding
if set WSL_DISTRO_NAME; then
    export  LIBGL_ALWAYS_INDIRECT="1"
    if [ -n "$WSL_INTEROP" ]; then
      export DISPLAY=$(route.exe print | grep 0.0.0.0 | head -1 | awk '{print $4}'):0.0
      # export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0.0
    else
      export DISPLAY=":0.0"
    fi
fi

# Automatically start a docker daemon process in the background if not already running.
#
# IMPORTANT
# You'll need to modify the sudoers file (/etc/sudoers) file and add the line 
# >>USERNAME<< ALL=(ALL) NOPASSWD: /usr/bin/dockerd
# This will disable sudo password prompt. 
RUNNING=`ps aux | grep dockerd | grep -v grep`
if [ -z "$RUNNING" ]; then
    sudo dockerd > /dev/null 2>&1 &
    disown
fi
