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
	sudo dnf upgrade -y
	sudo dnf autoremove
fi
if command -v yum; then
	yum update
fi
if command -v zipper; then
	zypper refresh
	zypper update
fi
if command -v emerge; then
	emerge --sync
	emerge --update --deep --with-bdeps=y @world
fi
if command -v pacman; then
	pacman -Syu
fi
if command -v yay; then
	yay -Syu
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
	npm install npm@latest -g
	npm config set registry https://registry.npmjs.org
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
	pip freeze > /tmp/pipfreeze.txt
	for lib in $(cat /tmp/pipfreeze.txt); do
		pip install -U $lib
	done
fi
if command -v pip3; then
	pip3 install -U pip
fi
if command -v pip2; then
	pip2 install -U pip
fi
if command -v cargo; then
	cargo install cargo-update
	cargo install-update -a
	# cargo install $(cargo install --list | egrep '^[a-z0-9_-]+ v[0-9.]+:$' | cut -f1 -d' ')
fi
if command -v go; then
	go get -u all
fi
