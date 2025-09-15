# vim: set filetype=sh:
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/andry/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="%Y.%m.%d-%H:%M"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    colored-man-pages
    colorize
    macos
)

# offer a reminder every few days, if there are updates available
zstyle ':omz:update' mode reminder

# This will check for updates every 7 days
zstyle ':omz:update' frequency 7

source $ZSH/oh-my-zsh.sh

# User configuration

#-------------------------------------------- USER LOCAL ------------#

### using brew (instead of MacPorts)
#
# 
### Homebrew directories :
#
# /opt/homebrew/
#
# Homebrew creates log files in your Library folder at: ~/Library/Logs/Homebrew/
# /Library/Caches/Homebrew/
#
### To update :
# brew update && brew outdated && brew upgrade
# brew cleanup
#
### To restart your shell so the changes in .bashrc take effect :
# exec "$SHELL"

#-------------------------------------------- Prerequisites ------------#

function fresh-shell() {
    
    unset PATH
    unset LD_LIBRARY_PATH
    unset DYLD_LIBRARY_PATH
    unset PYTHONPATH
    unset XROOTD_DIR

    ## ---> Generic path

    export PATH=/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin
    eval "$(/opt/homebrew/bin/brew shellenv)"

    ## ---> add git shell script to path

    # export PATH=/usr/local/share/git-core/contrib/workdir/:$PATH

    # ---> add latex binaries to path

    export MIKTEX_BINARY_PATH=/Library/TeX/texbin
    export PATH=$MIKTEX_BINARY_PATH:$PATH

    ## ---> add Visual Studio Code (code)

    export PATH=$PATH:"/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

    ## ---> Generic library
    
    LD_LIBRARY_PATH=$(brew --prefix)/lib:/usr/local/lib:/usr/lib
    export LD_LIBRARY_PATH

    ## ---> BOOST environment variables for CMake

    unset BOOST_ROOT
    unset BOOST_INCLUDEDIR
    unset BOOST_LIBRARYDIR
    BOOST_ROOT=$(brew --prefix boost)
    export BOOST_INCLUDEDIR=${BOOST_ROOT}/include/boost/
    export BOOST_LIBRARYDIR=${BOOST_ROOT}/lib/


    ## ---> used to manage virtual environments in python (installed via homebrew)

    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"

    export WORKON_HOME=$HOME/.virtualenvs
    pyenv virtualenvwrapper_lazy

    #unset VIRTUALENVWRAPPER_PYTHON
    #export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
    #export WORKON_HOME=$HOME/.virtualenvs
    #source /usr/local/bin/virtualenvwrapper.sh

    ## ---> add Rust

    . "$HOME/.cargo/env"

    ## ---> empties the command hash table, so that finding commands starts again from scratch
    rehash

    ## ---> activate zsh-completions installed with brew

    if type brew &>/dev/null; then
      FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
      autoload -Uz compinit
      compinit
    fi

}

fresh-shell


##-------------------------------------------- Utilities ------------#

function setup-utilities() {

    ## ---> set path to gs for gimp

    unset GS_PROG
    GS_PROG=$(brew --prefix)/bin/gs
    export GS_PROG

    ## ---> aquamacs editor

    alias aquamacs='open -b org.gnu.Aquamacs'
    export EDITOR=/Applications/Aquamacs.app/Contents/MacOS/bin/aquamacs

    ## ---> java

    export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-24.jdk/Contents/Home/
}

setup-utilities

function setup-openssl() {

    ## --> add openssl to path

    export PATH=$(brew --prefix openssl@3)/bin:${PATH}
}

function setup-old-openssl() {

    ## --> add openssl to path

    export PATH=$(brew --prefix openssl@1.1)/bin:${PATH}
}

function setup-php() {
    ## ---> to start php now and restart at login
    brew services start php 
    # Or, if you don't want/need a background service you can just run:
    # /usr/local/opt/php/sbin/php-fpm --nodaemonize
}

##---------------------------------- CUSTOMIZE ENVIRONMENT ------------#

##----------------------------------------------
## set the display mode
## works for Apple X11 with Fast User Switching
##----------------------------------------------

