#!/bin/bash

#################################################
#
#   File Name: mac_init.sh
#   Author: scan
#   Created Time: Wed Jul 24 18:19:56 2019
# 
#################################################


function check_sip(){
	if [[ `/usr/bin/csrutil status|grep disabled|wc -l` -eq 0 ]];then
		echo "sip is enable"
		exit 1
	fi
}

function sudo_nopasswd(){
	uname=`/usr/bin/whoami`
	sudo chmod +w /etc/sudoers	
	if [[ `sudo cat /etc/sudoers|grep "$uname"|wc -l` -eq 0 ]];then
		sudo sh -c "echo $uname ALL=\(ALL\) NOPASSWD: ALL >> /etc/sudoers"
	fi
	
}

function open_sshd(){
	if [[ ! -f '/etc/ssh/ssh_host_rsa_key' ]];then
		sudo ssh-keygen -t rsa -N '' -f  /etc/ssh/ssh_host_rsa_key
	fi
	if [[ ! -f '/etc/ssh/ssh_host_dsa_key' ]];then
		sudo ssh-keygen -t dsa -N '' -f /etc/ssh/ssh_host_dsa_key
	fi
	if [[ ! -f '/etc/ssh/ssh_host_ed25519_key' ]];then
		sudo ssh-keygen -t ed25519 -N '' -f /etc/ssh/ssh_host_ed25519_key
	fi
	if [[ ! -f '/etc/ssh/ssh_host_ecdsa_key' ]];then
		sudo ssh-keygen -t ecdsa -N '' -f /etc/ssh/ssh_host_ecdsa_key
	fi
	sudo /usr/sbin/sshd > /dev/null 2>&1	
}
function start_ssh(){
	launchctl load -w /System/Library/LaunchDaemons/ssh.plist
}

function def_vim(){
if [[ ! -f "$HOME/.vimrc" ]];then
	cat <<"EOF" > $HOME/.vimrc
let g:solarized_termcolors=256
set ts=4
set ruler
syntax on
set tabstop=4
set nobackup
set hlsearch
nmap <C-c> :q!<cr>
nmap <C-z> <esc>
nmap <C-e> :wq<cr>
nmap <space> /
nmap ' $
nmap ; 0

imap <C-w> <esc>:wq<cr>
imap <C-d> <esc>
imap <C-c> <esc>:q!<cr>
imap <C-u> <Up>
imap <C-k> <Down>
imap <C-j> <Left>
imap <C-l> <Right>
imap <C-b> <C-o>b
imap <C-f> <C-o>w
imap <C-v> set paste

set termencoding=utf-8
set encoding=utf-8
set encoding=utf-8 
set termencoding=utf-8 
set fileencoding=utf-8 
set fileencodings=utf-8
EOF

fi
}

function def_bashrc(){
	sudo chmod 777 /etc/bashrc
	sudo cat <<"EOF" > /etc/bashrc
# System-wide .bashrc file for interactive bash(1) shells.
if [ -z "$PS1" ]; then
	return
fi

#PS1='\h:\W \u\$ '
PS1='\[\e[38;05;141m\]\u\[\e[38;05;27m\]@\[\e[38;05;100m\]\h\[\e[38;05;141m\][\t]:\[\e[38;05;230m\]\w\[\e[38;05;27m\]\$\[\e[0m\]'
# Make bash check its window size after a process completes
shopt -s checkwinsize

[ -r "/etc/bashrc_$TERM_PROGRAM" ] && . "/etc/bashrc_$TERM_PROGRAM"
EOF

	sudo chmod 644 /etc/bashrc
}

