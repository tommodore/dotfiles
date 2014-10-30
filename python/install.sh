#!/usr/bin/env bash

if test ! $(which easy_install)
then
  echo "  Installing easy_install for you."
  if [ $(uname -s) = 'Darwin' ]
    then
    brew install easy_install > /tmp/easy_install.log
    else
    sudo apt-get install easy_install > /tmp/easy_install.log
  fi
fi

easy_install SpoofMAC
