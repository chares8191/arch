#!/bin/sh

SYSTEM_SHELL_LOG_FILE="${SYSTEM_SHELL_LOG_FILE:-$HOME/.shell.log}"
export SYSTEM_SHELL_LOG_FILE

if [ -z "${SYSTEM_SHELL_TRACE_CHAIN_ID:-}" ]; then
	SYSTEM_SHELL_TRACE_CHAIN_ID="$(date '+%Y%m%dT%H%M%S%z')"
	export SYSTEM_SHELL_TRACE_CHAIN_ID
fi

if [ -z "${SYSTEM_LOGGER_CONTEXT:-}" ]; then
	SYSTEM_LOGGER_CONTEXT="OTHER_SHELL"
	export SYSTEM_LOGGER_CONTEXT
fi

system_logger_entry() {
	__st_event="${1:-}"
	if [ -z "$__st_event" ]; then
		return 1
	fi

	if [ -n "${2:-}" ]; then
		__st_origin="$2"
	else
		__st_origin="$0"
	fi

	if [ -n "${3:-}" ]; then
		__st_pid="$3"
	else
		__st_pid="$$"
	fi

	if [ -n "${4:-}" ]; then
		__st_ppid="$4"
	else
		__st_ppid="$PPID"
	fi

	__st_timestamp="$(date '+%Y-%m-%dT%H:%M:%S%z')"
	__st_chain="${SYSTEM_SHELL_TRACE_CHAIN_ID:-unknown}"
	__st_session="${SYSTEM_SHELL_TRACE_SESSION_ID:-unknown}"
	__st_parent="${SYSTEM_SHELL_TRACE_PARENT_SESSION:-}"
	__st_context="${SYSTEM_LOGGER_CONTEXT:-unknown}"

	if [ -z "$__st_parent" ]; then
		__st_parent="-"
	fi

	{
		printf '\n%s chain=%s session=%s parent=%s ctx=%s %s %s pid=%s ppid=%s\n' \
			"$__st_timestamp" "$__st_chain" "$__st_session" "$__st_parent" "$__st_context" \
			"$__st_event" "$__st_origin" "$__st_pid" "$__st_ppid"
		printf 'PATH=%s\n' "$PATH"
	} >> "$SYSTEM_SHELL_LOG_FILE"

	unset __st_event __st_origin __st_pid __st_ppid __st_timestamp __st_chain \
		__st_session __st_parent __st_context
}

system_logger_set_context() {
	__st_new_context="${1:-}"
	if [ -z "$__st_new_context" ]; then
		return 1
	fi

	if [ "${SYSTEM_LOGGER_CONTEXT:-}" = "$__st_new_context" ]; then
		return 0
	fi

	if [ -n "${2:-}" ]; then
		__st_origin="$2"
	else
		__st_origin="startup.zsh"
	fi

	SYSTEM_LOGGER_CONTEXT="$__st_new_context"
	export SYSTEM_LOGGER_CONTEXT
	system_logger_entry "CONTEXT:$__st_new_context" "$__st_origin"

	unset __st_new_context __st_origin
}

__st_inherited_session="${SYSTEM_SHELL_TRACE_SESSION_ID:-}"
__st_inherited_pid="${SYSTEM_SHELL_TRACE_SESSION_PID:-}"

if [ -z "$__st_inherited_session" ] || [ "$__st_inherited_pid" != "$$" ]; then
	if [ -n "$__st_inherited_session" ]; then
		SYSTEM_SHELL_TRACE_PARENT_SESSION="$__st_inherited_session"
	else
		SYSTEM_SHELL_TRACE_PARENT_SESSION=""
	fi

	SYSTEM_SHELL_TRACE_SESSION_ID="${SYSTEM_SHELL_TRACE_CHAIN_ID}.$$"
	SYSTEM_SHELL_TRACE_SESSION_PID="$$"
	export SYSTEM_SHELL_TRACE_SESSION_ID SYSTEM_SHELL_TRACE_SESSION_PID SYSTEM_SHELL_TRACE_PARENT_SESSION
	system_logger_entry "LOGGER_SESSION_START" "system-logger.zsh" "$$" "$PPID"
fi

unset __st_inherited_session __st_inherited_pid
