#
# ~/.bash_profile
#

#-----------------------------#
#      Path Modifications     #
#-----------------------------#

# FZF defaults
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

# Use neovim to browse man pages
export MANPAGER='nvim +Man!'

# Source bashrc
[[ -f ~/.bashrc ]] && . ~/.bashrc

#-----------------------------#
#      Graphical Session      #
#-----------------------------#
# Start Hyprland if launching from tty2
if [[ $(tty) = /dev/tty2 ]]; then
    ## Launch Hyprland
    exec Hyprland 2>&1 | tee -a ~/.Hyprland.log
fi

# Start Sway if launching from tty1
if [[ $(tty) = /dev/tty1 ]]; then
    export QT_QPA_PLATFORM=wayland-egl
    export QT_WAYLAND_DISABLE_WINDOWDECORATION='1'
    export QT_QPA_PLATFORMTHEME='qt6ct'
    export GTK_THEME='Adwaita:dark'

    ## Launch Sway
    XKB_DEFAULT_LAYOUT=us exec sway 2>&1 | tee -a ~/.sway.log
fi
