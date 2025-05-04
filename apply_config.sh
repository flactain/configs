#!/bin/bash
set -euxo pipefail

###
# init
###
# 現在時刻を格納する
now=$(date '+%Y%m%d%H%M')
# スクリプトが格納されているディレクトリに移動しておく
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd $script_dir

EXCLUDE_DIRS=(".git")
EXCLUDE_FILES=("README.md" "apply_config.sh")


###
# 種処理
###
EXCLUDE_OPTIONS=""

for dir in "${EXCLUDE_DIRS[@]}"; do
  EXCLUDE_OPTIONS+="-path '*/$dir/*' -prune -o "
done

for pattern in "${EXCLUDE_FILES[@]}"; do
  EXCLUDE_OPTIONS+="-name '$pattern' -prune -o "
done

files=()
to_files=()
while IFS= read -r -d $'\0' file; do
  files+=("$file")
  to_files+=("${file:1}")
done < <(eval "find . $EXCLUDE_OPTIONS -type f -print0")

for i in ${!files[@]} ; do
  eval "cp "${files[i]}" ~"${to_files[i]}""
done
###
# cp files
###
#function cp_file(){
#  TARGET_FILE=$1
#  OUT_FILE=$2
#  cp -fb TARGET_FILE OUT_FILE
#}
#
###
# get backup
###
#function make_bk(){
#  IN_FILE=$1
#  BK_FILE="$IN_FILE"_$now
#
#  cp $IN_FILE $BK_FILE
#
#  #cpコマンドがうまく行ったかどうか判定
#  #0より大きい場合は失敗
#  if [$? -gt 0]; then
#    return 1
#  #0の場合成功
#  else
#    echo "make bk $BK_FILE"
#    return 0
#  fi
#}


# shushori
#cp ./.gitconfig ~/.gitconfig
#cp ./.config/lvim/config.lua ~/.config/lvim/config.lua
#cp ./.bashrc ~/.bashrc
#cp ./.config/tabby/config.yaml ~/.config/tabby/config.yaml
#cp ./.ssh/config ~/.ssh/config
