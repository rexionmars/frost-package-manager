#!/usr/bin/env sh 

#    ______ _____   ____   _____ _______ _____ _   _  _____ _______       _      _      
#   |  ____|  __ \ / __ \ / ____|__   __|_   _| \ | |/ ____|__   __|/\   | |    | |     
#   | |__  | |__) | |  | | (___    | |    | | |  \| | (___    | |  /  \  | |    | |     
#   |  __| |  _  /| |  | |\___ \   | |    | | | . ` |\___ \   | | / /\ \ | |    | |     
#   | |    | | \ \| |__| |____) |  | |   _| |_| |\  |____) |  | |/ ____ \| |____| |____ 
#   |_|    |_|  \_\\____/|_____/   |_|  |_____|_| \_|_____/   |_/_/    \_\______|______|
#

### Config Package Tracker
TRACK='/var/log/frost'

### Creating the tracker directory
[ ! -d "$TRACK" ] && mkdir -v "$TRACK"

# Function for install package
INSTALL()
{
  # Get user package name
  local package="$1"

  printf '%b' "initialize package instalation: $package\n"

  tar xvf "$package" -C /ssf/virtual

  return 0
}

### User check params
case $1 in
  -i|--install)
      shift
      if [ -e "$1" ]; then
        INSTALL $1 # Call install function
      else
        echo "Package $1 is not exitent"
        exit 1
      fi
    ;;
esac
