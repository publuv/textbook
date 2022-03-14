#!/usr/bin/env bash

IFS=$'\n'
cwd=$(pwd)
dir='src/'

listPages(){
  readarray -d '' pages < <(find $1 -type f -name '*.md' | sort -n)
  local bFirstPage=1
  local level=0
  for path in ${pages[@]}
  do
    read -r firstline<$path
    title=$(grep -oP -e '(?<=(^#)\s)(.*)|((\S*?)\n={3,})' $path)
    tocPath=$(echo $path | sed -e "s;$dir;;;s;\s;%20;g")
    indent=$(echo $tocPath | grep -o "/" | wc -l)
    if [ $level -ne $indent ]; then
      level=$indent
      bFirstPage=1
    else
      bFirstPage=0
    fi

    if [ $bFirstPage -eq 1 ]; then
      indent=$(($indent-1))
      indent=$(($indent<0 ? 0 : $indent))
    fi
    indentFormat=$(for (( i = 1; i < $indent; ++i )); do echo -n "  "; done; echo '- ')
    printf '%s[%s](%s)\n' $indentFormat $title $tocPath
  done
}

getSections(){
  readarray sections < <(find $1 -maxdepth 1 -type d -print0 | xargs -0 ls -d)
  for s in ${sections[@]:1} #drop the first element in array
  do
    title=$(echo $s | sed -e "s;$dir;;g")
    printf '# %s\n\n' $title
    listPages $s
    printf '\n'
  done
}

# Prefix pages
readarray intro < <(find $dir -maxdepth 1 -type d -print0 | xargs -0 ls -d)
printf '# Table of Contents Summary %s\n\n' ${intro[0]}
readarray -d '' prepages < <(find $dir -maxdepth 1 -type f -name '*.md' | sort -n)
for path in ${prepages[@]}
do
  if [[ $path == *'SUMMARY'* ]]; then
    continue
  fi
  read -r firstline<$path
  title=$(echo $firstline | sed -e "s;#\W;;g")
  tocPath=$(echo $path | sed -e "s;$dir;;g")
  printf '[%s](%s)\n' $title $tocPath
done

printf '\n'

getSections $dir
