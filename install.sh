#!/bin/zsh

HASH_BEFORE_PULL=$(git rev-parse HEAD)
git pull > /dev/null
HASH_AFTER_PULL=$(git rev-parse HEAD)

if [[ "$HASH_BEFORE_PULL" -ne "$HASH_AFTER_PULL" ]]; then
  cp ./config.kdl ~/.config/zellij/config.kdl
  cp ./layouts/* ~/.config/zellij/layouts/
  echo "installed latest version of zellij config"
fi
