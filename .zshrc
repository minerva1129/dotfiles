# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/Users/Minerva/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# -------------------------------------
# anyenv
# -------------------------------------
if [ -d ${HOME}/.anyenv ] ; then
    export PATH="$HOME/.anyenv/bin:$PATH"
    eval "$(anyenv init -)"
    for D in `ls $HOME/.anyenv/envs`
    do
        export PATH="$HOME/.anyenv/envs/$D/shims:$PATH"
    done

fi

# -------------------------------------
# zplug
# -------------------------------------
# zplugがないときはクローンする
source ~/.zplug/zplug || { curl -fLo ~/.zplug/zplug --create-dirs git.io/zplug && source ~/.zplug/zplug }

zplug "b4b4r07/zplug"  # don't forget to zplug update --self && zplug update

zplug "agnoster/3712874", from:gist

zplug "junegunn/fzf-bin", \
    as:command, \
    from:gh-r, \
    file:fzf

zplug "zsh-users/zsh-syntax-highlighting", nice:10

zplug "zsh-users/zsh-completions"

zplug "zsh-users/zsh-autosuggestions"

zplug "zsh-users/zsh-history-substring-search"

zplug "b4b4r07/enhancd", of:enhancd.sh

zplug 'plugins/brew', from:oh-my-zsh
zplug 'plugins/npm', from:oh-my-zsh

# check コマンドで未インストール項目があるかどうか verbose にチェックし
# false のとき（つまり未インストール項目がある）y/N プロンプトで
# インストールする
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# プラグインを読み込み、コマンドにパスを通す
zplug load --verbose

# -------------------------------------
# 環境変数
# -------------------------------------
export DEFAULT_USER=Minerva
export PAGER=vimpager

# -------------------------------------
# そのた
# -------------------------------------
# enahancdの設定
export ENHANCD_FILTER=fzf
alias cd=cd::cd
# zsh-hisroty-substring-search の設定
zle -N history-substring-search-up
zle -N history-substring-search-down
bindkey '^p' history-substring-search-up
bindkey '^n' history-substring-search-down
# zsh-autosuggestions の設定
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=11'
# 選択中の補完候補に色を付ける
zstyle ':completion:*:default' menu select=2
# dotfilesをdotをつけずに補完する
setopt globdots
# ^rでhistoryのやつをfzfでする 
fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}
zle -N fh
bindkey '^r' fh
# パスだけで自動でcd
setopt auto_cd
# 入力しているコマンド名が間違っている場合にもしかして：を出す。
setopt correct
# ビープを鳴らさない
setopt nobeep
# 色を使う
setopt prompt_subst
# ^dでログアウトしない。
setopt ignoreeof
# バックグラウンドジョブが終了したらすぐに知らせる。 
setopt no_tify
# 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
# シェル間で履歴を共有しない
setopt no_SHARE_HISTORY
# lsの省略
function chpwd() {
  if [ 20 -gt `ls -1 | wc -l` ]; then
    ls -a
  else
    ls
  fi
}

# -------------------------------------
# エイリアス
# -------------------------------------
alias onkeyboard="sudo kextload /System/Library/Extensions/AppleUSBTopCase.kext/Contents/PlugIns/AppleUSBTCKeyboard.kext"
alias offkeyboard="sudo kextunload /System/Library/Extensions/AppleUSBTopCase.kext/Contents/PlugIns/AppleUSBTCKeyboard.kext"
alias remem='du -sx / &> /dev/null & sleep 25 && kill $!'
alias lsa='ls -a'
alias restart='exec $SHELL -l'
alias tmux="TERM=xterm-256color tmux"
