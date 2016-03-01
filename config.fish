fish_vi_mode

alias e=vim
alias la="ls -a"
alias l="ls"
alias tree="tree -C"
alias java_home="/usr/libexec/java_home"

# Needs to be global
set -gx ANDROID_SDK_PATH $HOME/android-sdk

set ANDROID_SDK_TOOLS $HOME/Library/Android/sdk/tools
set CARGO_BIN_HOME $HOME/.cargo/bin
set CLOJURE_HOME $HOME/.m2/repository/org/clojure/clojure/1.7.0 # Sticking with 1.7.0
set HOME_BIN $HOME/bin
set MATLAB_HOME /Applications/MATLAB_R2015b.app/bin
set RUST_SRC_PATH $HOME/.rust_source/rust/src
set RUST_RACER $HOME/.rust_source/racer/target/release
# set SCALA_HOME /usr/local/opt/scala/idea # For IntelliJ, in case I ever decide to use an IDE
set TEXINPUTS $HOME/.latex
set TEX_BIN /usr/texbin

set -gx PATH $PATH $CARGO_BIN_HOME $CLOJURE_HOME $HOME_BIN $MATLAB_HOME $RUST_SRC $RUST_RACER $TEX_BIN $TEXINPUTS $ANDROID_SDK_TOOLS

# I'm going to kms if I have to keep typing this out in full
set FISH_HOME $HOME/.config/fish/

function edit_fish_conf
  e $FISH_HOME/config.fish
end
