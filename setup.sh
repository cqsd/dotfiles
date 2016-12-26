#!/bin/bash

function linkdotfile {
    sourcedir=$(pwd)
    filename=$1
    cd ~/ > /dev/null

    # idk why but -f doesn't work for me?
    if [[ -f ~/$filename && ! -L ~/$filename ]]; then
        echo "$filename already exists; backing up as $filename.bk."
        mv ~/$filename ~/$filename.bk
    fi

    {
        ln -sf $sourcedir/$filename $filename &&
        echo "Linked $filename to ~/$filename."
    } || echo "Failed to link $filename to ~/$filename; do you have the right permissions?"
    cd - > /dev/null
}

linkdotfile .vimrc
linkdotfile .vimplainrc
linkdotfile .tmux.conf
