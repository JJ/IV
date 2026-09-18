#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<EOF
Usage: $0 [-o owner] [-p permission] repo user [user...]
  -o owner       GitHub owner (default: JJ)
  -p permission  permission: admin|maintain|write|triage|read (default: maintain)
EOF
  exit 2
}

owner=JJ
permission=write

while getopts ":o:p:" opt; do
  case $opt in
    o) owner=$OPTARG ;;
    p) permission=$OPTARG ;;
    *) usage ;;
  esac
done
shift $((OPTIND-1))

if [ $# -lt 2 ]; then
  usage
fi

repo="$1"
shift
users=( "$@" )

if ! command -v gh >/dev/null 2>&1; then
  echo "gh CLI not found. Install from https://cli.github.com/"
  exit 1
fi

if ! gh auth status >/dev/null 2>&1; then
  echo "gh not authenticated. Run: gh auth login"
  exit 1
fi

for u in "${users[@]}"; do
  printf "Adding %s to %s/%s with permission=%s... " "$u" "$owner" "$repo" "$permission"
  if gh api -X PUT "/repos/${owner}/${repo}/collaborators/${u}" -f permission="$permission" >/dev/null 2>&1; then
    echo "OK (invited/added)"
  else
    echo "FAILED"
  fi
done
