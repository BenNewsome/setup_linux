# Prepend the bashrc
# make sure vim8 in installed
# apt-get update if sudo
# prepend the vimrc
#
# Make sure the files have not already been prepended.
# Make sure vim8 is installed. Make it from source if not.
#

MY_DEFAULTS="$(HOME)/.config/my_defaults"

all: update prepent_vimrc prepend_bashrc
	# This is the default
	echo "Nothing done"


update:
	# Confirm git is installed then pull the defaults.
	command -v git >/dev/null 2>&1 || { echo >&2 "I require git but it's not installed.  Aborting."; exit 1; }
	mkdir -p $(HOME)/.config
	git clone https://github.com/BenNewsome/setup_linux.git $(MY_DEFAULTS)


prepend_vimrc:
	# Prepend the vim file with the vimrc file
	echo ":so $(MY_DEFAULTS)/vimrc" > tmp_file
	cat ~/.vimrc >> tmp_file
	cp tmp_file ~/.vimrc
    # Install the vim pluggins
    vim +PluginInstall +qall

prepend_bashrc:
	# Prepend the bashrc
	echo "source $(MY_DEFAULTS)/bashrc" > tmp_file
	cat ~/.bashrc >> tmp_file
	cp tmp_file ~/.bashrc
