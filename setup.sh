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

clone_repos() {
    rm -fr ~/.vim/bundle
    mkdir -p ~/.vim/bundle
    pushd ~/.vim/bundle
    for repo in ${vimplugins[*]}; do
	git clone https://github.com/$repo
    done
    cd ~/.vim/bundle/vimproc.vim && make && echo 'Built vimproc' || echo vimproc failed to build
    # echo "Remember to run :Helptags (and :GoUpdateBinaries, if you're into that)"
    popd
}

echo About to nuke your ~/.vim/bundle
read -r -p "Is that OK? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
	clone_repos
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

if ! [ -z $(command -v nvim) ]; then
    read -r -p "Found nvim. Nuke the config? [y/N] " response
    case "$response" in
        [yY][eE][sS]|[yY])
            mkdir -p ~/.config/nvim
            dest=~/.config/nvim/init.vim
            ln -sf $srcdir/init.vim $dest && echo Linked $srcdir/init.vim to $dest
            ;;
        *)
            echo skipping nvim
            ;;
    esac
fi
