#!/bin/bash

clear

echo "Work with Packer"
echo "1 - Packer validate: $ packer validate ./ubuntu16.json"
echo "2 - Packer build: $ packer build ubuntu16.json"

read packer;

case $packer in

	1) packer validate ~/infra/packer/ubuntu16.json
		;;
	2) packer build infra/packer/ubuntu16.json
		;;
esac
