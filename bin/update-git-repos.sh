#!/bin/sh

for repo in ~/git/*; do
  cd "${repo}"
  git fetch --all >/dev/null 2>&1
done
