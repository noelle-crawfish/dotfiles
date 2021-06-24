#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias hy='history'
alias rot13='tr a-zA-Z n-za-mN-ZA-M'
alias scopy='flatpak run org.adi.Scopy'
alias gofish='cd ~/fishing/'

PS1="[\u@\h \w] $()"

export QSYS_ROOTDIR="/home/crawfish/intelFPGA_lite/20.1/quartus/sopc_builder/bin"
