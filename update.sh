#!/bin/sh

if command -v brew; then
	brew upgrade -f
	brew autoremove
	brew cleanup
fi
if command -v apt; then
	apt --fix-broken install
	apt update
	apt upgrade -y
	apt autoremove
fi
if command -v dnf; then
	dnf upgrade -y
	dnf autoremove
fi
if command -v pacman; then
	pacman -Syu
fi
if command -v yay; then
	yay update
fi
if command -v apk; then
	apk -U upgrade
fi
if command -v snap; then
	sudo snap update
fi
if command -v pipupgrade; then
	pipupgrade
fi
if command -v npm; then
	npm config set registry https://registry.npmjs.org
	npm install npm@latest -g
	npm cache clean -f
	npm update -g
	npm prune
fi
if command -v yarn; then
	yarn add --dev yarn-upgrade-all
	yarn yarn-upgrade-all
	yarn upgrade --latest
fi
if command -v pip; then
	pip install -U pip
fi
if command -v pip3; then
	pip3 install -U pip
fi
if command -v pip2; then
	pip2 install -U pip
fi