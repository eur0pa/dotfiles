## <paths>
#
export GOPATH=${HOME}/go
export MSF_PATH=${HOME}/pentest/metasploit
export MSF_DATABASE_CONFIG=${MSF_PATH}/config/database.yml
export PATH=${GOPATH}/bin:${HOME}/data/bin:$MSF_PATH:$PATH
#
### </paths>



### env
#
export EDITOR="vim"
export VISUAL="vim"
export SSH_KEY_PATH="~/.ssh/rsa_id"
export LC_ALL=en_US.utf-8
export LANG="$LC_ALL"
# Colors
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
#export GREP_COLOR="4;31"
#
#export PYTHONWARNINGS="ignore"
export PATH="/usr/local/opt/mysql-client/bin:$PATH"
###



### <slimzsh>
#
source "$HOME/.slimzsh/slim.zsh"
source "$HOME/.slimzsh/plugins/clipboard.zsh"
source "$HOME/.slimzsh/plugins/history-substring-search.zsh"
source "$HOME/.slimzsh/plugins/copybuffer.plugin.zsh"   # ctrl+o to clip commandline
source "$HOME/.slimzsh/plugins/copydir.plugin.zsh"      # copydir to clip cwd
source "$HOME/.slimzsh/plugins/cp.plugin.zsh"           # cpv to rsync
source "$HOME/.slimzsh/plugins/copyfile.plugin.zsh"     # copyfile to clip file contents
source "$HOME/.slimzsh/plugins/copyfilepath.plugin.zsh" # copyfile to clip file path
source "$HOME/.slimzsh/plugins/dircycle.plugin.zsh"     # ctrl+shift+left/right to cycle directories
source "$HOME/.slimzsh/plugins/extract.plugin.zsh"      # universal archive extractor
source "$HOME/.slimzsh/plugins/rsync.plugin.zsh"        # rsync aliases
source "$HOME/.slimzsh/plugins/safe-paste.plugin.zsh"   # removes CRLF from pastes
source "$HOME/.slimzsh/plugins/urltools.plugin.zsh"     # urlencode
source "$HOME/.slimzsh/plugins/jsontools.plugin.zsh"    # json
#
### </slimzsh>

### <iterm2>
#
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
#
### </iterm2>

###
# <zsh>
zmodload zsh/terminfo

# history search
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '\e[H' beginning-of-line
bindkey '\e[F' end-of-line 
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# cd ../
zstyle ':completion:*' special-dirs true

# zmv cmdlet
autoload -U zmv

# cmdline edit
autoload -U edit-command-line
zle -N edit-command-line
# ctrk+e x
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line
# ESC v
#bindkey -M vicmd v edit-command-line

# custom sudo prompt
#export SUDO_PROMPT=$(print -P '%F{red}%B[sudo]%b %F{yellow}\uE0A2%f ')

# term
export TERM=xterm-256color
#
### </zsh>



### <jvm>
#
#export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=gasp -Dswing.aatext=true"
#export JAVA_FONTS="/usr/share/fonts/truetype"
#
### </jvm>



### load aliases
#
source ~/.zsh_aliases
#
###

. /usr/local/bin/env_parallel.zsh
