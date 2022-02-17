#!/bin/bash

if ["$1" == ""]; then 
	echo "run or build"
	exit
fi

if [ "$1" == "run" ]; then 
	make clean && make html && firefox build/html/index.html
	exit
fi

if [ "$1" == "build" ]; then 
	make clean && make html
	exit
fi

if [ "$1" == "update" ]; then
	make clean && make html && scp -r ./build/html root@47.96.101.230:/root/
	exit
fi
