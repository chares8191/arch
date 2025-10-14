#!/bin/zsh

# ZLOGOUT

# System Logging :: Sets Shutdown Context
system_logger_set_context "SHUTDOWN_LOGIN_SHELL" ".zlogout"
# System Logging :: Logs ZLOGOUT Start
system_logger_entry "ZLOGOUT:START" ".zlogout"
# System Logging :: Logs ZLOGOUT Finish
system_logger_entry "ZLOGOUT:FINISH" ".zlogout"
