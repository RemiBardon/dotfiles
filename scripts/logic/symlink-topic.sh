#!/usr/bin/env bash
#
# Some functions shared by `move-in` and `bootstrap`.

set -e

source "$(dirname "$0")"/util.sh

link_() {
	local src="$1" dst="$2"

	local overwrite backup skip
	local action

	if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]; then
		if ! [[ (( $overwrite_all )) || (( $backup_all )) || (( $skip_all )) ]]; then
			if [ "$(readlink $dst)" == "$src" ]; then
				skip=1;
			else
				question "File already exists: $(format_url $dst) ($(format_url $(basename "$src"))), what do you want to do?\n${NEWLINE_MARGIN}[s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
				printf "${NEWLINE_MARGIN}${BCyan}Answer: "
				read -n 1 -r action
				printf "${Color_Off}\n"

				case "$action" in
					o) overwrite=1 ;;
					O) overwrite_all=1 ;;
					b) backup=1 ;;
					B) backup_all=1 ;;
					s) skip=1 ;;
					S) skip_all=1 ;;
					*) warn "Unknown action ('$action'), skipping…"; skip=1 ;;
				esac
			fi
		fi

		overwrite=${overwrite:-$overwrite_all}
		backup=${backup:-$backup_all}
		skip=${skip:-$skip_all}

		if (( $overwrite )); then
			question "Are you REALLY sure you want to delete $(format_url $dst)? This might delete your \`\$HOME\` if it's what you wrote!"
			if if_yes "n" edo rm -rf "$dst"; then
				info $(format_secondary "Deleted $(format_url $dst).")
			else
				info 'Guess we prevented something bad 😮‍💨'
			fi
		fi

		if (( $backup )); then
			edo mv "$dst" "${dst}.backup"
			info $(format_secondary "Backed up $(format_url $dst) to $(format_url "${dst}.backup").")
		fi

		if (( $skip )); then
			trace $(format_secondary "Skipped $(format_url $src).")
			return 0
		fi
	fi

	edo ln -s "$src" "$dst"
	info $(format_secondary "Linked $(format_url $src) to $(format_url $dst).")
}

symlink_topic() {
	local topic=${1:?}
	trace "Symlinking topic $(format_url $topic)…"
	local topic_dir="${topic}"

	local src dst dst_file manual_dst

	# NOTE: We use a mapfile here because we need to read user input in the loop and
	#   if we used `find … | while read …` we'd receive the result of `find` as "user input".
	#   Also we can't use `find -exec` because we can't pass the code block.
	mapfile -d '' files < <(find -H "$topic_dir" -name '*.symlink' -print0)
	for src in "${files[@]}"; do
		dst="$HOME/.$(basename "${src%.*}")"

		try_dst_file() {
			dst_file="${1:?}"
			trace "Looking fo symlink destination file at $(format_url "$dst_file")…"

			# Abort if file doesn't exist
			[ -f "$dst_file" ] || return 1

			manual_dst="$(cat "$dst_file")"
			if [ -z "$manual_dst" ]; then
				warn "Destination file $(format_url "$dst_file") is empty, will use $(format_url "$dst") as fallback"
				manual_dst="$dst"
			else
				manual_dst=$(eval "echo $manual_dst")
			fi
		}

		if try_dst_file "$src.destination"; then
			# `manual_dst` is a file
			dst="$manual_dst"
			trace "Read destination $(format_url "$dst") from $(format_url "$dst_file")"
		elif try_dst_file "$(dirname "$src")/symlinks.destination"; then
			# `manual_dst` is a directory
			dst="$manual_dst/$(basename "${src%.*}")"
			trace "Read destination $(format_url "$dst") from $(format_url "$dst_file")"
		fi

		link_ "$src" "$dst"
	done

	trace "Successfully symlinked topic $(format_url $topic_dir)."
}
