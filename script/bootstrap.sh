#!/bin/sh

# stops the execution of a script if a command or pipeline has an error
set -e

# Profiling - Most simply, run the script in verbose mode (in bash, use the -x flag or set -x at the top of the script) and see where execution visibly hangs – this is a very quick way to identify bottlenecks.
# set -x 

cd "$(dirname "$0")/.."
# Prints the actual path (as opposed to symbolic)
DOTFILES_ROOT=$(pwd -P)

# Ask for the administrator password upfront
# sudo -v

# Keep-alive: update existing 'sudo' time stamp until '.osx' has finished
# while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo ''

info() {
	# shellcheck disable=SC2059
	printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

user() {
	# shellcheck disable=SC2059
	printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

success() {
	# shellcheck disable=SC2059
	printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail() {
	# shellcheck disable=SC2059
	printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
	echo ''
	exit
}


if xcode-select -p 1>&2 /dev/null; then
  success "Xcode found"
else
  fail "Xcode not found"
fi
