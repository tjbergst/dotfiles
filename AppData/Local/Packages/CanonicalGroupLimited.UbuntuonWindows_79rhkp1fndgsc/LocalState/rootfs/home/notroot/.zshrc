# zshrc

# --------------------------------- INIT ZSH ---------------------------------

# globals
export ZSH="/home/notroot/.oh-my-zsh"
ZSH_THEME="agnoster"
DISABLE_AUTO_UPDATE="true"


# plugins
plugins=(git python tmux colored-man-pages kubectl oc zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh


# --------------------------------- BASE SETUP ---------------------------------

# load other
source ~/.zsh.d/constants.zsh 
source ~/.zsh.d/devops.zsh 
source ~/.zsh.d/docker.zsh 

# gpg config
export GPG_TTY=$(tty)

# fix dircolors
eval "$(dircolors ~/.dircolors)";

# rust
export PATH=$PATH:$HOME/.cargo/bin

# go 
export PATH=$PATH:$GOPATH/bin  



# --------------------------------- ALIASES & UTILS ---------------------------------

# my aliases
alias ls='ls -Alh --color'
alias edit-zsh='code -n ~/.zshrc'
function chpwd() { emulate -L zsh; ls; }
function srcit() { source ~/.zshrc }
function fdef()  { type -f $1 }
function pretty_path() { sed 's/:/\n/g' <<< "$PATH" }

function updaterepo() {
    cd $1 && git fetch && git pull && cd -
    echo "updated $1"
}

function sync_folders() {
    echo "syncing $1 to $2.."
    rsync -rtvuc $1 $2
}

function enable_clipboard_wsl() {
    pkill -e Xvfb
    export DISPLAY=:0
    Xvfb :0 -screen 0 1366x768x16 &
}

# gopass generate password
alias makepass='gopass pwgen -x --xs -'

# go colorized test
function go_test() {
    go test $* | \
    sed ''/PASS/s//$(printf "\033[32mPASS\033[0m")/'' | \
    sed ''/SKIP/s//$(printf "\033[34mSKIP\033[0m")/'' | \
    sed ''/FAIL/s//$(printf "\033[31mFAIL\033[0m")/'' | \
    GREP_COLOR="01;33" egrep --color=always '\s*[a-zA-Z0-9\-_.]+[:][0-9]+[:]|^'
}

function _gotest() {
    # TODO: not working
    go test $* |
    sed ''/PASS/s//$(echo $fg[green] "PASS")/'' | \
    sed ''/SKIP/s//$(echo $fg[blue] "SKIP")/'' | \
    sed ''/FAIL/s//$(echo $fg[red] "FAIL"/'') | \
    GREP_COLOR=$fg[yellow] egrep --color=always '\s*[a-zA-Z0-9\-_.]+[:][0-9]+[:]|^'
}



# --------------------------------- GIT ---------------------------------

function gitcm() {git commit -m $1}

alias pushit='git push'

# git config dotfile dir function
# https://www.atlassian.com/git/tutorials/dotfiles
alias config="git --git-dir=$CHOME/.cfg/ --work-tree=$CHOME"


# --------------------------------- MISC ---------------------------------

# ps1 fix
export PS1="$PS1"$'\n'" > "

# disable history sharing 
setopt no_share_history

# load completions?
autoload -U compinit && compinit
