#!/bin/sh

# Update all package managers available in a system.

LOG_FOLDER="/var/log"
[ -d $LOG_FOLDER ] || echo Creating log folder && mkdir -p /var/log

LOG_FILE="/tmp/update.log"
[ -f $LOG_FILE ] || touch /tmp/update.log

PID_FILE="/var/run/update.pid"

main() {
	if command -v brew > /dev/null; then
		$(brew upgrade -f &&
			brew autoremove &&
			brew cleanup) | sudo tee $LOG_FOLDER/update_brew.log >> $LOG_FILE 2>&1
	fi
	if command -v apt > /dev/null; then
		$(apt --fix-broken install &&
			apt update &&
			apt upgrade -y &&
			apt autoremove) | sudo tee $LOG_FOLDER/update_apt.log >> $LOG_FILE 2>&1
	fi
	if command -v pkg > /dev/null; then
		$(pkg --fix-broken install &&
			pkg update &&
			pkg upgrade -y &&
			pkg autoremove) | sudo tee $LOG_FOLDER/update_pkg.log >> $LOG_FILE 2>&1
	fi
	if command -v dnf > /dev/null; then
		$(sudo dnf upgrade -y &&
			sudo dnf autoremove) | sudo tee $LOG_FOLDER/update_dnf.log >> $LOG_FILE 2>&1
	fi
	if command -v yum > /dev/null; then
		$(yum update) | sudo tee $LOG_FOLDER/update_yum.log >> $LOG_FILE 2>&1
	fi
	if command -v zipper > /dev/null; then
		$(zypper refresh &&
			zypper update) | sudo tee $LOG_FOLDER/update_zypper.log >> $LOG_FILE 2>&1
	fi
	if command -v emerge > /dev/null; then
		$(emerge --sync &&
			emerge --update --deep --with-bdeps=y @world) | sudo tee $LOG_FOLDER/update_emerge.log >> $LOG_FILE 2>&1
	fi
	if command -v pacman > /dev/null; then
		pacman -Syu | sudo tee $LOG_FOLDER/update_pacman.log >> $LOG_FILE 2>&1
	fi
	if command -v yay > /dev/null; then
		yay -Syu | sudo tee $LOG_FOLDER/update_yay.log >> $LOG_FILE 2>&1
	fi
	if command -v apk > /dev/null; then
		apk -U upgrade | sudo tee $LOG_FOLDER/update_apk.log >> $LOG_FILE 2>&1
	fi
	if command -v snap > /dev/null; then
		snap refresh
		snap update | sudo tee $LOG_FOLDER/update_snap.log >> $LOG_FILE 2>&1
	fi
	if command -v pipupgrade > /dev/null; then
		pipupgrade | sudo tee $LOG_FOLDER/update_pipupgrade.log >> $LOG_FILE 2>&1
	fi
	if command -v npm > /dev/null; then
		$(npm install npm@latest -g &&
			npm config set registry https://registry.npmjs.org &&
			npm cache clean -f &&
			npm update -g &&
			npm audit fix &&
			npm prune) | sudo tee $LOG_FOLDER/update_npm.log >> $LOG_FILE 2>&1
	fi
	if command -v yarn > /dev/null; then
		$(yarn add --dev yarn-upgrade-all &&
			yarn yarn-upgrade-all &&
			yarn upgrade --latest) | sudo tee $LOG_FOLDER/update_yarn.log >> $LOG_FILE 2>&1
	fi
	if command -v pip > /dev/null; then
        $(pip install -U pip &&
        pip freeze | cut -d= -f1 > /tmp/pipfreeze.txt &&
        for lib in $(cat /tmp/pipfreeze.txt); do
            pip install -U $lib &
        done) | sudo tee $LOG_FOLDER/update_pip.log >> $LOG_FILE 2>&1
	fi
	if command -v pip3 > /dev/null; then
		pip3 install -U pip | sudo tee $LOG_FOLDER/update_pip3.log >> $LOG_FILE 2>&1
	fi
	if command -v pip2 > /dev/null; then
		pip2 install -U pip | sudo tee $LOG_FOLDER/update_pip2.log >> $LOG_FILE 2>&1
	fi
	if command -v cargo > /dev/null; then
		$(cargo install cargo-update &&
			cargo install-update -a) | sudo tee $LOG_FOLDER/update_cargo.log >> $LOG_FILE 2>&1
		# cargo install $(cargo install --list | egrep '^[a-z0-9_-]+ v[0-9.]+:$' | cut -f1 -d' ')
	fi
	if command -v go > /dev/null; then
		if [ -z "$GOPATH" ]; then
			go get -u all | sudo tee $LOG_FOLDER/update_go.log >> $LOG_FILE 2>&1
		fi
	fi
	if command -v tldr > /dev/null; then
		tldr --update | sudo tee $LOG_FOLDER/update_tldr.log >> $LOG_FILE 2>&1
	fi
}

sudo echo "Updating the system" &&
	$(main &&
	sudo tail -f $LOG_FOLDER/update_*.log > $LOG_FOLDER/update.log $1>$PID_FILE &&
	echo Update is done &&
	command -v n > /dev/stdout &&
	n Update is done) & tail -f $LOG_FILE
