#!/usr/bin/env bash

########################################
# Author: Leonardi Melo                #
# Email: opensource.leonardi@gmail.com #
# Github: rexionmars                   #
########################################

# COLORS
RED=$'\e[0;31m'
GRN=$'\e[0;32m'
YLW=$'\e[0;33m'
BLU=$'\e[0;34m'
MAG=$'\e[0;35m'
CYN=$'\e[0;36m'
END=$'\e[0m'

# Custom log messages
ERROR="${RED}[ERROR]${END}"
INFO="${GRN}[INFO]${END}"
WARNING="${YLW}[WARNING]${END}"
NOTICE="${MAG}[NOTICE]${END}"

export pkg_extension=".ice"
export version="0.1.7"

# Remove unicode support for more performance
export LC_ALL=C
export LANG=C

### Check package information
CHECK_PKG() {
  pkg_name="$@"

  # Check package extension name
  if ! echo "$pkg_name" | grep "\b${pkg_extension}\b$"; then
    printf '%s\n' "${ERROR} The package format must be ${pkg_extension}"
    return 1
  fi

  # Check if contains white spaces
  if echo "$pkg_name" | grep -qE "[[:space:]]+"; then
    printf '%s\n' "${ERROR} Do not use spaces in the name."
    printf '%s\n' "${YLW}Exiting...${END}"
    return 1
  fi

  printf '%s\n' "${INFO} Using package name: ${pkg_name}"
  check_name=$(echo "${pkg_name}" | grep -o "-" | wc -l)

  # Check if package name is valid
  if [ "$check_name" -lt '2' ] || [ "$check_name" -gt '2' ]; then
    printf '%s\n' "${ERROR} The package name is invalid"
    printf '%s\n' "${NOTICE} Example: package_name-x.x.x-x${pkg_extension}"
    return 1
  fi
  return 0
}

### CREATE PACKAGE 
CREATE_PKG() {
  pkg_name="$1"

  if [ "$VERBOSE" = 1 ]; then
    if tar -cvf../${pkg_name} .; then
      printf '%b' "${INFO} The package has been created on ../${pkg_name}\n"
    else
      printf "${ERROR} The package was not created\n"
      exit 1
    fi
  else
    if tar -cf ../${pkg_name} .; then
      printf '%b' "${INFO} The package has been created on ../${pkg_name}\n"
      return 0
    else
      printf "${ERROR} The package was not created\n"
      exit 1
    fi
  fi
}

### USAGE MODE
USAGE() {
  cat << EOF
    ${BLU}FROST PACKAGE MANAGER${END} ${RED}v${version}${END}

    ${YLW}--create, -c${END}
        Create a package with .frost. It needs to be in the main directory of the package.
        The package will be created a directory above.

    ${YLW}--help, -h${END}
        Instructions for use.
  
    ${YLW}--verbose, -v${END}
        Verbose mode.

    Author: Leonardi Melo 
    Email: opensource.leonardi@gmail.com 
EOF
}

### If the package manager is run without parameters, it returns the help menu.
if [ -z "$1" ]; then
  USAGE
fi

### Parser
while [ -n "$1" ]; do
  case "$1" in
    --create|-c)
      CMD=$1
      shift
    ;;

    --verbose|-v)
      VERBOSE=1
      shift
    ;;

    *.ice)
      PKG=$1
      shift
    ;;

    --help|-h)
      USAGE # Call usage mode
      exit 1
    ;;

    *)
      USAGE
      exit 1
    ;;
  esac
done

### START
case "$CMD" in
    --create|-c)
    if [ -z "$CMD" ]; then
      printf '%b' "${ERROR} The package name is required.\n"
      exit 1
    fi
    CHECK_PKG "$PKG" || exit 1
    CREATE_PKG "$PKG"
esac
