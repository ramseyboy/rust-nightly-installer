#!/usr/bin/env bash
#downloads and installs nightly rust release on OSX
#installer puts rust binaries in /usr/local/bin by default

readonly pkg_prefix=rust-nightly
readonly rust_pkg_name="${pkg_prefix}-`eval date +%m-%d-%Y`.pkg"

function remove_existing_pkg {
	ls -l | grep "$pkg_prefix".$pkg | xargs rm -f --
}

function download_pkg {
	curl -S $1 > $rust_pkg_name
}

function install_pkg {
	#security?
	#remove piped input to have script prompt for pswd, else supply var
	echo $PASSWD | sudo -S installer -pkg $rust_pkg_name -target / -verboseR
}

function main {
	local nightly_url=http://static.rust-lang.org/dist/rust-nightly-x86_64-apple-darwin.pkg

	#if pkg exists in directory remove it
	remove_existing_pkg
	#grab newest nightly binaries from the server
	download_pkg $nightly_url
	#install into /usr/local/bin
	install_pkg
	echo "nightly installed to /usr/local/bin"
}

main