if [[ -z $DISPLAY && -z $SSH_CONNECTION ]]; then
#    disp_no=($( ps -awx | grep -F X11.app | awk '{print $NF}' | grep -e ":[0-9]"  ))
    disp_no=($( ps -awx | grep -F XQuartz.app | awk '{print $NF}' | grep -e ":[0-9]"  ))
    if [[ -n $disp_no ]];then
        export DISPLAY=${disp_no}.0
    else
        export DISPLAY=:0.0
    fi
    echo "DISPLAY has been set to $DISPLAY"
fi

##---------------------------------------
## aliases
##---------------------------------------

function setup-alias() {

    ##-------------
    ## use colors
    ##-------------

    export TERM=xterm-256color

    ## customize BSD 'ls' colors 

#    export LSCOLORS=exGxfxdaCxdadaCxcxeCed # custom colors

    ## customize GNU coreutils 'ls' colors

#    export LS_OPTIONS='-G'
    # if [ "$TERM" != "dumb" ]; then
    #     # export LS_OPTIONS='--color=auto'
    #     eval `dircolors ~/.dir_colors`
    # fi
    # echo

    ##---------------------------
    ## my aliases (environment)
    ##---------------------------

    #    alias ls='ls $LS_OPTIONS'
    alias ls='ls -G'
    alias lf='ls -F'
    alias lh='ls -llhtr'
    alias la='ls -a'
    alias lla='ls -llhtra'
    alias less='less -r'
    alias cp='cp -ip'
    alias diff='diff -b'
    alias df='df -h'
    alias du='du -h'
    alias mv='mv -i'
    alias mkdir='mkdir -p'
    alias scp='scp -p'
    alias wget='curl -O'
    # alias which='which -a'
    unalias grep
    alias grep='grep --color=auto'

    alias tmuxk='tmux kill-session -t'
    alias tmuxa='tmux attach -t'
    alias tmuxl='tmux list-sessions'
    alias tmuxn='tmux new -s'

    ## ---> Set up fzf key bindings and fuzzy completion
    source <(fzf --zsh)

    ## ---> alias to use instead of regular git
    ##      when interacting with dotfiles repository
    alias dotcfg="/opt/homebrew/bin/git --git-dir=${HOME}/.dotfiles --work-tree=${HOME}"

    ## ---------------------------
    ## tunnels vers intra ou extra
    ## ---------------------------
    
    ## not working any more
    # alias to-intra='sudo openfortivpn 132.167.192.58:443 --trusted-cert 7b82074aedb7e7ecaa4e4d4957ee65c08655e684fbdd1eca51d115e43da6b257 --pppd-use-peerdns=1 -u ar218432'
    # alias to-intra='sudo openfortivpn 132.167.192.58:443 --trusted-cert 479b69e94d5af7e87d2330cf3d8899c03d9ee48146ca08262a759476308cc015 --pppd-use-peerdns=1 -u ar218432'
    #
    # alias to-extra='sudo openfortivpn 132.167.192.210:443 --trusted-cert 42483bb9b70c8d3110ec349ccfffbca0e4248f0d3a76d1ef10cd8c7ff1be338b --pppd-use-peerdns=1 -u arakotoz@extra.cea.fr'
    # alias to-extra='sudo openfortivpn 132.167.192.210:443 --trusted-cert 4994f90040b395325402f4e8be23b2089998c2a1f98db9524ee92b760a4b0092:q --pppd-use-peerdns=1 -u arakotoz@extra.cea.fr'

    ## ---> getting AFS tokens

    # alias kccf='klog andryr -cell in2p3.fr'
    # alias kcea='klog arakotoz -cell dapnia.saclay.cea.fr'
    alias kcern='kinit arakotoz@CERN.CH'

    ## ---> shortcuts for log in various computer facilities

    alias sdapint='ssh -Y dapint'
    alias siclust='ssh -Y iclust'

    ## ---> command to change the offline version

    #alias mysoft='source /Users/andry/dev_area/usr_sh/set_mysoft.sh'
    #alias myroot='source /Users/andry/dev_area/usr_sh/set_myroot.sh'

    ## ---> command to know the available offline versions

    alias rootsoft='ls ~/dev_area/root/ | grep v6; ls ~/dev_area/root/ | grep master;'

    ## ---> command to load the proper environment for alien

    # alias gclient='source /Users/andry/dev_area/usr_sh/alienroot.sh'

    ##--------------------------------
    ## my shortcuts to AFS directories
    ##--------------------------------

    export AFSCCF=/afs/in2p3.fr/home/a/andryr
}

setup-alias

