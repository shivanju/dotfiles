#
# ~/.bash_profile
#

#-----------------------------#
#      Path Modifications     #
#-----------------------------#
export ANDROID_HOME=~/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:/home/shivanju/.gem/ruby/2.7.0/bin
export PATH="$HOME/.cargo/bin:$PATH"

# FZF defaults
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

# Use neovim to browse man pages
export MANPAGER='nvim +Man!'

# Source bashrc
[[ -f ~/.bashrc ]] && . ~/.bashrc

export NEOVIDE_MULTIGRID='set'
#-----------------------------#
#      Graphical Session      #
#-----------------------------#
# Start X session if launching from tty2
if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 2 ]]; then
    exec startx -- -dpi 120
fi

# Start Wayland sesion if launching from tty1
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    ## For GTK
    ## can't set this atm since setting this globaly will break electron (chromium)
    ## Either app should be run on wayland default or they should be started with
    ## individual environment export
    ## export GDK_BACKEND=wayland

    ## For Qt
    export QT_QPA_PLATFORM=wayland
    export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"

    ## For Firefox
    export MOZ_ENABLE_WAYLAND=1

    ## Launch Sway
    XKB_DEFAULT_LAYOUT=us exec sway 2>&1 | tee -a ~/.sway.log
fi



# Added by Toolbox App
export PATH="$PATH:/home/shivanju/.local/share/JetBrains/Toolbox/scripts"

