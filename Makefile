# Prepend the bashrc
# make sure vim8 in installed
# apt-get update if sudo
# prepend the vimrc
#
# Make sure the files have not already been prepended.
# Make sure vim8 is installed. Make it from source if not.
#

SHELL:=/bin/bash
shell:=/bin/bash
MY_DEFAULTS=$(HOME)/.config/my_defaults
VIMFILE=$(HOME)/.vimrc
VIMVERSION:=$(shell vim --version | head -1 | grep -o '[0-9]\.[0-9]')
VUNDLE:=$(HOME)/.vim/bundle/Vundle.vim


all: install update install_vim prepend_vimrc install_vundle prepend_bashrc
	# This is the default

vim: install_vim prepend_vimrc install_vindle

install:
	# Confirm git is installed then pull the defaults.
	#
	if ! test -d $(MY_DEFAULTS); then \
		command -v git >/dev/null 2>&1 || { echo >&2 "I require git but it's not installed.  Aborting."; exit 1; };  \
		mkdir -p $(HOME)/.config; \
		git clone https://github.com/BenNewsome/setup_linux.git $(MY_DEFAULTS); \
	else \
		echo "folder already installed"; \
	fi


update:
	cd $(MY_DEFAULTS) && git pull;


# Prepend the vim file with the vimrc file
prepend_vimrc:
	FILELINE=$(shell head -n 1 $(VIMFILE) | tail -c 6 )
	if ! [ "vimrc" = "$(shell head -n 1 $(VIMFILE) | tail -c 6 )" ]; then \
		echo ":so $(MY_DEFAULTS)/vimrc" > tmp_file ;\
		cat $(VIMFILE) >> tmp_file ;\
		cp tmp_file $(VIMFILE) ;\
		rm -f tmp_file ;\
	fi

install_vundle:
	if ! test -d $(VUNDLE); then \
		git clone https://github.com/VundleVim/Vundle.vim.git $(VUNDLE); \
	else \
		echo "Vundle is already installed"; \
	fi
	vim +PluginInstall +qall 

install_vim:
	# Install vim8 manually if not installed
	if [ $(shell echo $(VIMVERSION) '<' 8.0 | bc -l ) = 1 ]; then \
		 echo "VIM 8 is not installed and is needed"; \
		 exit_the_script; \
	fi


prepend_bashrc:
	# Prepend the bashrc
	echo "source $(MY_DEFAULTS)/bashrc" > tmp_file
	cat ~/.bashrc >> tmp_file
	cp tmp_file ~/.bashrc
	rm tmp_file
