gitbrowse() {
	if [[ -z "$1" ]]; then
		echo -e "warning: no remote name given. Using origin as default\n"
	fi
	local remote="${1:-origin}"
	local tool="$(open_tool)"
	local tool=open
	local url="$(parsed_remote $remote)"
	if [[ -z "$tool" ]]; then
		echo "fatal: you must have either 'open' or 'xdg-open' installed"
		return 1
	fi
	if [[ -z "$url" ]]; then
		echo "fatal: no remote with name '$remote' was found"
		return 1
	fi
	echo "Browsing to $url..."
	eval "$tool $url" 2> /dev/null || echo "fatal: cannot browse to $url"
}
gitbrowse
