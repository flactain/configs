#!/bin/bash
# copy files to your configuration place
# apply the hierarchy of this project to your directory
set -euo pipefail

# write exclude dir or files
EXCLUDE_DIRS=(".git")
EXCLUDE_FILES=("README.md" "apply_config.sh")
EXCLUDE_OPTIONS=""

arg=${1:-}
while [ -z "${arg}" ]; do
  echo "Please type arguments of launch mode (apply/get)"
  read arg
done

if [ "${arg}" = "apply" ]; then
  echo "Apply config files of this project to your directory."
elif [ "${arg}" = "get" ]; then
  echo "Get config files from your directory."
else
  echo "Wrong arguments."
  exit 1
fi

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd $script_dir

for dir in "${EXCLUDE_DIRS[@]}"; do
  EXCLUDE_OPTIONS+="-path '*/$dir/*' -prune -o "
done
for pattern in "${EXCLUDE_FILES[@]}"; do
  EXCLUDE_OPTIONS+="-name '$pattern' -prune -o "
done

###
# main
###
files=()
to_files=()
while IFS= read -r -d $'\0' file; do
  files+=("$file")
  to_files+=("${file:1}")
done < <(eval "find . $EXCLUDE_OPTIONS -type f -print0")

for i in ${!files[@]}; do
  if [ "${arg}" = "apply" ]; then
    eval "cp -fb -S.backup "${files[i]}" ~"${to_files[i]}""
  elif [ "${arg}" = "get" ]; then
    eval "cp -f ~"${to_files[i]}" "${files[i]}""
  else
    echo "something go wrong."
  fi
done

echo "end succesfully."
