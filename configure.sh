#!/bin/bash

# Setup VIM
cd ~/.vim/ruby/command-t/
ruby extconf.rb
make clean
make

# Setup Vim Plugins
vim +PluginInstall +qall

exit 0
