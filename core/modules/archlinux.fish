#!/usr/bin/fish

# if archlinux
if ! _equal $DISTRO "arch"
  exit 0
end

alias pacclean='sudo pacman -Scc'
alias pacupgrade='sudo pacman -Syyu'
alias pacman='sudo pacman'
alias pacautoremove='pacman -Rs $(pacman -Qdtq)'
