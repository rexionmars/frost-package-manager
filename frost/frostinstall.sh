#!/usr/bin/env sh 

########################################
# Author: Leonardi Melo                #
# Email: opensource.leonardi@gmail.com #
# Github: rexionmars                   #
########################################

# Package Tracker location folder
TRACK='/var/log/frost'

# Creating the tracker directory
[ ! -d "$TRACK" ] && mkdir -v "$TRACK"

# Function for install package
INSTALL()
{
  local package="$1"

  printf '%b' "initialize package instalation: $package\n"
  tar xvf "$package" -C /ssf/virtual
  return 0
}

# User check params
case $1 in
  --install|-i)
      shift
      if [ -e "$1" ]; then
        INSTALL $1
      else
        echo "Package $1 is not exitent"
        exit 1
      fi
    ;;
esac
