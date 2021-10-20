#!/bin/sh

# Update all package managers available in a system.

LOG_FOLDER="/var/log"
[ -d $LOG_FOLDER ] || echo Creating log folder && mkdir -p /var/log

LOG_FILE="/tmp/update.log"
[ -f $LOG_FILE ] || touch /tmp/update.log

main() {
	if command -v brew; then
		$(brew upgrade -f &&
			brew autoremove &&
			brew cleanup) | tee $LOG_FOLDER/update_brew.log >> $LOG_FILE &
	fi
	if command -v apt; then
		$(apt --fix-broken install &&
			apt update &&
			apt upgrade -y &&
			apt autoremove) | tee $LOG_FOLDER/update_apt.log >> $LOG_FILE &
	fi
	if command -v dnf; then
		$(sudo dnf upgrade -y &&
			sudo dnf autoremove) tee | $LOG_FOLDER/update_dnf.log >> $LOG_FILE &
	fi
	if command -v yum; then
		$(yum update) | tee $LOG_FOLDER/update_yum.log >> $LOG_FILE &
	fi
	if command -v zipper; then
		$(zypper refresh &&
			zypper update) | tee $LOG_FOLDER/update_zypper.log >> $LOG_FILE &
	fi
	if command -v emerge; then
		$(emerge --sync &&
			emerge --update --deep --with-bdeps=y @world) | tee $LOG_FOLDER/update_emerge.log >> $LOG_FILE &
	fi
	if command -v pacman; then
		pacman -Syu | tee $LOG_FOLDER/update_pacman.log >> $LOG_FILE &
	fi
	if command -v yay; then
		yay -Syu | tee $LOG_FOLDER/update_yay.log >> $LOG_FILE &
	fi
	if command -v apk; then
		apk -U upgrade | tee $LOG_FOLDER/update_apk.log >> $LOG_FILE &
	fi
	if command -v snap; then
		snap update | tee $LOG_FOLDER/update_snap.log >> $LOG_FILE &
	fi
	if command -v pipupgrade; then
		pipupgrade | tee $LOG_FOLDER/update_pipupgrade.log >> $LOG_FILE &
	fi
	if command -v npm; then
		$(npm install npm@latest -g &&
			npm config set registry https://registry.npmjs.org &&
			npm cache clean -f &&
			npm update -g &&
			npm audit fix &&
			npm prune) | tee $LOG_FOLDER/update_npm.log >> $LOG_FILE &
	fi
	if command -v yarn; then
		$(yarn add --dev yarn-upgrade-all &&
			yarn yarn-upgrade-all &&
			yarn upgrade --latest) | tee $LOG_FOLDER/update_yarn.log >> $LOG_FILE &
	fi
	if command -v pip; then
		$($(pip install -U pip &&
			pip freeze > /tmp/pipfreeze.txt) &&
		for lib in $(cat /tmp/pipfreeze.txt); do
			pip install -U $lib &
		done) | tee $LOG_FOLDER/update_pip.log >> $LOG_FILE &
	fi
	if command -v pip3; then
		pip3 install -U pip | tee $LOG_FOLDER/update_pip3.log >> $LOG_FILE &
	fi
	if command -v pip2; then
		pip2 install -U pip | tee $LOG_FOLDER/update_pip2.log >> $LOG_FILE &
	fi
	if command -v cargo; then
		$(cargo install cargo-update &&
			cargo install-update -a) | tee $LOG_FOLDER/update_cargo.log >> $LOG_FILE &
		# cargo install $(cargo install --list | egrep '^[a-z0-9_-]+ v[0-9.]+:$' | cut -f1 -d' ')
	fi
	if command -v go; then
		if [ -z "$GOPATH" ]; then
			go get -u all | tee $LOG_FOLDER/update_go.log >> $LOG_FILE &
		fi
	fi
	if command -v tldr; then
		tldr --update | tee $LOG_FOLDER/update_tldr.log >> $LOG_FILE &
	fi
}

sudo echo Updating the system &&
	$(main &&
	$LOG_FOLDER/update_*.log > $LOG_FOLDER/update.log  &&
	echo Update is done &&
	command -v n > /dev/stdout &&
	n Update is done) & tail -f $LOG_FILE
