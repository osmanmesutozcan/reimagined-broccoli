#!/usr/bin/env bash
set -euo pipefail

TITLE_LIMIT=50
DESCRIPTION_WIDTH=72

usage() {
    echo "Usage: $0 <title> <description>" >&2
}

if [[ $# -ne 2 ]]; then
    usage
    exit 64
fi

title=$1
description=$2
title_length=${#title}

if [[ -z ${title//[[:space:]]/} ]]; then
    echo "error: title cannot be empty" >&2
    exit 64
fi

if [[ $title == *$'\n'* || $title == *$'\r'* ]]; then
    echo "error: title must be a single line" >&2
    exit 64
fi

if ((title_length > TITLE_LIMIT)); then
    echo "error: title is ${title_length} characters; limit is ${TITLE_LIMIT}" >&2
    exit 64
fi

if [[ -z ${description//[[:space:]]/} ]]; then
    echo "error: description cannot be empty" >&2
    exit 64
fi

if git diff --cached --quiet --exit-code; then
    echo "error: no staged changes to commit" >&2
    exit 1
fi

message_file=$(mktemp)
trap 'rm -f "$message_file"' EXIT

{
    printf '%s\n\n' "$title"
    printf '%s\n' "$description" | fold -s -w "$DESCRIPTION_WIDTH" | fold -w "$DESCRIPTION_WIDTH" | sed 's/[[:space:]]*$//'
} > "$message_file"

git commit --file "$message_file"
