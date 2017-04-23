export PATH=/bin:/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin:$PATH
export PATH="$PATH:$HOME/.rvm/bin"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
export TERM=xterm-256color

#PROMPT STUFF
GREEN=$(tput setaf 2);
YELLOW=$(tput setaf 3);
WHITE=$(tput setaf 7)

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

#Default Prompt
PS1="${YELLOW}\w${GREEN}\$(git_branch)${WHITE}\n$(rand_element 🔥 👟)  $ ";
# PS1="${YELLOW}\w${GREEN}\$(git_branch)${WHITE}\n$ ";

# history size
HISTSIZE=5000
HISTFILESIZE=10000

# PATH ALTERATIONS


## CDPATH ALTERATIONS
CDPATH=.:$HOME:$HOME/Developer:$HOME/Desktop

# Custom Aliases
alias start="BASE_PATH=launch npm start"
alias r="npm run";
alias kall="killall gulp node";
alias ll="ls -al";
alias ..="cd ../";
alias ..l="cd ../ && ll";
alias pg="echo 'Pinging Google' && ping www.google.com";
alias oc="open -a 'Google Chrome' $1";
alias vb="vim ~/.bash_profile";
alias sb="source ~/.bash_profile";
alias mvrc="mvim ~/dotfiles/.vimrc";
alias de="cd ~/Desktop";
alias d="cd ~/Developer";
alias diary='pushd ~/Documents/Records/developer-diary && vim `date +"%Y-%m-%d"`.md && popd'
cdl() { cd "$@" && ll; }
shorten() {
  ~/Developer/hive-api/dist/cli.js --url "$1" --custom "$2";
}

killport() { lsof -i tcp:"$@" | awk 'NR!=1 {print $2}' | xargs kill ;}

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


# npm aliases
alias ni="npm install";
alias r='npm run'
alias nrs="npm run start -s --";
alias nrb="npm run build -s --";
alias nrt="npm run test -s --";
alias rmn="rm -rf node_modules;"
alias flush-npm="rm -rf node_modules && npm i && say NPM is done";
alias nicache="npm install --cache-min 999999"


# Custom functions
mg () { mkdir "$@" && cd "$@" ; }


# Bash completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi


[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


# Got this from Jamis: https://gist.githubusercontent.com/jamischarles/752ad319df780122c772168ad0bbc67e/raw/aa4f14368ff4cbcc6f3f219167deac9b0c939ef1/.npm_install_autocomplete.bashrc

# BASH standalone npm install autocomplete. Add this to ~/.bashrc file.
_npm_install_completion () {
    local words cword
    if type _get_comp_words_by_ref &>/dev/null; then
      _get_comp_words_by_ref -n = -n @ -w words -i cword
    else
      cword="$COMP_CWORD"
      words=("${COMP_WORDS[@]}")
    fi

	local si="$IFS"

	# if your npm command includes `install` or `i `
	if [[ ${words[@]} =~ 'install' ]] || [[ ${words[@]} =~ 'i ' ]]; then
		local cur=${COMP_WORDS[COMP_CWORD]}

		# supply autocomplete words from `~/.npm`, with $cur being value of current expansion like 'expre'
		COMPREPLY=( $( compgen -W "$(ls ~/.npm )" -- $cur ) )
	fi

	IFS="$si"
}
# bind the above function to `npm` autocompletion
complete -o default -F _npm_install_completion npm
## END BASH npm install autocomplete


