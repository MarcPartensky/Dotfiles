#!/bin/sh

# Update all package managers available in a system.

LOG_FOLDER="/tmp"
[ -d $LOG_FOLDER ] || echo Creating log folder && mkdir -p $LOG_FOLDER

LOG_FILE="/tmp/update.log"
[ -f $LOG_FILE ] || touch /tmp/update.log

PID_FILE="/tmp/update.pid"
echo $$ > $PID_FILE

main() {
	if command -v apt; then
		$(apt --fix-broken install &&
			apt update &&
			apt upgrade -y &&
			apt autoremove -y) 2>&1 | tee $LOG_FOLDER/update_apt.log
	fi
	if command -v dnf; then
		$(sudo dnf upgrade -y &&
			sudo dnf autoremove -y) 2>&1 | tee $LOG_FOLDER/update_dnf.log
	fi
	if command -v yum; then
		sudo yum update 2>&1 | tee $LOG_FOLDER/update_yum.log
	fi
	if command -v zipper; then
		$(zypper refresh &&
			zypper update) 2>&1 | tee $LOG_FOLDER/update_zypper.log
	fi
	if command -v emerge; then
		$(emerge --sync &&
			emerge --update --deep --with-bdeps=y @world) 2>&1 | tee $LOG_FOLDER/update_emerge.log
	fi
	if command -v pacman; then
		sudo pacman -Syu 2>&1 | tee $LOG_FOLDER/update_pacman.log
	fi
	if command -v yay; then
		yay -Syu 2>&1 | tee $LOG_FOLDER/update_yay.log
	fi
	if command -v apk; then
		sudo apk -U upgrade 2>&1 | tee $LOG_FOLDER/update_apk.log
	fi
	if command -v snap; then
		sudo snap refresh 2>&1 | tee $LOG_FOLDER/update_snap.log
	fi
	if command -v pipupgrade; then
        $(pip install bpyutils &&
            pipupgrade) 2>&1 | tee $LOG_FOLDER/update_pipupgrade.log
	fi
	if command -v npm; then
		$(npm install npm@latest -g &&
			npm config set registry https://registry.npmjs.org &&
			npm cache clean -f &&
			npm update -g &&
			npm audit fix &&
			npm prune) 2>&1 | tee $LOG_FOLDER/update_npm.log
	fi
	if command -v yarn; then
		$(yarn add --dev yarn-upgrade-all &&
			yarn yarn-upgrade-all &&
			yarn upgrade --latest) 2>&1 | tee $LOG_FOLDER/update_yarn.log
	fi
	if command -v pip; then
		$($(pip install -U pip &&
			pip freeze > /tmp/pipfreeze.txt) &&
		for lib in $(cat /tmp/pipfreeze.txt); do
			pip install -U $lib &
		done) 2>&1 | tee $LOG_FOLDER/update_pip.log
	fi
	if command -v pip3; then
		pip3 install -U pip 2>&1 | tee $LOG_FOLDER/update_pip3.log
	fi
	if command -v pip2; then
		pip2 install -U pip 2>&1 | tee $LOG_FOLDER/update_pip2.log
	fi
	if command -v cargo; then
		$(cargo install cargo-update &&
			cargo install-update -a) 2>&1 | tee $LOG_FOLDER/update_cargo.log
		# cargo install $(cargo install --list | egrep '^[a-z0-9_-]+ v[0-9.]+:$' | cut -f1 -d' ')
	fi
	if command -v go; then
		if [ -z "$GOPATH" ]; then
			go get -u all 2>&1 | tee $LOG_FOLDER/update_go.log
		fi
	fi
	if command -v tldr; then
		tldr --update 2>&1 | tee $LOG_FOLDER/update_tldr.log
	fi
	if command -v brew; then
		$(brew upgrade -f &&
			brew autoremove &&
			brew cleanup) 2>&1 | tee $LOG_FOLDER/update_brew.log
	fi
}

# rm -f $LOG_FOLDER/update*.log
# ls $LOG_FOLDER/update*.log


sudo echo "Updating the system" &&
	main &&
	sudo tail -f $LOG_FOLDER/update_*.log > $LOG_FOLDER/update.log &&
	command -v n > /dev/null &&
	n "Update is done"
