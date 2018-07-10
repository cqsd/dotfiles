#!/bin/bash
echo This is meant to be run on new machines, as it can be destructive.
echo Press any key to continue...
read

srcdir=$(pwd)

# see, this is why we use vim-plug now
vimplugins=(
    Rip-Rip/clang_complete
    kien/ctrlp.vim
    Shougo/deoplete.nvim
    eagletmt/ghcmod-vim
    neovimhaskell/haskell-vim
    eagletmt/neco-ghc
    Shougo/neocomplete.vim
    scrooloose/nerdtree
    edkolev/promptline.vim
    luochen1990/rainbow
    scrooloose/syntastic
    bling/vim-airline
    vim-airline/vim-airline-themes
    guns/vim-clojure-static
    altercation/vim-colors-solarized
    tpope/vim-fireplace
    dag/vim-fish
    tpope/vim-fugitive
    w0ng/vim-hybrid
    kristijanhusak/vim-hybrid-material
    henrik/vim-indexed-search
    tpope/vim-surround
    Shougo/vimproc.vim
    # fatih/vim-go.git
)

echo About to nuke your ~/.vim/bundle
read -r -p "Is that OK? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
        rm -fr ~/.vim/bundle
        mkdir -p ~/.vim/bundle
        pushd ~/.vim/bundle
	    # lam might not be a thing ----------v on your machine..
        echo ${vimplugins[*]} | xargs -n1 | lam -s 'https://github.com/' - | xargs -n1 -P8 git clone
        cd ~/.vim/bundle/vimproc.vim && make && echo 'Built vimproc' || echo vimproc failed to build
        # echo "Remember to run :Helptags (and :GoUpdateBinaries, if you're into that)"
        popd
        ;;
    *)
        echo skipping vim plugins
        ;;
esac

echo About to nuke your dotfiles for tmux, vim, and neocomplete
read -r -p "Is that OK? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
        for f in core/*; do
            dest=~/.$(basename $f)
            ln -sf $srcdir/$f $dest && echo Linked $srcdir/$f to $dest
        done
        ;;
    *)
        echo skipping dotfiles
        ;;
esac
