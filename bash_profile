export PATH=/bin:/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin:$PATH
export PATH="$PATH:$HOME/.rvm/bin"
export NVM_DIR="$HOME/.nvm"
export PATH=/bin:/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin:$PATH
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm


export TERM=xterm-256color

#PROMPT STUFF
GREEN=$(tput setaf 2);
YELLOW=$(tput setaf 3);
WHITE=$(tput setaf 7);
RESET=$(tput sgr0);

function git_branch {
  # Shows the current branch if in a git repository
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\ \(\1\)/';
}

rand() {
  printf $((  $1 *  RANDOM  / 32767   ))
}
rand_element () {
  local -a th=("$@")
  unset th[0]
  printf $'%s\n' "${th[$(($(rand "${#th[*]}")+1))]}"
}

EMOJI="$(rand_element  👽 🔥 🚀 🤖 👟 🌮 🎉)"

#Default Prompt
PS1="${YELLOW}\w${GREEN}\$(git_branch)${RESET}\n${EMOJI}  $ ";
# PS1="\n▲ "
# PS1="\n${EMOJI}  "

# history size
HISTSIZE=5000
HISTFILESIZE=10000

# weird ulimit stuff
ulimit -n 100000 100000
# sudo launchctl limit maxfiles 100000 100000
# ulimit -n 1000000

# PATH ALTERATIONS
## Node
PATH="/usr/local/bin:$PATH:./node_modules/.bin";

# #Custom bins
PATH="$PATH:~/.bin";
# dotfile bins
PATH="$PATH:~/.my_bin";

## CDPATH ALTERATIONS
CDPATH=.:$HOME:$HOME/Developer:$HOME/Desktop

# Custom Aliases
alias start="BASE_PATH=launch npm start"
alias kall="killall gulp node";
alias a="atom .";
alias ll="ls -al";
alias ..="cd ../";
alias ..l="cd ../ && ll";
alias pg="echo 'Pinging Google' && ping www.google.com";
alias oc="open -a 'Google Chrome' $1";
alias vb="vim ~/.bash_profile";
alias sb="source ~/.bash_profile";
alias mvrc="mvim ~/dotfiles/.vimrc";
alias de="cd ~/Desktop";
alias p="cd ~/Projects";
alias diary='pushd ~/Google\ Drive/Personal/Documents/Records/developer-diary && mvim `date +"%Y-%m-%d"`.md && popd'
cdl() { cd "$@" && ll; }
shorten() {
  ~/Developer/hive-api/dist/cli.js --url "$1" --custom "$2";
}
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
alias deleteDSFiles="find . -name '.DS_Store' -type f -delete"

alias lt="http-server ~/Developer/love-texts";

killport() { lsof -i tcp:"$@" | awk 'NR!=1 {print $2}' | xargs kill -9 ;}
alias flushdns="sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder"

# git aliases
alias g="git";
alias gb="git branch";
alias gco="git checkout $1";
alias gcb="git checkout -b $1";
alias gc="git commit -m $1";
alias gs="git status";
alias gp="git pull";
alias gsa="git stash apply";
alias gf="git fetch";
alias gpush="git push origin HEAD";
alias gd="git diff";
alias ga="git add .";
alias gfa="git fetch --all --prune"
alias gbda='git branch --no-color --merged | command grep -vE "^(\*|\s*(master|develop|dev)\s*$)" | command xargs -n 1 git branch -d'

# javascript air
JSA_DIR="~/Developer/javascriptair/site"
alias jsa="cd $JSA_DIR"

# npm aliases
alias ni="npm install";
alias r="npm run";
alias nrs="npm run start -s --";
alias nrb="npm run build -s --";
alias nrt="npm run test -s --";
alias rmn="rm -rf node_modules;"
alias flush-npm="rm -rf node_modules && npm i && say NPM is done";
alias nicache="npm install --cache-min 999999"
# yarn aliases
alias yar="yarn run";
alias yas="yarn run start -s --";
alias yab="yarn run build -s --";
alias yat="yarn run test -s --";
alias yoff="yarn add --offline";
alias ypm="echo \"Installing deps without lockfile and ignoring engines\" && yarn install --no-lockfile --ignore-engines"


# Custom functions
mg () { mkdir "$@" && cd "$@" ; }

# Bash completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
. $(brew --prefix)/etc/bash_completion
fi

export PATH="$PATH:$HOME/.rvm/bin"


[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


# nvm
source ~/.nvm/nvm.sh
source ~/.avn/bin/avn.sh

# begin nps completion
source /Users/kdodds/.nps/completion.sh
# end nps completion

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
