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