#--------------------------------
## CMake
## BOOST 
## CLHEP (needed by GEANT 4)
## fftw (added to ROOT)
## GSL (needed to build MATHMORE lib of ROOT)
## GEANT 4
## HepMC (useful for PYTHIA 8)
## LHAPDF 6
## Pythia 8
## Qt5
## Pythia 8
#--------------------------------

## installed with homebrew in /opt/homebrew/

# -----------------------------------------
# Virtual env Python
# (installed via pyenv)
# -----------------------------------------

## execute one of the following lines to activate
## the corresponding virtual environment

# workon alice3.13.5
# workon fidle-3.12.11
# workon lisa3.9.9
# workon lisaconstants
# workon lisanode
# workon pytdi3.9.9

#-------------------------------------------- ONLY ROOT ----------------#


function setup-fidle-env() {
    TEST_PYTHON_VENV="$(which python)"
	VENV_PYTHON_VERSION=3.12.11
    if [[ "${TEST_PYTHON_VENV}" == *"fidle-${VENV_PYTHON_VERSION}"* ]]; then
	    echo "Already using Python virtual env: fidle-${VENV_PYTHON_VERSION}"
    else
	    if [[ "${TEST_PYTHON_VENV}" == *".virtualenvs"* ]]; then
	        deactivate
	    fi
	    workon fidle-${VENV_PYTHON_VERSION}
        echo "Switching to Python virtual env: fidle-${VENV_PYTHON_VERSION}"
    fi
    echo
}    

function setup-xrootd() {
    setup-fidle-env
    ## --> add manually compiled xrootd python bindings to path
    export XROOTD_DIR=/usr/local/xrootd
    export PATH=${XROOTD_DIR}/bin:${PATH}
    export LD_LIBRARY_PATH=${XROOTD_DIR}/lib:${LD_LIBRARY_PATH}    
    export PYTHONPATH=${XROOTD_DIR}/lib/python3.12/site-packages:$PYTHONPATH
}

function setup-root() {

    setup-fidle-env
    setup-xrootd
    PATH=$(brew --prefix openssl@3)/bin:${PATH}
    export PATH

    ## ---> choose version
    
    if [ -n "$1" ]; then
	export ROOT_VERSION=$1
	echo "Setting ROOT soft with ** requested ** $ROOT_VERSION version"
    else
	#export ROOT_VERSION=master
	export ROOT_VERSION=v6-36-02
	echo "Setting ROOT soft with default $ROOT_VERSION version"
    fi

    ## ---> choose where is the needed soft

    unset OFFLINE
    export OFFLINE=/Users/andry/dev_area/root/$ROOT_VERSION
    if [ -d "$OFFLINE" ]; then
	echo '$OFFLINE = '$OFFLINE
    else
	echo 'Could not find $OFFLINE = '$OFFLINE " => Exiting"
	return
    fi

    ## ---> set GEANT 4 environment
    
    # source /usr/local/opt/geant/bin/geant4.sh

    ## ---> add root binaries to path

    unset ROOTSYS

    if [ -f "$OFFLINE/bin/thisroot.sh" ]; then
	source $OFFLINE/bin/thisroot.sh
	echo '$ROOTSYS = '$ROOTSYS
    else
	echo "Could not find $OFFLINE/root/bin/thisroot.sh. ROOT probably not installed. Exiting"
	return
    fi

    ## we may need to add root to DYLD_LIBRARY_PATH
    
    unset DYLD_LIBRARY_PATH
    export DYLD_LIBRARY_PATH=$ROOTSYS/lib

    ## define explicitly the compilers and the linker in accordance with root before running cmake

    export CC=`root-config --cc`
    export CXX=`root-config --cxx`
    export F77=`root-config --f77`
    export LD=`root-config --ld`

    ## ---> fortran compiler and envirsonment needed for geant3

    unset ROOTBUILD
    export ROOTBUILD=`root-config --f77`

    unset PLATFORM
    export PLATFORM=`root-config --arch`
    echo '$PLATFORM = '$PLATFORM

    ## ---> to be able to use PyROOT (still needed ????)
    
    export PYTHONPATH=$ROOTSYS/lib:$PYTHONPATH
}

# --------------------------------
# O2
# --------------------------------

#function setup-o2() {
#    export ALIBUILD_WORK_DIR="$HOME/alice/sw"
#    eval "`alienv shell-helper`"    
#    export LD_LIBRARY_PATH=${LD_LIBRARY_PATH_modshare}:/usr/local/lib:/usr/lib
#}

