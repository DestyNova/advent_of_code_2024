#!/usr/bin/env bash

i=100
while true
do
  picat_regex both_parts.pi $i < input
  read -s -n 1 key
  if [ "${key}" == "z" ]; then
    i=$((i - 100))
  elif [ "${key}" == "x" ]; then
    i=$((i - 1))
  elif [ "${key}" == "c" ]; then
    i=$((i + 1))
  elif [ "${key}" == "v" ]; then
    i=$((i + 100))
  fi
done
