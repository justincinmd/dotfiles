dotfiles
========

## Standard Setup

    cd ~
    git init 
    git remote add origin git@github.com:jcnnghm/dotfiles.git
    git pull
    git submodule update --init

## Special Setup

### SSH Keys

To auto-load private keys with passphrases under OS X, add each key using
`ssh-add -K .ssh/KEY_FILE` to save all the passphrases in the keychain.

### Switching to ZSH

Edit `/etc/passwd` and set the shell to `/bin/zsh`.

### Terminal Profile

On the Mac, import the solarized file.  It's `Solarized Dark.terminal` in `~`.

### Command-T Install

To use command-t, it must be compiled.  It may be necessary to install vim using system ruby as well, if rvm is used.

Mac specific precursor.  Command-t **must** be compiled with the same ruby that VIM is linked against, so it's best to 
switch to the system ruby, then install vim and compile command-t:

    rvm use system
    brew install macvim --override-system-vim
    brew linkapps
    
A `+ruby` should be visble in `vim --version`, or in the alternative, `:ruby 1` should run without error in vim.  
Compile command-t:

    cd ~/.vim/ruby/command-t/
    ruby extconf.rb 
    make clean
    make
    
### Vim Install

If `vim` wasn't compiled with `+ruby`, it may be ncessary to compile it from scratch.  To do that:

    cd ~/
    hg clone https://code.google.com/p/vim/
    mv vim/ vimsrc/
    cd vimsrc/
    ./configure --prefix=~/bin/vim/ --with-features=huge --enable-rubyinterp --enable-pythoninterp --enable-perlinterp --enable-cscope
    make
    make install
    
`~/bin/vim/bin` is on the path, but it's worth running `which vim` to make sure you're picking it up.

### iTerm

From `iTerm > Preferences > General`, change to load preferences from a custom folder.  The folder should be `/Users/USERNAME/iTermSettings`.  Make sure to save settings after each edit.

### Gnome Terminal

First, change the font to "Inconsolata for Powerline Medium", which should be built in.  We also need to change to solarized dark.  Easiest way to do this is to run:

    git clone https://github.com/sigurdga/gnome-terminal-colors-solarized.git
    cd gnome-terminal-colors-solarized
    ./set_dark.sh
    
## Making Changes

### Vim

To add a new pathogen submodule:

    git submodule add git://github.com/scrooloose/nerdcommenter.git .vim/bundle/nerdcommenter

### Moving to Public dotfiles

Move the git config to the prive repo, and pull it.

Remove all the submodule directories:

    rm -rf .vim/bundle/python-mode
    rm -rf .vim/bundle/vim-fugitive
    rm -rf .vim/bundle/nerdcommenter
    rm -rf .vim/bundle/taboo
    rm -rf .vim/bundle/vim-colors-solarized
    rm -rf .vim/bundle/vim-airline
    rm -rf .vim/bundle/vim-sleuth
    rm -rf .vim/bundle/vim-rails
    rm -rf .vim/bundle/vim-bundler
    rm -rf .vim/bundle/vim-sessions
    rm -rf .vim/bundle/vim-misc
    rm -rf .oh-my-zsh
    rm -rf .vim/bundle/vim-ruby

Then:

    rm -rf .git/
    git init
    git remote add origin git@github.com:jcnnghm/dotfiles.git
    git fetch --all
    git reset --hard origin/master
    git submodule update --init
    git branch --set-upstream-to=origin/master master
    
    ./configure.sh
