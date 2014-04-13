# Created by newuser for 5.0.2

## 基本設定 {{{
# http://yuyunko.hatenablog.com/entry/20101112/1289551129

# PAGER
export PAGER=lv

# LANG 設定
export LANG=ja_JP.UTF-8
case ${UID} in
0)
LANG=C
;;
esac
# }}}
#{{{ PATH設定
if [ -d "$HOME/bin" ] ; then
	PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/bin/scripts" ] ; then
	PATH="$HOME/bin/scripts:$PATH"
fi
# }}}
#######################################################################################################
###{{{ 外観に関する設定
# 色の読み込み
autoload -Uz colors
colors

# 色の定義
local DEFAULT=$'%{\e[m%}'
local RED=$'%{\e[1;31m%}'
local GREEN=$'%{\e[1;32m%}'
local YELLOW=$'%{\e[1;33m%}'
local BLUE=$'%{\e[1;34m%}'
local PURPLE=$'%{\e[1;35m%}'
local LIGHT_BLUE=$'%{\e[1;36m%}'
local WHITE=$'%{\e[1;37m%}'

# ビープ音を鳴らさないようにする
setopt NO_beep

# エスケープシーケンスを通すオプション
setopt prompt_subst
# プロンプトの設定 1 ランダムに色が変わる
# PROMPT=$'%{\e[$[32+$RANDOM % 5]m%}%U%B$HOST'"{%n}%b%%%{\e[m%}%u "
# RPROMPT=$'%{\e[33m%}[%~]%{\e[m%}'

# プロンプ卜の設定 2 rootとその他で色を変えている
case ${UID} in
	0)
		PROMPT="%{$fg_bold[green]%}%m%{$fg_bold[red]%}#%{$reset_color%} "
		PROMPT2="%{$fg[magenta]%}%_%{$reset_color%}%{$fg_bold[white]%}>>%{$reset_color%} "
		;;
	*)
		PROMPT="%{$fg_bold[cyan]%}%m%{$fg_bold[white]%}%%%{$reset_color%} "
		PROMPT2="%{$fg[magenta]%}%_%{$reset_color%}%{$fg_bold[white]%}>>%{$reset_color%} "
		;;
esac
# 右プロンプトに現在地を表示。これのおかげで入力位置がウロウロしない。
RPROMPT="%{$fg_bold[white]%}[%{$reset_color%}%{$fg[cyan]%}%~%{$reset_color%}%{$fg_bold[white]%}]%{$reset_color%}"

# setopt correctしてるときに使われるプロンプト。
SPROMPT="%{$fg_bold[red]%}correct%{$reset_color%}: %R -> %r ? "

# 'dircolors -p'で出力されるものに手を加えて保存したものを読み込んでる。
if [ -f ~/.dir_colors ]; then
	eval `dircolors -b ~/.dir_colors`
fi

# コマンドを実行するときに右プロンプトを消す。他の端末等にコピペするときに便利。
setopt transient_rprompt

# コマンドラインでも # 以降をコメントと見なす
setopt interactive_comments

# 補完候補もLS_COLORSに合わせて色づけ。
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# }}}
#######################################################################################################
###{{{ 補完に関する設定
# 補完を有効にするために自分をsource
# source ~/.zshrc

# 自動補完
autoload -Uz compinit
compinit

# 補完のときプロンプトの位置を変えない
setopt always_last_prompt

# ディレクトリ名を入力するとそこに移動出来る。 'cd'を省略出来るわけだが、癖で打ってしまうので正直あまり恩恵は受けていない。
setopt auto_cd

# 移動した場所を記録し、cd -[TAB] で以前移動したディレクトリの候補を提示してくれて、その番号を入力することで移動出来るようになる。
setopt auto_pushd

# auto_pushdで重複するディレクトリは記録しないようにする。
setopt pushd_ignore_dups

# コマンドのスペルミスを指摘して予想される正しいコマンドを提示してくれる。このときのプロンプトがSPROMPT。
setopt correct

# 補完候補を表示するときに出来るだけ詰めて表示。
setopt list_packed

#ドットファイルにマッチさせるために先頭に'.'を付ける必要がなくなる。
# setopt glog_dots

# aliasを展開して補完。
# setopt complete_aliases

# 補完候補が複数ある時に、一覧表示する
setopt auto_list

#  auto_list の補完候補一覧で、ls -F のようにファイルの種別をマーク表示
setopt list_types

