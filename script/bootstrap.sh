#!/bin/sh

# stops the execution of a script if a command or pipeline has an error
set -e

# Profiling - Most simply, run the script in verbose mode (in bash, use the -x flag or set -x at the top of the script) and see where execution visibly hangs – this is a very quick way to identify bottlenecks.
# set -x 

cd "$(dirname "$0")/.."
# Prints the actual path (as opposed to symbolic)
DOTFILES_ROOT=$(pwd -P)

# Ask for the administrator password upfront
sudo -v

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

command_exists() {
  command -v "$@" >/dev/null 2>&1
}

# if xcode-select -p &> /dev/null; then

install_cli_tools() {
	info "Checking for Xcode CLI tools..."

	if [ ! "$(xcode-select -p)" ]; then
		info "Installing Xcode"
		xcode-select --install
		until [ "$(xcode-select -p)" ];
		do
			info "Sleeping..."
			sleep 5
		done
		success "Installed Xcode"
	else
		success "Xcode found"
	fi
}

install_homebrew() {
	info "Checking for Homebrew..."

	if ! command_exists brew; then
		info "Installing Homebrew..."
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
		brew update
		brew upgrade
		success "Homebrew was installed"
	else
		success "You already have Homebrew installed. Skipping..."
	fi
}

install_brew() {
	info "Installing brew packages..."

	

}

main() {
	install_cli_tools "$@"
	install_homebrew "$@"
}

main "$@"
