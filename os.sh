#!/bin/sh

if [ "$(uname)" == "Darwin" ]; then
	export SYSTEM="osx"
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ] || [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
	export SYSTEM="windows"
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
	export SYSTEM="linux"
fi
