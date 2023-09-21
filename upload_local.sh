#!/bin/zsh

# We have updated the local version of our zellij config, so we need to
# - overwrite the one here
# - upload to github
LOGFILE=script_out

echo "\n***** Running upload to github script *****\n" >> $LOGFILE

if [[ -f $HOME/.config/zellij/zellij.kdl ]]; then
  echo "found zellij config file"
else
  echo "could not find zellij config"
  exit 1
fi

if git pull >> $LOGFILE; then
  echo "updated config from github"
else
  echo "failed to update from github"
  exit 2
fi

if cp $HOME/.config/zellij/zellij.kdl ./zellij.kdl >> $LOGFILE; then
  echo "copied in zellij config"
else
  echo "failed to copy in zellij config"
  exit 3
fi

if [[ -v 1 && -n "$1" ]]; then
  COMMIT_MESSAGE=${1}
else 
  COMMIT_MESSAGE="updating zellij config from local"
fi

if git commit -am "$COMMIT_MESSAGE" >> $LOGFILE; then
  echo "commited to git"
else
  echo "failed to commit new version of zellij config"
  exit 4
fi

if git push >> $LOGFILE; then
  echo "pushed to github"
else
  echo "failed to push changes to github"
  exit 5
fi

echo "local zellij config pushed to github"