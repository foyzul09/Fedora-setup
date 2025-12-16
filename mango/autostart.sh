# Wayland
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots

# Polkit agent
/usr/libexec/polkit-mate-authentication-agent-1


# clipboard 
# /usr/bin/wl-paste --type text --watch cliphist store &

/usr/libexec/xdg-desktop-portal-wlr &
