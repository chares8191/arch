#!/usr/bin/zsh

# CHARES_MINECRAFT (zsh)
unset __resource __filename
typeset __resource="CHARES_MINECRAFT"
typeset __filename="chares-minecraft.zsh"

__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia prime-run minecraft-launcher
