#!/usr/bin/zsh

# CHARES_OPENMW (zsh)
unset __resource __filename
typeset __resource="CHARES_OPENMW"
typeset __filename="chares-openmw.zsh"

__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia prime-run openmw
