#!/bin/bash

# assign variables
ACTION=${1}
VERSION="0.5.0"

function show_version() {

echo "Current version of the script is: $VERSION"
}

function create_file() {

curl http://169.254.169.254/latest/dynamic/instance-identity/document/ -o backend1-identity.json
curl -vs https://s3.amazonaws.com/seis665/message.json 2>&1 | tee backend1-message.txt
cp /var/log/nginx/access.log access.log
}

function basic_usage() {

echo "The basic usage of this script is: 
	- To create identity.json,message.txt and copy access.log
	"
}

function display_help() {

cat << EOF
Usage: ${0} {-h|--help}
OPTIONS:
	 No Arguments:  Provide basic usage information.
	-c | --create   Create a new files and copy access log
	-v | --version  Show version of the script
	-h | --help	Display the command help
	
Examples:
	Create a new file:
		$ ${0} -c 
	
	Get basic usage information:
		$ ${0}
	
	Show version of the script:
		$ ${0} -v

	Display help:
		$ ${0} -h
EOF
}

case "$ACTION" in
	-h|--help)
		display_help
		;;
	-c|--create)
		create_file
		;;
	"")
		basic_usage 
		;;
	-v|--version)
		show_version
		;;
	*)
	echo "Usage ${0} {noarguments|-c|-v|-h}"
	exit 1

esac
