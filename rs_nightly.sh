#!/usr/bin/env bash
#downloads and installs nightly rust release on OSX
#installer puts rust binaries in /usr/local/bin by default

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

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
