#!/bin/bash
# @file beetbox.sh
#
# This script faciliates interactions with beetbox vagrant box, a collabrative product of Melbourne Drupal Community.
#
# @usage
#   beetbox [{vagrant_command}]		Detects a ready beetbox context and runs the `vagrant {vagrant_command}`
#
# @example
#     $ beetbox up
#

script_root=$(pwd)
function is_beetbox_root() {
	echo [ -d "$1/.beetbox" ]
}
beetbox_root=""
while [ ! "$(pwd)" = "/" ]
	do
	$(is_beetbox_root $(pwd)) && beetbox_root=$(pwd) && break || cd ..
done

[ ! "$beetbox_root" ] && echo "No beetbox root found on the current path "$script_root && exit

beetbox_config=$beetbox_root"/.beetbox/config.yml"

[ ! -e "$beetbox_config" ] && echo "Config file is missing at "$beetbox_config && exit

echo "Beetbox found at "$beetbox_root

vagrant_command=$([ "$1" ] && echo $1 || echo "status")
VAGRANT_CWD=$beetbox_root vagrant $vagrant_command

