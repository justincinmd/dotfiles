#!/bin/bash

# Setup VIM
cd ~/.vim/ruby/command-t/
ruby extconf.rb
make clean
make

exit 0