# 補完キー（Tab, Ctrl+I) を連打するだけで順に補完候補を自動で補完する
setopt auto_menu

# コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt magic_equal_subst

#  複数のリダイレクトやパイプなど、必要に応じて tee や cat の機能が使われる
setopt multios

# {a-c} を a b c に展開する機能を使えるようにする
setopt brace_ccl

# カッコの対応などを自動的に補完する
setopt auto_param_keys

# ファイル名で , ~, ^ の 3 文字を正規表現として扱う
setopt extended_glob

# サスペンド中のプロセスと同じコマンド名を実行した場合はリジュームする
setopt auto_resume

#  rm * などの際、本当に全てのファイルを消して良いかの確認しないようになる
setopt rm_star_silent

#  for, repeat, select, if, function などで簡略文法が使えるようになる
setopt short_loops

#  コマンドラインがどのように展開され実行されたかを表示するようになる
# setopt xtrace

# ディレクトリの最後のスラッシュを自動で削除する
setopt autoremoveslash

# シンボリックリンクは実体を追うようになる
# setopt chase_links

# コマンドにsudoを付けてもきちんと補完出来るようにする。Ubuntuだと/etc/zsh/zshrcで設定されている。
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# 大文字・小文字を区別しないで補完出来るようにするが、大文字を入力した場合は区別する。
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# 補完候補を矢印キーなどで選択出来るようにする。'select=3'のように指定した場合は、補完候補が3個以上ある時に選択出来るようになる。
zstyle ':completion:*:default' menu select

# zstyleによる補完設定
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format $YELLOW'%d'$DEFAULT
zstyle ':completion:*:warnings' format $RED'No matches for:'$YELLOW' %d'$DEFAULT
zstyle ':completion:*:descriptions' format $YELLOW'completing %B%d%b'$DEFAULT
zstyle ':completion:*:corrections' format $YELLOW'%B%d '$RED'(errors: %e)%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'
# グループ名に空文字列を指定すると，マッチ対象のタグ名がグループ名に使われる。
# したがって，すべての マッチ種別を別々に表示させたいなら以下のようにする
zstyle ':completion:*' group-name ''

# 予測変換を行うかどうか
# autoload -U predict-on
# predict-on
# }}}
#######################################################################################################
###{{{ 履歴(history)に関する設定
# コマンド履歴を保存するファイル名。
HISTFILE=~/.zsh/.zsh_histfile

# 記憶される履歴の数。
HISTSIZE=10000

# 保存される履歴の数。設定によってはHISTSIZEより大きくないとまずいらしい。彷徨うと桁が二つぐらい大きい値を設定している人もいるが、とりあえずHISTSIZEと同じにしておく。
SAVEHIST=100000

# rootは履歴を保存しない。
if [ $UID = 0 ]; then
	unset HISTFILE
	SAVEHIST=0
fi

# 履歴を複数端末間で共有する。
setopt share_history

# 複数の zsh を同時に使う時など history ファイルに上書きせず追加する
setopt append_history

# 重複するコマンドが記憶されるとき、古い方を削除する。
setopt hist_ignore_all_dups

# 直前のコマンドと同じ場合履歴に追加しない。
setopt hist_ignore_dups

# 重複するコマンドが保存されるとき、古い方を削除する。
setopt hist_save_no_dups

#  zsh の開始・終了時刻をヒストリファイルに書き込む
setopt extended_history

#  コマンドラインの先頭がスペースで始まる場合ヒストリに追加しない
setopt hist_ignore_space

#  ヒストリを呼び出してから実行する間に一旦編集できる状態になる
setopt hist_verify

# apt-getやdpkgなどのキャッシュ
if [ -d ~/.zsh/cache ]; then
    zstyle ':completion:*' use-cache yes
    zstyle ':completion:*' cache-path ~/.zsh/cache
fi


# }}}
#######################################################################################################
###{{{ キーバインド
# Vimを使っているので頑張ってVi風のキーバインドに。
#bindkey -v
bindkey -e

# bindkey -v でもコマンドラインスタック使う
#bindkey 'eq' push-line

# 補完候補のメニュー選択で、矢印キーの代わりにhjklで移動出来るようにする。
zmodload zsh/complist
#bindkey -M menuselect 'h' vi-backward-char
#bindkey -M menuselect 'j' vi-down-line-or-history
#bindkey -M menuselect 'k' vi-up-line-or-history
#bindkey -M menuselect 'l' vi-forward-char


