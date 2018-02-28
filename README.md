dotfiles
========

## Standard Setup

    cd ~
    git init
    git remote add origin git@github.com:justincinmd/dotfiles.git
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

### Vim Install

If `vim` wasn't compiled with `+ruby` or `+lua`, it may be ncessary to compile it from scratch.  To do that:

    cd ~/
    git clone git@github.com:vim/vim.git
    mv vim/ vimsrc/
    cd vimsrc/
    ./configure --prefix=~/bin/vim/ --with-features=huge --enable-rubyinterp --enable-pythoninterp --enable-perlinterp --enable-cscope --enable-luainterp --enable-fail-if-missing
    make
    make install

`~/bin/vim/bin` is on the path, but it's worth running `which vim` to make sure you're picking it up.

On OSX, you can install vim with `brew install vim --with-lua`.  To see installation options, run `brew options vim`.

### iTerm

From `iTerm > Preferences > General`, change to load preferences from a custom folder.  The folder should be `/Users/USERNAME/iTermSettings`.  Make sure to save settings after each edit.

### Gnome Terminal

First, change the font to "Inconsolata for Powerline Medium", which may be built in.  If it's not built in, the font is available in `~/tools/fonts`.  We also need to change to solarized dark.  Easiest way to do this is to run:

    git clone https://github.com/sigurdga/gnome-terminal-colors-solarized.git
    cd gnome-terminal-colors-solarized
    ./set_dark.sh


### cmdtrack

To install cmdtrack under osx (default build is linux-x64), run `go install github.com/justincinmd/cmdtrack`.  Configure cmdtrack by copying the cmdtrack config from lastpass into ~/.cmdtrack.conf and `chmod 600 ~/.cmdtrack.conf`.


## Making Changes

### Vim

To add a new vim plugin, add a plugin line to `.vimrc`.  For example, to add
the ack plugin at https://github.com/mileszs/ack.vim:

    Plugin 'mileszs/ack.vim'

See `https://github.com/gmarik/Vundle.vim` for more details.  After adding the
plugin, install it by running:

    vim +PluginInstall +qall

This can also be accomplished using:

    ./configure.sh

When setting up Ubuntu, `vim-nox` can be used:

    apt-get install vim-nox

### Submodule

To add a new submodule:

    git submodule add git://github.com/some/module.git .some/module

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
    git remote add origin git@github.com:justincinmd/dotfiles.git
    git fetch --all
    git reset --hard origin/master
    git submodule update --init
    git branch --set-upstream-to=origin/master master

    ./configure.sh
