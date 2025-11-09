#!/usr/bin/zsh

# CHARES_MINECRAFT (zsh)
unset __resource __filename
typeset __resource="CHARES_MINECRAFT"
typeset __filename="chares-minecraft.zsh"
__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia prime-run portablemc start -l megavoidwalrus@protonmail.ch --jvm "$JVM_PATH" --jvm-args="-Xmx8G -Xms8G -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:G1NewSizePercent=20 -XX:G1ReservePercent=20 -XX:MaxGCPauseMillis=50 -XX:G1HeapRegionSize=32M"
