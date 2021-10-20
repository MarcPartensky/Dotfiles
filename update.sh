#!/bin/sh

LOG_FOLDER="/var/log"
[ -d $LOG_FOLDER ] || echo Creating log folder && mkdir -p /var/log

main() {
	if command -v brew; then
		$(brew upgrade -f &&
			brew autoremove &&
			brew cleanup) >& $LOG_FOLDER/update_brew.log &
	fi
	if command -v apt; then
		$(apt --fix-broken install &&
			apt update &&
			apt upgrade -y &&
			apt autoremove) >& $LOG_FOLDER/update_apt.log &
	fi
	if command -v dnf; then
		$(sudo dnf upgrade -y &&
			sudo dnf autoremove) >& $LOG_FOLDER/update_dnf.log &
	fi
	if command -v yum; then
		$(yum update) >& $LOG_FOLDER/update_yum.log &
	fi
	if command -v zipper; then
		$(zypper refresh &&
			zypper update) >& $LOG_FOLDER/update_zypper.log &
	fi
	if command -v emerge; then
		$(emerge --sync &&
			emerge --update --deep --with-bdeps=y @world) >& $LOG_FOLDER/update_emerge.log &
	fi
	if command -v pacman; then
		pacman -Syu >& $LOG_FOLDER/update_pacman.log &
	fi
	if command -v yay; then
		yay -Syu >& $LOG_FOLDER/update_yay.log &
	fi
	if command -v apk; then
		apk -U upgrade >& $LOG_FOLDER/update_apk.log &
	fi
	if command -v snap; then
		snap update >& $LOG_FOLDER/update_snap.log &
	fi
	if command -v pipupgrade; then
		pipupgrade >& $LOG_FOLDER &
	fi
	if command -v npm; then
		$(npm install npm@latest -g &&
			npm config set registry https://registry.npmjs.org &&
			npm cache clean -f &&
			npm update -g &&
			npm audit fix &&
			npm prune) >& $LOG_FOLDER/update_npm.log &
	fi
	if command -v yarn; then
		$(yarn add --dev yarn-upgrade-all &&
			yarn yarn-upgrade-all &&
			yarn upgrade --latest) >& $LOG_FOLDER/update_yarn.log &
	fi
	if command -v pip; then
		$(pip install -U pip &&
			pip freeze > /tmp/pipfreeze.txt) &&
		for lib in $(cat /tmp/pipfreeze.txt); do
			pip install -U $lib &
		done
	fi
	if command -v pip3; then
		pip3 install -U pip >& $LOG_FOLDER/update_pip3.log &
	fi
	if command -v pip2; then
		pip2 install -U pip >& $LOG_FOLDER/update_pip2.log &
	fi
	if command -v cargo; then
		$(cargo install cargo-update &&
			cargo install-update -a) >& $LOG_FOLDER/update_cargo.log &
		# cargo install $(cargo install --list | egrep '^[a-z0-9_-]+ v[0-9.]+:$' | cut -f1 -d' ')
	fi
	if command -v go; then
		if [ -z "$GOPATH" ]; then
			go get -u all >& $LOG_FOLDER/update_go.log &
		fi
	fi
	if command -v tldr; then
		tldr --update >& $LOG_FOLDER/update_tldr.log &
	fi
}

sudo eval "echo Updating the system" &&
	$(main & watch -n 1 jobs -l &) &&
	$LOG_FOLDER/update_*.log > $LOG_FOLDER/update.log &&
	echo Update is done
