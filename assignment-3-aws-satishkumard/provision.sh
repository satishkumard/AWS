#!/bin/bash

# Assign variables
ACTION=${1}
VERSION="1.0.0"

function show_version() {

echo "Current version of the script is: $VERSION"
}

function initial_setup() {

sudo yum update -y
sudo yum install nginx -y
sudo chkconfig nginx on
sudo aws s3 cp s3://dand9090-assignment-3/index.html /usr/share/nginx/html/index.html
sudo service nginx start

echo "

-------------------------------------------------------------------------
 Initial setup is complete.
	 -Update all system packages.
	 -Install the Nginx software package.
	 -Configure nginx to automatically start at system boot up.
	 -Copy the website documents to the web document root directory.
	 -Start the Nginx service. 
-------------------------------------------------------------------------	
"
}

function remove_setup() {

sudo service nginx stop
sudo rm /usr/share/nginx/html/*
sudo yum remove nginx -y

echo "

--------------------------------------------------------------------------
 Remove setup is complete
	-Stopped the Nginx service.
	-Deleted the files in the website document root directory.
	-Unistalled the Nginx software package.
---------------------------------------------------------------------------
"

}

function display_help() {

cat << EOF
Usage: ${0} {-h|--help}
OPTIONS:
	No Arguments: Inital setup Update/Install/Configure/Start Services
	-v | --version Show version of the script
	-r | --remove Stop/Delete/Uninstall Services, Files and Packages
	-h | --help Display the command help

Examples:
	Initial setup Update/Install/Configure/Start Services:
		$ {0} 
	
	Show version of the script:
		$ {0} -v

	Remove Stop/Delete/Unistall Services, Files and Packages
		$ {0} -r

	Help display the command help
		$ {0} -h

EOF
}


case "$ACTION" in
	"")
		initial_setup
		;;
	-v|--version)
		show_version
		;;
	-r|--remove)
		remove_setup
		;;
	-h|help)
		display_help
		;;
	*)
	echo "Usage ${0} {noarguments|-v|-r|-h}"
	exit 1

esac
	