# 途中までコマンドを打っていて、これ前も入力したと思ったときに、Ctrl-Pで補完してくれる。さらに押せばより古いコマンドで補完。やっぱりさっきの、というときはCtrl-nで戻る。
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "bindkey" history-beginning-search-backward-end
bindkey "Created" history-beginning-search-forward-end

# }}}
#######################################################################################################
###{{{ alias
# それぞれの環境に合わせてaliasを設定
case "${OSTYPE}" in
	freebsd*|darwin*)
		alias ls='ls -G'
		;;
	linux*)
		alias ls='ls --color=auto'
		alias grep='grep --color=auto'
		;;
	cygwin*)
		alias gvim='cygstart D:\\App\\vim74\\gvim.exe'
                alias ifconfig="cocot ipconfig"
                alias ping="cocot ping"
                alias arp="cocot arp"
                alias nslookup="cocot nslookup"
                alias traceroute="cocot tracert"
                alias route="cocot route"
                alias netstat="cocot netstat"
		;;
esac
# case `uname` in
#     Linux)
#         alias ls='ls --color=auto'
#         ;;
#     Darwin|FreeBSD)
#         alias ls='ls -GvF'
#         ;;
# esac
alias -g L='| $PAGER'
alias -g G='| grep'
alias -g V='| vim -R -'

alias ll='ls -l'
alias la='ls -a'
alias lla='ls -al'
# alias lla='ls -a -l | lv'


# }}}
#######################################################################################################
###{{{ function
# cdしたらlsするのが癖だから。
# function cd() {builtin cd $@ && ls -v -F --color=auto}
# function cd() {builtin cd $@ && ls -v -F }
# これも、cdしたらlsしてくれるが、こっちのほうがauto_cdの場合でもlsしてくれるのでこっちで。
# function chpwd() { ls -v -F --color=auto }
function chpwd() { ls -F }

# 'google ほげほげ'ですぐに検索。
function google() {
local str opt
if [ $ != 0 ]; then
	for i in $*; do
		str="$str+$i"
	done
	str=`echo $str | sed 's/^\+//'`
	opt='search?num=50&hl=ja&lr=lang_ja'
	opt="${opt}&q=${str}"
fi
w3m http://www.google.co.jp/$opt
}

# w3mでALC検索
function alc() {
if [ $ != 0 ]; then
	w3m "http://eow.alc.co.jp/$*/UTF-8/?ref=sa"
else
	w3m "http://www.alc.co.jp/"
fi
}

# ゴミ箱の実装 ~/.trashがゴミ箱の場所
# function rm() {
# if [ -d ~/.trash ]; then
#     local DATE=`date "+%y%m%d-%H%M%S"`
#     mkdir ~/.trash/$DATE
#     for i in $@; do
#         if [ -e $i ]; then
#             mv $i ~/.trash/$DATE/
#         else 
#             echo "$i : not found"
#         fi
#     done
# else
#     /bin/rm $@
# fi
# }

# C-^ で一つ上のディレクトリへ
function cdup() {
echo
cd ..
zle reset-prompt
}
zle -N cdup
bindkey '' cdup

# キーバインドがviの時に，ノーマルモードとインサートモードの状態を状況に応じて表示
readuntil () {
	typeset a
	while [ "$a" != "$1" ]
	do
		read -E -k 1 a
	done
}

#
# If the $SHOWMODE variable is set, displays the vi mode, specified by
# the $VIMODE variable, under the current command line.
# 
# Arguments:
#
#   1 (optional): Beyond normal calculations, the number of additional
#   lines to move down before printing the mode.  Defaults to zero.
#
showmode() {
	typeset movedown
	typeset row

	# Get number of lines down to print mode
	movedown=$(($(echo "$RBUFFER" | wc -l) + ${1:-0}))

	# Get current row position
	echo -n "\e[6n"
	row="${${$(readuntil R)#*\[}%;*}"

	# Are we at the bottom of the terminal?
	if [ $((row+movedown)) -gt "$LINES" ]
	then
		# Scroll terminal up one line
		echo -n "\e[1S"

		# Move cursor up one line
		echo -n "\e[1A"
	fi

	# Save cursor position
	echo -n "\e[s"

	# Move cursor to start of line $movedown lines down
	echo -n "\e[$movedown;E"

	# Change font attributes
	echo -n "\e[1m"

	# Has a mode been set?
	if [ -n "$VIMODE" ]
	then
		# Print mode line
		echo -n "-- $VIMODE -- "
	else
		# Clear mode line
		echo -n "\e[0K"
	fi

	# Restore font
	echo -n "\e[0m"

	# Restore cursor position
	echo -n "\e[u"
}

