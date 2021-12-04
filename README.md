# DDNS updater

A set of scripts for DDNS updates. Supports multiple DDNS providers:
* [duckdns.org](https://duckdns.org)
* [dynu.com](https://dynu.com)
* [ydns.io](https://ydns.io)

## Installation

```bash
# clone the repository
git clone https://github.com/varlogerr/ddns-updater.git
# add `hook.bash` to your `.bashrc file`.
# the hook will add the ddns-update-* scripts
# directory to your PATH
cd ddns-updater
echo ". '$(pwd)/hook.bash'" >> ~/.bashrc
# load `.bashrc` to the current session
# (next time you login to bash the hook will be
# loaded automatically from `.bashrc` file)
. ~/.bashrc
# validate ddns-update-* scripts are availabe
ddns-update-duckdns.sh -h
```

## Usage

```bash
# explore the scripts (ddns-update-<provider>.sh)
# and act accordingly
ddns-update-duckdns.sh -h
```
