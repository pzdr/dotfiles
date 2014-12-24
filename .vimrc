" ----------------------------------------
" Utils {{{
function! s:current_git() "{{{
  return unite#util#path2project_directory(getcwd())
endfunction"}}}
function! s:filetype() "{{{
  return get(split(&filetype, '\.'), 0, '')
endfunction"}}}
function! s:complement_delimiter_of_directory(path) "{{{
  return isdirectory(a:path) ? a:path . '/' : a:path
endfunction"}}}
function! s:reltime() "{{{
  return str2float(reltimestr(reltime()))
endfunction"}}}
function! s:on_init() "{{{
  return has('vim_starting') || !exists('s:loaded_vimrc')
endfunction"}}}
function! ToUpperCamel(string) "{{{
  let new_name = []
  for str in split(a:string, '_')
    let str = substitute(str, '^[a-z]\|_\zs[a-z]\C', '\=toupper(submatch(0))', 'g')
    call add(new_name, str)
  endfor
  return join(new_name, '')
endfunction"}}}
"}}}

" ----------------------------------------
" initialize "{{{

"release autogroup in MyAutoCmd
augroup MyAutoCmd
  autocmd!
augroup END

let g:my = {}
" OS
let s:is_windows = has('win16') || has('win32') || has('win64')
let s:is_cygwin  = has('win32unix')
let s:is_mac     = has('mac')
let s:is_unix    = has('unix')
" CUI
let s:is_cui     = !has('gui_running')

" config
let g:my = {}
" user information
let g:my.conf = {
      \ 'initialize': 1
      \ }
let g:my.info = {
      \ 'author':  'Suzuki Tatsuya',
      \ 'email':   'pzdr123456@gmail.com',
      \ 'github':  'pzdr',
      \ }
let g:my.bin = {
      \ 'ctags' : '/usr/local/bin/ctags',
      \ 'git' : executable('hub') ? 'hub' : 'git',
      \ }
let g:my.dir = {
      \ 'neobundle':   expand('~/.vim/bundle'),
      \ 'ctrlp':       expand('~/.vim.trash/ctrlp'),
      \ 'memolist':    expand('~/.memolist'),
      \ 'snippets':    expand('~/.vim/snippet'),
      \ 'swap_dir':    expand('~/.vim.trash/vimswap'),
      \ 'trash_dir':   expand('~/.vim.trash/'),
      \ 'viminfo':     expand('~/.vim.trash/viminfo'),
      \ 'undodir':     expand('~/.vim.trash/undodir'),
      \ 'unite':       expand('~/.vim.trash/unite'),
      \ 'vimref':      expand('~/.vim.trash/vim-ref'),
      \ 'vimfiler':    expand('~/.vim.trash/vimfiler'),
      \ 'vimshell':    expand('~/.vim.trash/vimshell'),
      \ 'neocomplete': expand('~/.vim.trash/neocomplete'),
      \ 'vim-session': expand('~/.vim.trash/vimsession'),
      \ 'evernote':    expand('~/.vim.trash/evernote'),
      \ 'trash':       expand('~/.Trash'),
      \ }
let g:my.ft = {
      \ 'ruby_files':      ['ruby', 'Gemfile', 'haml', 'eruby', 'yaml', 'ruby.rspec'],
      \ 'js_files':        ['javascript', 'coffeescript', 'node', 'typescript'],
      \ 'python_files':    ['python', 'python*'],
      \ 'scala_files':     ['scala'],
      \ 'sh_files':        ['sh'],
      \ 'php_files':       ['php', 'phtml'],
      \ 'c_files':         ['c', 'cpp'],
      \ 'style_files':     ['css', 'scss', 'sass'],
      \ 'markup_files':    ['html', 'haml', 'eruby', 'php', 'xhtml', 'liquid', 'slim'],
      \ 'english_files':   ['markdown', 'help', 'text'],
      \ 'program_files':   ['ruby', 'php', 'python', 'eruby', 'vim', 'javascript', 'coffee', 'scala', 'java', 'go', 'cpp', 'haml', 'rust', 'c', 'slim', 'go'],
      \ 'ignore_patterns': ['vimfiler', 'unite'],
      \ }
"}}}

set runtimepath^=$HOME/.vim
set runtimepath+=$HOME/.vim/after
set t_Co=256

""" show
set number
set ruler
set wrap
set textwidth=0
set colorcolumn=80
set t_vb=
set novisualbell
set showcmd
set noshowmode
set splitbelow
set splitright
scriptencoding utf-8
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,ucs-2le,ucs-2,cp932
" set title
" let &listchars=tab:>.,trail:_,eol:\\,extends:>,precedes:<,nbsp:%
" let &listchars=tab:\|\ ,trail:_,eol:￢,extends:>,precedes:<,nbsp:%
" let &listchars="eol:\u21b5,tab:\|\ ,trail:_,extends:\u00bb,precedes:\u00ab,nbsp:\u00d7"
" let &listchars="tab:\|\ ,extends:\u00bb,precedes:\u00ab,nbsp:\u00d7"
"let &listchars="eol:\u00b6"
set list
set whichwrap=b,s,h,s,<,>,[,]
set wildmenu
set wildmode=longest,list,full
set smartindent
set foldmethod=marker
" set lazyredraw
set timeout timeoutlen=1000 ttimeoutlen=75
set ambiwidth=double

augroup highlightSpaces
    autocmd!
    autocmd ColorScheme * hi ExtraWhiteSpace ctermbg=darkgrey guibg=lightgreen
    autocmd ColorScheme * hi ZenkakuSpace ctermbg=white guibg=white
    autocmd VimEnter,WinEnter,Bufread * call s:syntax_additional()
augroup END

""" search
set ignorecase
set smartcase
set incsearch
set hlsearch
set wrapscan
set nowritebackup
set noswapfile
set nobackup
set clipboard+=unnamed,autoselect
set hlsearch
set expandtab
set shiftwidth=2 tabstop=2 softtabstop=2
set scrolloff=20

""" edit
set shiftround          " '<'や'>'でインデントする際に'shiftwidth'の倍数に丸める
set infercase           " 補完時に大文字小文字を区別しない
set virtualedit=all     " カーソルを文字が存在しない部分でも動けるようにする
set hidden              " バッファを閉じる代わりに隠す（Undo履歴を残すため）
set switchbuf=useopen   " 新しく開く代わりにすでに開いてあるバッファを開く
set showmatch           " 対応する括弧などをハイライト表示する
set matchtime=3         " 対応括弧のハイライト表示を3秒にする
set matchpairs& matchpairs+=<:> " 対応括弧に'<'と'>'のペアを追加
set backspace=indent,eol,start " バックスペースでなんでも消せるようにする
set spelllang=en_gb,cjk
set helplang=en
set smarttab
set smartindent
set history=255
set nrformats& nrformats-=octal nrformats+=alpha
imap <F11> <nop>
set pastetoggle=<F11>
" ペースト時に余計な空白を削除
if has('virtualedit') && &virtualedit =~# '\<all\>'
  nnoremap <expr> p (col('.') >= col('$') ? '$' : '') . 'p'
endif
"""

""" mouse
"set mouse=a
set ttymouse=xterm2
set laststatus=2

" カーソル行を強調表示しない
set nocursorline
" 挿入モードの時のみ、カーソル行をハイライトする
autocmd InsertEnter * set cursorline
autocmd InsertLeave * set nocursorline

" key mapping
let mapleader = ","
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-c> <Esc>
inoremap jj <ESC>
nnoremap <silent> <C-c> :nohlsearch<CR>
noremap <Space>h  ^
noremap <Space>l  $
nnoremap <Space>/  *<C-o>
nnoremap g<Space>/  g*<C-o>
noremap <Space>m %
nnoremap x "_x
nnoremap D "_D
noremap k gk
noremap j gj
noremap gk k
noremap gj j
nnoremap : ;
nnoremap ; :
vnoremap : ;
vnoremap ; :
cnoremap : ;
cnoremap ; :
noremap <Down> gj
noremap <UP> gk
nnoremap <TAB> %
vnoremap <TAB> %
" Ctrl + hjkl でウィンドウ間を移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" Shift + 矢印でウィンドウサイズを変更
nnoremap <S-Left>  <C-w><<CR>
nnoremap <S-Right> <C-w>><CR>
nnoremap <S-Up>    <C-w>-<CR>
nnoremap <S-Down>  <C-w>+<CR>
" command mode
cnoremap <C-a> <Home>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right> 
" make, grep などのコマンド後に自動的にQuickFixを開く
autocmd MyAutoCmd QuickfixCmdPost make,grep,grepadd,vimgrep copen
" QuickFixおよびHelpでは q でバッファを閉じる
autocmd MyAutoCmd FileType help,qf nnoremap <buffer> q <C-w>c

if has('unix') || has('macunix') || has('win32unix')
  noremap <silent> <Leader>ev :<C-u>tabedit $MYVIMRC<CR>
  noremap <silent> <Leader>rv :<C-u>source $MYVIMRC<CR>
elseif has('win32') || has('win64')
  noremap <silent> <Leader>ev :<C-u>tabedit $MYGVIMRC<CR>
  noremap <silent> <Leader>eg :<C-u>tabedit $MYGVIMRC<CR>
  noremap <silent> <Leader>rv :<C-u>source $MYGVIMRC<CR>
endif
nnoremap <F3> :<C-u>setlocal relativenumber!<CR>
nnoremap <special> <Esc>[Z :<C-u>tabn<CR>

" Initialize Neobundle {{{
filetype plugin indent off
"let g:neobundle#types#git#default_protocol = 'https'
let g:neobundle#install_max_processes = 30
if s:on_init()
  set nocompatible
  execute 'set runtimepath+=' . g:my.dir.neobundle . '/neobundle.vim'
  call neobundle#begin(g:my.dir.neobundle)
endif
"}}}

" Neobundle
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundleLazy 'vim-jp/vital.vim', { 'autoload' : {
      \ 'functions' : 'vital#of',
      \ 'commands' : 'Vitalize',
      \ }}
" For asynchronous communication
NeoBundleLazy 'Shougo/vimproc', {
      \ 'autoload' : {
      \   'function_prefix' : 'vimproc',
      \ },
      \ 'build' : {
      \   'mac' : 'make -f make_mac.mak',
      \   'unix' : 'make -f make_unix.mak',
      \ }}

if &t_Co >= 16
  NeoBundle 'itchyny/lightline.vim'
elseif
  set laststatus=2
  set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
endif

if !s:is_windows && s:is_cui
  for s:ch in map(
        \   range(char2nr('a'), char2nr('z'))
        \ + range(char2nr('A'), char2nr('N'))
        \ + range(char2nr('P'), char2nr('Z'))
        \ + range(char2nr('0'), char2nr('9'))
        \ , 'nr2char(v:val)')
    exec 'nmap <ESC>' . s:ch '<M-' . s:ch . '>'
  endfor
  unlet s:ch
  map  <NUL>  <C-Space>
  map! <NUL>  <C-Space>
endif

" neocomplete {{{
NeoBundleLazy 'Shougo/neocomplete.vim', {
      \ "autoload": {"insert": 1}}
" neocompleteのhooksを取得
let s:hooks = neobundle#get_hooks("neocomplete.vim")
" neocomplete用の設定関数を定義。下記関数はneocompleteロード時に実行される
function! s:hooks.on_source(bundle)
  set completeopt-=preview
  "Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
  " Disable AutoComplPop.
  let g:acp_enableAtStartup = 0
  " Use neocomplete.
  let g:neocomplete#enable_at_startup = 1
  " Use smartcase.
  let g:neocomplete#enable_smart_case = 1
  " Set minimum syntax keyword length.
  let g:neocomplete#sources#syntax#min_keyword_length = 4
  let g:neocomplete#sources#omni#min_keyword_length = 4
  let g:neocomplete#auto_completion_start_length = 4
  let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
  " 補完が止まった際に、スキップする長さを短くする
  let g:neocomplete#skip_auto_completion_time = '0.2'
  " 使用する補完の種類を減らす
  " 現在のSourceの取得は `:echo keys(neocomplete#variables#get_sources())`
  " デフォルト: ['file', 'tag', 'neosnippet', 'vim', 'dictionary', 'omni', 'member', 'syntax', 'include', 'buffer', 'file/include']
  let g:neocomplete#sources = {
        \ '_' : ['neosnippet', 'vim', 'omni', 'include', 'buffer', 'file/include']
        \ }

  " 特定のタイミングでのみ使う補完は、直接呼び出すようにする
  inoremap <expr><C-X><C-F>  neocomplete#start_manual_complete('file')
  inoremap <expr><C-X><C-K>  neocomplete#start_manual_complete('dictionary')
  inoremap <expr><C-X>s      neocomplete#start_manual_complete('neosnippet')
  " Plugin key-mappings.
  inoremap <expr><C-g>     neocomplete#undo_completion()
  inoremap <expr><C-l>     neocomplete#complete_common_string()

  " Recommended key-mappings.
  " <CR>: close popup and save indent.
  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  function! s:my_cr_function()
    return neocomplete#close_popup() . "\<CR>"
    " For no inserting <CR> key.
    "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
  endfunction
  " <TAB>: completion.
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><C-y>  neocomplete#close_popup()
  inoremap <expr><C-g>  neocomplete#cancel_popup()

  " Close popup by <Space>.
  "inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

  " autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  " NeoCompleteを有効化
  "  NeoCompleteEnable
endfunction
" }}}

" {{{ vimfiler
NeoBundleLazy "Shougo/vimfiler", {
      \ "depends": ["Shougo/unite.vim"],
      \ "autoload": {
      \   "commands": ["VimFilerTab", "VimFiler", "VimFilerExplorer"],
      \   "mappings": ['<Plug>(vimfiler_switch)'],
      \   "explorer": 1,
      \ }}
nnoremap <Leader>e :VimFilerExplorer<CR>
" close vimfiler automatically when there are only vimfiler open
" autocmd MyAutoCmd BufEnter * if (winnr('$') == 1 && &filetype ==# 'vimfiler') | q | endif
let s:hooks = neobundle#get_hooks("vimfiler")
function! s:hooks.on_source(bundle)
  let g:vimfiler_as_default_explorer = 1
  let g:vimfiler_enable_auto_cd = 1

  " .から始まるファイルおよび.pycで終わるファイルを不可視パターンに
  " 2013-08-14 追記
  let g:vimfiler_ignore_pattern = "\%(^\..*\|\.pyc$\)"

  " vimfiler specific key mappings
  autocmd MyAutoCmd FileType vimfiler call s:vimfiler_settings()
  function! s:vimfiler_settings()
    " ^^ to go up
    nmap <buffer> ^^ <Plug>(vimfiler_switch_to_parent_directory)
    " use R to refresh
    nmap <buffer> R <Plug>(vimfiler_redraw_screen)
    " overwrite C-l
    nmap <buffer> <C-l> <C-w>l
  endfunction
endfunction
" }}}

" Neobundle tcommnet_vim "{{{
NeoBundle 'tomtom/tcomment_vim', { 'autoload' : {
      \ 'commands' : ['TComment', 'TCommentAs', 'TCommentMaybeInline'],
      \ 'functions' : ['tcomment#DefineType'],
      \ }}
"}}}

" {{{ syntastic
NeoBundle 'scrooloose/syntastic'
let g:syntastic_python_checkers = ['pyflakes', 'pep8']

" original http://stackoverflow.com/questions/12374200/using-uncrustify-with-vim/15513829#15513829
function! Preserve(command)
  " Save the last search.
  let search = @/
  " Save the current cursor position.
  let cursor_position = getpos('.')
  " Save the current window position.
  normal! H
  let window_position = getpos('.')
  call setpos('.', cursor_position)
  " Execute the command.
  execute a:command
  " Restore the last search.
  let @/ = search
  " Restore the previous window position.
  call setpos('.', window_position)
  normal! zt
  " Restore the previous cursor position.
  call setpos('.', cursor_position)
endfunction

function! Autopep8()
  call Preserve(':silent %!autopep8 --ignore=E501 -')
endfunction

" Shift + F で自動修正
autocmd FileType python nnoremap <S-f> :call Autopep8()<CR>
" }}} syntastic

" NeoBundleLazy cpp-vim "{{{
NeoBundleLazy 'vim-jp/cpp-vim', {
      \ 'autoload' : {'filetypes' : 'cpp'}
      \ }
"}}}

" NeobundleLazy clang_complete "{{{
"NeoBundleLazy 'Rip-Rip/clang_complete', {
"        \ 'autoload' : {'filetypes' : ['c', 'cpp']}
"        \ }
"}}}

" NeoBundleLazy vim-clang-format "{{{
NeoBundleLazy 'rhysd/vim-clang-format', {
      \ 'autoload' : {'filetypes' : ['c', 'cpp', 'objc']}
      \ }
"}}}

" NeobundleLazy vim-marching "{{{
NeoBundleLazy 'osyo-manga/vim-marching', {
      \ 'depends' : ['Shougo/vimproc.vim', 'osyo-manga/vim-reunions'],
      \ 'autoload' : {'filetypes' : ['c', 'cpp']}
      \ }
"}}}

" NeoBundle neosnippet {{{ 
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
" }}}

" {{{ unite
NeoBundleLazy 'Shougo/unite.vim', {
            \ 'autoload' : {'commands' : [ 'unite' ]}
            \ }
let hooks = neobundle#get('unite.vim')
function! hooks.on_source(bundle)
    let g:unite_enable_start_insert=1
    let g:unite_source_history_yank_enable =1
    let g:unite_source_file_mru_limit = 200
endfunction

nnoremap <silent> ,uy :<C-u>Unite history/yank<CR>
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> ,uu :<C-u>Unite file_mru buffer<CR>
nnoremap <silent> ,uc :<C-u>Unite colorscheme -auto-preview<CR>
" }}}

NeoBundle 'Shougo/neomru.vim'
NeoBundle 'honza/vim-snippets'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'tpope/vim-surround'

" auto_pairs {{{
" [本家](https://github.com/jiangmiao/auto-pairs)
" Lazy loading用に修正済み
NeoBundleLazy 'alpaca-tc/auto-pairs', { 'autoload' : {
      \ 'insert': 1 }}
" ----------------------------------------
let hooks = neobundle#get_hooks('auto-pairs')
function! hooks.on_source(bundle) "{{{
  let g:auto_pairs#map_space = 0
  let g:auto_pairs#map_cr = 0
  let g:auto_pairs = {
        \ '(':')',
        \ '[':']',
        \ '{':'}',
        \ "'":"'",
        \ '"':'"',
        \ '`':'`',
        \ '|' : '|'
        \ }
  let g:auto_pairs#parens = { '{':'}' }
  " let g:auto_pairs#shortcut_toggle = '<M-p>'
  " let g:auto_pairs#shortcut_fast_wrap = '<M-e>'
  " let g:auto_pairs#shortcut_jump = '<M-n>'
  " let g:auto_pairs#shortcut_back_insert = '<M-b>'
  " let g:auto_pairs#fly_mode = 0
endfunction"}}}
function! hooks.on_post_source(bundle) "{{{
  call auto_pairs#try_init()
endfunction"}}}
unlet hooks
" }}}

NeoBundleLazy 'junegunn/vim-easy-align', { 'autoload': {
      \ 'commands' : ['EasyAlign'] }}

" indentLine or vim-indent-guides {{{
if has('conceal')
  NeoBundleLazy 'Yggdroot/indentLine', { 'autoload' : {
        \   'commands' : ['IndentLinesReset', 'IndentLinesToggle'],
        \   'filetypes': g:my.ft.program_files,
        \ }}
  " ----------------------------------------
  nnoremap <Leader>i :<C-U>IndentLinesToggle<CR>
  let hooks = neobundle#get_hooks('indentLine')
  function! hooks.on_source(bundle) "{{{
      let g:indentLine_faster = 1
      let g:indentLine_enabled = 1
      let g:indentLine_color_term = 239
      let g:indentLine_color_gui = '#444444'
      let g:indentLine_fileType = g:my.ft.program_files
      let g:indentLine_char = "\u00bb"
  endfunction"}}}
  function! hooks.on_post_source(bundle) "{{{
      set conceallevel=2
  endfunction"}}}
  unlet hooks
else
  NeoBundleLazy 'nathanaelkane/vim-indent-guides', {
        \ 'autoload': {
        \   'commands': ['IndentGuidesEnable', 'IndentGuidesToggle'],
        \   'filetypes': g:my.ft.program_files,
        \ }}
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   ctermbg=235
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  ctermbg=240
endif
"}}}
"
" {{{ gundo
NeoBundleLazy "sjl/gundo.vim", {
      \ "autoload": {
      \   "commands": ['GundoToggle'],
      \}}
nnoremap <Leader>g :GundoToggle<CR>
" }}}

" {{{ tagbar
NeoBundleLazy 'majutsushi/tagbar', {
      \ "autload": {
      \   "commands": ["TagbarToggle"],
      \ },
      \ "build": {
      \   "mac": "brew install ctags",
      \ }}
if !empty(neobundle#get("tagbar"))
  let g:tagbar_width = 25
  nnoremap <Leader>t :TagbarToggle<CR>
endif
" }}}

" {{{ vim-django-support
" DJANGO_SETTINGS_MODULE を自動設定
NeoBundleLazy "lambdalisue/vim-django-support", {
      \ "autoload": {
      \   "filetypes": ["python", "python3", "djangohtml"]
      \ }}
" }}}

" {{{ jedi-vim
NeoBundleLazy "davidhalter/jedi-vim", {
      \ "autoload": {
      \   "filetypes": ["python", "python3", "djangohtml"],
      \ },
      \ "build": {
      \   "mac": "pip install jedi",
      \   "unix": "pip install jedi",
      \ }}
let s:hooks = neobundle#get_hooks("jedi-vim")
function! s:hooks.on_source(bundle)
  " jediにvimの設定を任せると'completeopt+=preview'するので
  " 自動設定機能をOFFにし手動で設定を行う
  let g:jedi#auto_vim_configuration = 0
  " 補完の最初の項目が選択された状態だと使いにくいためオフにする
  let g:jedi#popup_select_first = 0
  " quickrunと被るため大文字に変更
  let g:jedi#rename_command = '<Leader>R'
  " gundoと被るため大文字に変更 (2013-06-24 10:00 追記）
  "let g:jedi#goto_command = '<Leader>G'
endfunction

autocmd FileType python setlocal omnifunc=jedi#completions
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0

if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif

" let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'
" }}}

"{{{ vim-python-pep8-indent
NeoBundleLazy 'hynek/vim-python-pep8-indent', {
    \ "autoload": {"insert": 1, "filetypes": ["python", "python3", "djangohtml"]}}
"}}}

" {{{ vim-pyenv
" pyenv 処理用に vim-pyenv を追加
" Note: depends が指定されているため jedi-vim より後にロードされる
NeoBundleLazy "lambdalisue/vim-pyenv", {
      \ "depends": ['davidhalter/jedi-vim'],
      \ "autoload": {
      \   "filetypes": ["python", "python3", "djangohtml"]
      \ }}
" }}}

" git
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'airblade/vim-gitgutter'
" let g:gitgutter_sign_added = '✚'
" let g:gitgutter_sign_modified = '➜'
" let g:gitgutter_sign_removed = '✘'
NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'osyo-manga/vim-over'
" Markdown syntax
NeoBundle "godlygeek/tabular"
NeoBundle "joker1007/vim-markdown-quote-syntax"
NeoBundle "rcmdnk/vim-markdown"
let g:vim_markdown_liquid=1
let g:vim_markdown_frontmatter=1
let g:vim_markdown_math=1
au BufRead,BufNewFile *.{txt,text} set filetype=markdown
let g:markdown_fenced_languages = [
      \  'coffee',
      \  'css',
      \  'erb=eruby',
      \  'javascript',
      \  'js=javascript',
      \  'json=javascript',
      \  'cpp',
      \  'ruby',
      \  'python',
      \  'bash=sh',
      \  'sass',
      \  'xml',
      \]
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'kannokanno/previm'
NeoBundle 'h1mesuke/vim-alignta'
" colorscheme
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'cocopon/lightline-hybrid.vim'
NeoBundle 'vim-scripts/twilight'
NeoBundle 'jonathanfilip/vim-lucius'
NeoBundle 'jpo/vim-railscasts-theme'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'cocopon/iceberg.vim'
NeoBundle 'vim-scripts/Wombat'
NeoBundle 'tomasr/molokai'
NeoBundle 'vim-scripts/rdark'
NeoBundle 'pasela/edark.vim'
NeoBundle 'sjl/badwolf'
NeoBundle 'cocopon/colorswatch.vim'
NeoBundle 'git://github.com/vim-scripts/vimcoder.jar'

call neobundle#end()
filetype plugin indent on
"""

" Plugin settings
" ------------------------------------
" t_comment
" ------------------------------------
let g:tcommentMaps = 0
"nmap <C-_> :TComment<CR>
"xmap <C-_> :TComment<CR>
nnoremap <C-_> :TComment<CR>
xnoremap <C-_> :TComment<CR>

""" vim-over
cnoreabb <silent><expr>s getcmdtype()==':' && getcmdline()=~'^s' ? 'OverCommandLine<CR><C-u>%s/<C-r>=get([], getchar(0), '')<CR>' : 's'
nnoremap <Leader>o :OverCommandLine %s/<CR>

""" clang_complete
" コマンドオプション
"let g:clang_user_options = '-std=c++11'
"let g:clang_library_path = '/usr/lib'


" neocomplete.vim と併用して使用する場合は以下の設定も行う
"if !exists('g:neocomplete#force_omni_input_patterns')
"  let g:neocomplete#force_omni_input_patterns = {}
"endif
"let g:neocomplete#force_overwrite_completefunc = 1
"let g:neocomplete#force_omni_input_patterns.c =
"      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
"let g:neocomplete#force_omni_input_patterns.cpp =
"      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
"let g:neocomplete#force_omni_input_patterns.objc =
"      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
"let g:neocomplete#force_omni_input_patterns.objcpp =
"      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'

" clang_complete では自動補完を行わない用に設定
"let g:clang_complete_auto = 0
"let g:clang_auto_select = 0
"""


""" clang marching
" clang コマンドの設定
let g:marching_clang_command = "/usr/bin/clang"

" オプションを追加する場合
let g:marching#clang_command#option = {
      \   "cpp" : "-std=gnu++1y"
      \}

" インクルードディレクトリのパスを設定
let g:marching_include_paths = [
      \   "/usr/lib/gcc/i686-pc-mingw32/4.7.3/include",
      \   "/usr/lib/gcc/i686-pc-mingw32/4.7.3/include/c++"
      \]

" neocomplete.vim と併用して使用する場合は以下の設定を行う
let g:marching_enable_neocomplete = 1

if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif

let g:neocomplete#force_omni_input_patterns.cpp =
      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
"""

""" clang_format
let g:clang_format#style_options = {
      \ 'AccessModifierOffset' : -4,
      \ 'AllowShortIfStatementsOnASingleLine' : 'true',
      \ 'AlwaysBreakTemplateDeclarations' : 'true',
      \ 'Standard' : 'C++11',
      \ 'BreakBeforeBraces' : 'Stroustrup',
      \ }
"""

""" quickrun
let g:quickrun_config = get(g:, 'quickrun_config', {})
" vimproc を使って非同期に実行し，結果を quickfix に出力する
let g:quickrun_config._ = {
      \ 'runner'                    : 'vimproc',
      \ 'runner/vimproc/updatetime' : 100,
      \ 'outputter'                 : 'multi:buffer:quickfix',
      \ 'outputter/buffer/split'    : ''
      \ }

" {{{ lightline.vim
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'gitgutter', 'filename' ], ['ctrlpmark'] ],
      \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'charcode', 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component': {
      \   'lineinfo': "\u2b61 %3l:%-2v",
      \ },
      \ 'component_function': {
      \   'fugitive': 'MyFugitive',
      \   'filename': 'MyFilename',
      \   'fileformat': 'MyFileformat',
      \   'filetype': 'MyFiletype',
      \   'fileencoding': 'MyFileencoding',
      \   'mode': 'MyMode',
      \   'charcode': 'MyCharCode',
      \   'gitgutter': 'MyGitGutter',
      \   'ctrlpmark': 'CtrlPMark',
      \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \ },
      \ 'separator': { 'left': "\u2b80", 'right': "\u2b82" },
      \ 'subseparator': { 'left': "\u2b81", 'right': "\u2b83" },
      \ }

function! MyModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help' && &readonly ? "\u2b64" : ''
endfunction

function! MyFilename()
  let fname = expand('%:t')
  return fname == 'ControlP' ? g:lightline.ctrlp_item :
        \ fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
      let mark = "\u2b60 "  " edit here for cool mark
      let _ = fugitive#head()
      return strlen(_) ? mark._ : ''
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyGitGutter()
  if ! exists('*GitGutterGetHunkSummary')
        \ || ! get(g:, 'gitgutter_enabled', 0)
        \ || winwidth('.') <= 90
    return ''
  endif
  let symbols = [
        \ g:gitgutter_sign_added . ' ',
        \ g:gitgutter_sign_modified . ' ',
        \ g:gitgutter_sign_removed . ' '
        \ ]
  let hunks = GitGutterGetHunkSummary()
  let ret = []
  for i in [0, 1, 2]
    if hunks[i] > 0
      call add(ret, symbols[i] . hunks[i])
    endif
  endfor
  return join(ret, ' ')
endfunction

" https://github.com/Lokaltog/vim-powerline/blob/develop/autoload/Powerline/Functions.vim
function! MyCharCode()
  if winwidth('.') <= 70
    return ''
  endif

  " Get the output of :ascii
  redir => ascii
  silent! ascii
  redir END

  if match(ascii, 'NUL') != -1
    return 'NUL'
  endif

  " Zero pad hex values
  let nrformat = '0x%02x'

  let encoding = (&fenc == '' ? &enc : &fenc)

  if encoding == 'utf-8'
    " Zero pad with 4 zeroes in unicode files
    let nrformat = '0x%04x'
  endif

  " Get the character and the numeric value from the return value of :ascii
  " This matches the two first pieces of the return value, e.g.
  " "<F>  70" => char: 'F', nr: '70'
  let [str, char, nr; rest] = matchlist(ascii, '\v\<(.{-1,})\>\s*([0-9]+)')

  " Format the numeric value
  let nr = printf(nrformat, nr)

  return "'". char ."' ". nr
endfunction

function! MyMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! CtrlPMark()
  if expand('%:t') =~ 'ControlP'
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

let g:ctrlp_status_func = {
      \ 'main': 'CtrlPStatusFunc_1',
      \ 'prog': 'CtrlPStatusFunc_2',
      \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
  let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction

augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost *.c,*.cpp call s:syntastic()
augroup END
function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0
""" }}}

""" markdown
" vim-markdown
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_no_default_key_mappings=1
let g:vim_markdown_math=1

" Previm
let g:previm_enable_realtime = 1
let g:previm_open_cmd = ''
nnoremap [previm] <Nop>
nmap <Space>p [previm]
nnoremap <silent> [previm]o :<C-u>PrevimOpen<CR>
nnoremap <silent> [previm]r :call previm#refresh()<CR>

augroup Markdown
  autocmd!
  autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
  autocmd BufEnter *.markdown let s:updatetime_origin = &updatetime | let &updatetime = 10000
  autocmd BufLeave *.markdown let &updatetime = get(s:, 'updatetime_origin', &updatetime)
augroup END
"""

""" for C++
augroup cpp-path
  autocmd!
  autocmd FileType cpp setlocal path=.,/usr/include,/usr/local/include,/usr/lib/c++/v1,/usr/lib/gcc/i686-pc-mingw32/4.7.3/include/c++
augroup END
"""

" ### binaymode "{{{
augroup BinaryXXD
  autocmd!
  autocmd BufReadPre  *.bin,*.exe let &binary =1
  autocmd BufReadPost * if &binary | silent %!xxd -g 1
  autocmd BufReadPost * set ft=xxd | endif
  autocmd BufWritePre * if &binary | %!xxd -r | endif
  autocmd BufWritePost * if &binary | silent %!xxd -g 1
  autocmd BufWritePost * set nomod | endif
augroup END
"}}}

" colorscheme " {{{ 
" let g:edark_current_line = 1
" let g:edark_ime_cursor = 1
" let g:edark_insert_status_line = 1
" let g:solarized_termcolors=256
" let g:solarized_termtrans=1
" set background=dark
augroup MyColorScheme
  autocmd!
  hi Normal     ctermbg=none     ctermfg=lightgray
  hi Comment    ctermfg=darkgray
  hi LineNr     ctermbg=none     ctermfg=darkgray
  autocmd ColorScheme * hi SpecialKey ctermbg=none ctermfg=12
  autocmd ColorScheme * hi NonText ctermbg=none ctermfg=12
  autocmd ColorScheme * hi FoldColumn ctermbg=none ctermfg=darkgray
  autocmd ColorScheme * hi Folded ctermbg=none ctermfg=darkgray
augroup END
syntax enable
" colorscheme solarized
colorscheme iceberg
" }}}

" My Functions
function! s:syntax_additional()
    let preset = exists('w:syntax_additional')
    if &l:list
        if !preset
            " http://vimwiki.net/?faq%2F4
            let w:syntax_additional = [
            \ matchadd('ZenkakuSpace', '　',0),
            \ matchadd('ExtraWhiteSpace', '\S\+\zs\s\+\ze$',0),
            \ ]
        endif
    elseif preset
        for added in w:syntax_additional
            call matchdelete(added)
        endfor
        unlet added
        unlet w:syntax_additional
    endif
endfunction

"source ~/encode.vim