clearmode() {
	VIMODE= showmode
}

#
# Temporary function to extend built-in widgets to display mode.
#
#   1: The name of the widget.
#
#   2: The mode string.
#
#   3 (optional): Beyond normal calculations, the number of additional
#   lines to move down before printing the mode.  Defaults to zero.
#
makemodal () {
	# Create new function
	eval "$1() { zle .'$1'; ${2:+VIMODE='$2'}; showmode $3 }"

	# Create new widget
	zle -N "$1"
}

# Extend widgets
makemodal vi-add-eol           INSERT
makemodal vi-add-next          INSERT
makemodal vi-change            INSERT
makemodal vi-change-eol        INSERT
makemodal vi-change-whole-line INSERT
makemodal vi-insert            INSERT
makemodal vi-insert-bol        INSERT
makemodal vi-open-line-above   INSERT
makemodal vi-substitute        INSERT
makemodal vi-open-line-below   INSERT 1
makemodal vi-replace           REPLACE
makemodal vi-cmd-mode          NORMAL

unfunction makemodal

# どの環境でもクリップボードにコピー(macではpbcopy linuxではxselが必要)
# 使い方
# % vim mail.txt    # vim でメールを書く
# % cat mail.txt C  # メールの内容をクリップボードにコピーする
# INPUT.txt のうち 10から15行目をクリップボードにコピーする
# % sed -n '10,15p' INPUT.txt C
if which pbcopy >/dev/null 2>&1 ; then 
	# Mac  
	alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then 
	# Linux
	alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then 
	# Cygwin 
	alias -g C='| putclip'
fi


# auto-fu.zsh の設定
# source ~/.zsh/auto-fu.zsh
# zle-line-init () {auto-fu-init;}; zle -N zle-line-init
# zstyle ':completion:*' completer _oldlist _complete _match _ignored _approximate
# auto-fu.zsh での動作をちょっと変えるパッチ
# delete unambiguous prefix when accepting line
# function afu+delete-unambiguous-prefix () {
#     afu-clearing-maybe
#     local buf; buf="$BUFFER"
#     local bufc; bufc="$buffer_cur"
#     [[ -z "$cursor_new" ]] && cursor_new=-1
#     [[ "$buf[$cursor_new]" == ' ' ]] && return
#     [[ "$buf[$cursor_new]" == '/' ]] && return
#     ((afu_in_p == 1)) && [[ "$buf" != "$bufc" ]] && {
#         there are more than one completion candidates
#         zle afu+complete-word
#         [[ "$buf" == "$BUFFER" ]] && {
#             the completion suffix was an unambiguous prefix
#             afu_in_p=0; buf="$bufc"
#         }
#         BUFFER="$buf"
#         buffer_cur="$bufc"
#     }
# }
# zle -N afu+delete-unambiguous-prefix
# function afu-ad-delete-unambiguous-prefix () {
#     local afufun="$1"
#     local code; code=$functions[$afufun]
#     eval "function $afufun () { zle afu+delete-unambiguous-prefix; $code }"
# }
# afu-ad-delete-unambiguous-prefix afu+accept-line
# afu-ad-delete-unambiguous-prefix afu+accept-line-and-down-history
# afu-ad-delete-unambiguous-prefix afu+accept-and-hold




# 起動時にscreen起動
# ubuntuの場合 $TERM = screen-bce
case "${OSTYPE}" in
	freebsd*|darwin*)
		if [ $TERM != "screen" ]; then
			exec screen -S main -xRR
		fi
			;;
	linux*)
		if [ $TERM != "screen-bce" ]; then
			exec byobu -S main -xRR
		fi
			;;
esac
# case "${OSTYPE}" in
#     freebsd*|darwin*)
#         if [ $TERM != "screen" ]; then
#             exec screen -U -D -RR
#         fi
#             ;;
#     linux*)
#         if [ $TERM != "screen-bce" ]; then
#             exec byobu -U -D -RR
#         fi
#             ;;
# esac
# }}}
#######################################################################################################
#{{{ 個人用設定ファイルがあればそれを読み込む
if [ -e ~/.zshrc_private ]; then
	source ~/.zshrc_private
fi

# }}}