function def_profile(){
	sudo chmod 777 /etc/profile
	sudo cat <<"EOF" > /etc/profile
# System-wide .profile for sh(1)

if [ -x /usr/libexec/path_helper ]; then
        eval `/usr/libexec/path_helper -s`
fi

if [ "${BASH-no}" != "no" ]; then
        [ -r /etc/bashrc ] && . /etc/bashrc
fi

if [ -d /etc/profile.d ]; then
        for i in /etc/profile.d/*.sh
        do
                if [ -r $i ]; then
                        . $i
                fi
        done
        unset i
fi
EOF
	sudo chmod 644 /etc/profile
	if [ ! -d /etc/profile.d ]; then
		sudo mkdir /etc/profile.d
	fi
	if [ ! -f "/etc/profile.d/alias_all.sh" ]; then
		sudo touch /etc/profile.d/alias_all.sh
		sudo chmod 666 /etc/profile.d/alias_all.sh
		cat <<"EOF" > /etc/profile.d/alias_all.sh	
alias l='ls -l'
alias la='ls -la'
alias lh='ls -lhSr'
alias ll='ls -l'
alias ..="cdl .."
alias ...="cd ../.." 
alias .3="cd ../../.."
alias cd..='cdl ..'
alias h='cd $HOME'
alias dh='df -h'
alias g2u='iconv -f gbk -t utf8 '
alias hg='history |grep '
alias psg='ps -ef|grep'
alias pgl='ping www.google.com.hk'
alias rr='rm -rf '
alias grep='grep -i --color' 
alias lvim="vim -c \"normal '0\""  
alias tf='tail -f '  
alias nos='grep -Ev '\''^(#|$)'\'''
alias kill9='kill -9'
alias pd='ping baidu.com'
alias ipp="dig +short myip.opendns.com @resolver1.opendns.com"
alias dukk="du -sk -- * | sort -n | perl -pe '@SI=qw(K M G T P); s:^(\d+?)((\d\d\d)*)\s:\$1.\" \".\$SI[((length \$2)/3)].\"\t\":e'"
alias duk="du -sh -- * | sort -rn  | perl -e 'sub h{%h=(K=>10,M=>20,G=>30);(\$n,\$u)=shift=~/([0-9.]+)(\D)/;return \$n*2**\$h{\$u}}print reverse sort{h(\$b)<=>h(\$a)}<>;'"
alias filetree="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/ /' -e 's/-/|/'"
EOF
		sudo chmod 644 /etc/profile.d/alias_all.sh
	fi
    if [ ! -f "/etc/profile.d/alias_mac.sh" ]; then
        sudo touch /etc/profile.d/alias_mac.sh
        sudo chmod 666 /etc/profile.d/alias_mac.sh
        cat <<"EOF" > /etc/profile.d/alias_mac.sh  
alias cc='cd ..'
alias cds='echo "`pwd`" > ~/.cdsave'
alias cdb='cd "`cat ~/.cdsave`"'
alias w='cd /Users/"${USER}"/Documents'
alias wl='cd /Users/"${USER}"/Documents;gls --color -l'
alias ww='/usr/bin/w'
alias b='cd /Users/"${USER}"/bin'
alias x='cd /Users/"${USER}"/Downloads'
alias u='cd /Users/"${USER}"/Library/Application\ Support/'
alias xl='cd /Users/"${USER}"/Downloads;gls --color -l'
cdl() { cd "$@" && pwd ; ls -lF; }
alias dus='sudo du -sh '
alias dud='sudo du -sh *'
alias f='sudo dscacheutil -flushcache'
alias fin='sudo find / -name '
alias find='sudo find '
alias finn='sudo find / -name '
alias o='open '
alias v='vim'
alias i='ip'
alias ip='ifconfig |grep inet|grep -v inet6|grep -v  "127.0.0.1"|cut  -d " " -f 2'
[[ -x /usr/local/bin/gls ]] && alias ls='gls --color'
alias nel='netstat -anltp tcp|grep LISTEN'
alias net='netstat -antlp tcp '
alias nlg='netstat -anlt|grep LISTEN|grep'
alias p='ping '
alias rd='rm -rf *.download'
alias srr='sudo rm -rf '
alias scp='sudo scp'
alias ssh='sudo ssh'
alias svi='sudo vim '
alias sdcho='sudo chown '
alias sdlaunchctl='sudo launchctl '
alias sd='sudo '
alias sl='/usr/bin/pmset displaysleepnow'

alias llw='ll | wc -l'
alias ka='killall '
alias lis='sudo lsof -iTCP -sTCP:LISTEN -n -P'
alias sniff="sudo ngrep -d 'en0' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en0 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""
alias dw='defaults write '
alias dr='defaults read '
alias dhcp='sudo networksetup -setdhcp '
alias netlist='networksetup -listallnetworkservices'
alias netset='sudo networksetup -setmanual '

alias lsh='ls -l *.sh 2>/dev/null'
alias lpy='ls -l *.py'
alias lpdf='ls -l *.pdf'
alias ljpg='ls -l *.jp*g'
alias lpng='ls -l *.png'
alias ltxt='ls -l *.txt'
alias lld='ls -l |grep "^d"'
alias llf='ls -l |grep -v "^d"'
alias lm="osascript -e 'tell application \"System Events\"' -e 'key code 12 using {command down, control down}' -e 'end tell'"
alias nelu="netstat -anltp udp|grep ^udp4|awk '{print \$4}'|awk -F '.' '{if(\$2 ~ /^[0-9]+\$/ && NF < 3) print \$2}'"
EOF

	sudo chmod 644 /etc/profile.d/alias_mac.sh
	fi

    if [ ! -f "/etc/profile.d/his_set_mac.sh" ]; then
        sudo touch /etc/profile.d/his_set_mac.sh
        sudo chmod 666 /etc/profile.d/his_set_mac.sh
        cat <<"EOF" > /etc/profile.d/his_set_mac.sh 
export LOGDIR=${HOME}'/logs/'
export HISTFILESIZE=1024000
export HISTSIZE=1024000
export HISTTIMEFORMAT='%F %T  '
#export HISTCONTROL=ignoredups
export HISTCONTROL=ignorespace
export HISTIGNORE='ls:ll:l:pwd'
if [[ ${HOME} == '' ]];then
        export LOGDIR="/var/root/logs/"
        readonly MY_HISFILE_DIR="/var/root/logs/.hisfile/"
else
        export LOGDIR=${HOME}'/logs/'
        readonly MY_HISFILE_DIR="${HOME}/logs/.hisfile/"
fi
readonly MY_HISFILE_FILE="${MY_HISFILE_DIR}""my_his_file.his"
readonly sep_str_his='=#@#='
[[ -d  "${MY_HISFILE_DIR}" ]] || mkdir -p "${MY_HISFILE_DIR}"
OLDPWD=${HOME}

sync_his()
{
    history -a; history -c; history -r
}

prompt_cmd()
{
        his_str=`history 1|awk '{$1="";$3=$3" ";print $0}'`
        his_str_date=`echo "${his_str}"|awk '{print $1" "$2}'`
        if ! grep -q "${his_str_date}" ${MY_HISFILE_FILE};then
        {
                echo "`who am i|awk '{if (NF==6) {ip=$NF} else {ip=\"loaclhost\"} {print ip\"_\"$1\"@\"$2}}'` ${sep_str_his} $OLDPWD ${sep_str_his}$his_str" >> "${MY_HISFILE_FILE}"
        }
        fi
        sync_his
}
readonly PROMPT_COMMAND='prompt_cmd'
#readonly PROMPT_COMMAND="${PROMPT_COMMAND:-:};prompt_cmd"
alias hh="cat $MY_HISFILE_FILE|awk -F '$sep_str_his' '{print FNR\" \"\$3}'"
EOF
		sudo chmod 644 /etc/profile.d/his_set_mac.sh	
	fi
}

function install_brew(){
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

function brew_install(){
	brew cask install osxfuse
	brew install lrzsz
	#brew install vpnc
	brew install dos2unix
	brew install coreutils
	brew install ntfs-3g
	brew install openssl
	brew install gnutls
	brew install telnet
	brew install automake
	brew install vsftpd
	brew install wget
	brew install shadowsocks-libev
	brew install sshfs
	brew install privoxy
	brew install ngrep
	brew install ccat
	brew install htop
	brew install hping
	brew install pkg-config
	brew cask install tuntap
}
check_sip
sudo_nopasswd
open_sshd
start_ssh
def_bashrc
def_vim
def_profile
install_brew
#brew_install
