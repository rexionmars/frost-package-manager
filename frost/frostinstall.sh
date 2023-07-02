#!/usr/bin/env sh 

########################################
# Author: Leonardi Melo                #
# Email: opensource.leonardi@gmail.com #
# Github: rexionmars                   #
########################################

# Package Tracker location folder
TRACK='/var/log/ices'

# Creating the tracker directory if not exists
[ ! -d "$TRACK" ] && mkdir -v "$TRACK"

# Function for install package
INSTALL()
{
  local package="$1"
  package_name=$(basename $package)     # get only package name
  package_name="${package_name//.ice/}" # drop exetension
  echo "$package_name"

  # Unpack the package in system
  printf '%b' "initialize package instalation: $package\n"
  if tar xvf "$package" -C / >> "${TRACK}/${name_package.track}"; then
    echo "The package ${packa_name} as bieen installed"
  else
    echo "The package ${package_name} not installed"
    exit 1
  fi

  # Remove ./ and blank lines
  if sed -i 's,\.\/,,g; /^$/d' "${TRACK}/${package_name}.track"; then
    echo "[INFO] Cleaning is runnig"
  else
    echo "[ERROR] Fail in the run CLEAN mode"
    exit 1
  fi
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