function setup-alice-env() {
    ALICE_ENV="alice3.13.5"
    TEST_PYTHON_VENV="$(which python)"
    if [[ "${TEST_PYTHON_VENV}" == *"${ALICE_ENV}"* ]]; then
	echo "Already using Python virtual env: ${ALICE_ENV}"
    else
	if [[ "${TEST_PYTHON_VENV}" == *".virtualenvs"* ]]; then
	    deactivate
	fi
	workon ${ALICE_ENV}
	echo "Switching to Python virtual env: ${ALICE_ENV}"
    fi
    echo
}    


function setup-o2-xrootd() {
    ## --> add xrootd compiled via alibuild to library and python path after go-o2 or go-o2sim
    XROOTD_DIR=$(which xrootd-config | sed 's/bin\/xrootd-config//')
    export LD_LIBRARY_PATH=${XROOTD_DIR}/lib:/Users/andry/alice/sw/osx_arm64/JAliEn-ROOT/latest/lib:${LD_LIBRARY_PATH}
    export PYTHONPATH=${XROOTD_DIR}/lib/python3.13/site-packages:$PYTHONPATH
}

function go-o2() {
    setup-alice-env
    unset ALIBUILD_WORK_DIR
    export ALIBUILD_WORK_DIR=/Users/andry/alice/sw
    #cd /Users/andry/alice
    unset MODULES_SHELL
    export MODULES_SHELL=zsh
    alienv enter O2Physics/latest --work-dir ${ALIBUILD_WORK_DIR}
}

function go-o2-ninja() {
    setup-alice-env
    unset ALIBUILD_WORK_DIR
    export ALIBUILD_WORK_DIR=/Users/andry/alice/sw
    #cd /Users/andry/alice
    unset MODULES_SHELL
    export MODULES_SHELL=zsh
    alienv enter O2Physics/latest --work-dir ${ALIBUILD_WORK_DIR} ninja/latest
#    cd ~/alice/sw/BUILD/O2Physics-latest/O2Physics
}


function go-o2-rc() {
    setup-alice-env
    unset ALIBUILD_WORK_DIR
    export ALIBUILD_WORK_DIR=/Users/andry/alice/sw
    unset MODULES_SHELL
    export MODULES_SHELL=zsh
    alienv enter O2Physics/latest-ar-daily-20250805-0000-o2 --work-dir ${ALIBUILD_WORK_DIR}  ## comment to use the latest rc
}


function go-o2sim() {
    setup-alice-env
    unset ALIBUILD_WORK_DIR
    export ALIBUILD_WORK_DIR=/Users/andry/alice/sw
    unset MODULES_SHELL
    export MODULES_SHELL=zsh
    alienv enter O2Physics/latest,EVTGEN/latest-o2,O2DPG/latest,AEGIS/latest-o2 --work-dir ${ALIBUILD_WORK_DIR}
}

function grid-tokens-export() {
    alien.py pwd ## check that GRID tokens are already initialised
    ## --> after a successful "alien.py pwd"
    export $(python3 -c 'from alienpy.global_vars import *; print(f"JALIEN_TOKEN_CERT={CERT_NAMES.token_cert} JALIEN_TOKEN_KEY={CERT_NAMES.token_key}");')
}


# -------------------------------- add identities

function setup-identities() {

    ## ssh-add: the -K and -A flags are deprecated and have been replaced
    ##   by the --apple-use-keychain and --apple-load-keychain
    ##   flags, respectively.
    
    ## based on RSA encryption
    
    nIdRSA=`ssh-add -l | grep "RSA" | wc -l`
    if [ "$nIdRSA" -ne 3 ] 
    then
	ssh-add --apple-use-keychain ~/.ssh/cern_id_rsa
	ssh-add --apple-use-keychain ~/.ssh/new_github_id_rsa
	ssh-add --apple-use-keychain ~/.ssh/gitlab_in2p3_id_rsa
    fi

    ## based on ED25519 encryption
    
    nIdED=`ssh-add -l | grep "ED25519" | wc -l`
    if [ "$nIdED" -ne 1 ] 
    then
	ssh-add --apple-use-keychain ~/.ssh/not_affiliated_gitlab_id_ed25519
    fi

#    echo "Private key identities loaded in ssh-agent :"
#    ssh-add -l
}

setup-identities

# -------------------------------- THE END

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh



