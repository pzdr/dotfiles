"release autogroup in MyAutoCmd
augroup MyAutoCmd
    autocmd!
augroup END

syntax on
set runtimepath^=$HOME/.vim
set runtimepath+=$HOME/.vim/after
set shellslash
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
"set fileencodings=iso-2022-jp,utf-8,euc-jp,ucs-2le,ucs-2,cp932
"set title
set list
"set listchars=tab:>.,trail:_,eol:\\,extends:>,precedes:<,nbsp:%
set listchars=tab:\|\ ,trail:_,eol:$,extends:>,precedes:<,nbsp:%
set whichwrap=b,s,h,s,<,>,[,]
set wildmenu
set wildmode=list,full
set smartindent
"set ambiwidth=double

"全角スペースをハイライト表示
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme * call ZenkakuSpace()
        autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
    augroup END
    call ZenkakuSpace()
endif

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
set shiftwidth=4 tabstop=4 softtabstop=4
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
imap <F11> <nop>
set pastetoggle=<F11>
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
inoremap <C-C> <ESC>
inoremap jj <ESC>
nmap <silent> <ESC><ESC> :nohlsearch<CR>
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

if has('unix') || has('macunix') || has('win32unix')
    noremap ,ev :<C-u>tabnew $HOME/.vimrc<CR>
    noremap ,rv :<C-u>source $HOME/.vimrc<CR>
elseif has('win32') || has('win64')
    noremap ,ev :<C-u>tabnew $HOME/_vimrc<CR>
    noremap ,eg :<C-u>tabnew $HOME/_gvimrc<CR>
    noremap ,rv :<C-u>source $HOME/_vimrc<CR>
endif
nnoremap <F3> :<C-u>setlocal relativenumber!<CR>


let mapleader = ","

"" {{{ python include path
"" PATHの自動更新関数
"" | 指定された path が $PATH に存在せず、ディレクトリとして存在している場合
"" | のみ $PATH に加える
"function! IncludePath(path)
"  " define delimiter depends on platform
"  if has('win16') || has('win32') || has('win64')
"    let delimiter = ";"
"  else
"    let delimiter = ":"
"  endif
"  let pathlist = split($PATH, delimiter)
"  if isdirectory(a:path) && index(pathlist, a:path) == -1
"    let $PATH=a:path.delimiter.$PATH
"  endif
"endfunction
"
"" ~/.pyenv/shims を $PATH に追加する
"" これを行わないとpythonが正しく検索されない
"call IncludePath(expand("~/.anyenv/envs/pyenv/shims"))
""""}}}

""" neobundle
if has('vim_starting')
    set nocompatible               " Be iMproved

    " Required:
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
" Required:
call neobundle#begin(expand('~/.vim/bundle/'))
" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

""" for cygwin
let s:is_windows =  has('win16') || has('win32') || has('win64')
let s:is_cygwin  =  has('win32unix')
let s:is_cui     = !has('gui_running')

if s:is_cygwin
    if &term =~# '^xterm' && &t_Co < 256
        set t_Co=256  " Extend terminal color of xterm
    endif
    "  if &term !=# 'cygwin'  " not in command prompt
    "    " Change cursor shape depending on mode
    "    let &t_ti .= "\e[1 q"
    "    let &t_SI .= "\e[5 q"
    "    let &t_EI .= "\e[1 q"
    "    let &t_te .= "\e[0 q"
    "  endif
endif

if &t_Co >= 16
    "NeoBundle 'bling/vim-airline'
    NeoBundle 'itchyny/lightline.vim'

    " setting lightline
    let g:lightline = {
        \ 'colorscheme': 'hybrid'
        \ }

elseif
    set laststatus=2
    set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
    NeoBundle 'molok/vim-smartusline'
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
""" end cygwin

" {{{ neocomplete
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
        \ '_' : ['vim', 'omni', 'include', 'buffer', 'file/include']
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
    inoremap <expr><C-e>  neocomplete#cancel_popup()

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

NeoBundleLazy 'vim-jp/cpp-vim', {
        \ 'autoload' : {'filetypes' : 'cpp'}
        \ }
"NeoBundleLazy 'Rip-Rip/clang_complete', {
"        \ 'autoload' : {'filetypes' : ['c', 'cpp']}
"        \ }
NeoBundleLazy 'rhysd/vim-clang-format', {
        \ 'autoload' : {'filetypes' : ['c', 'cpp', 'objc']}
        \ }
NeoBundleLazy 'osyo-manga/vim-marching', {
        \ 'depends' : ['Shougo/vimproc.vim', 'osyo-manga/vim-reunions'],
        \ 'autoload' : {'filetypes' : ['c', 'cpp']}
        \ }
" {{{ neosnippet
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

NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'tpope/vim-surround'

" {{{ vim-indent-guides
NeoBundle "nathanaelkane/vim-indent-guides"
let g:indent_guides_enable_on_vim_startup = 1 "2013-06-24 10:00 削除
let s:hooks = neobundle#get_hooks("vim-indent-guides")
function! s:hooks.on_source(bundle)
    let g:indent_guides_auto_colors=0
    let g:indent_guides_guide_size = 1
    let g:indent_guides_start_level= 1
    "IndentGuidesEnable " 2013-06-24 10:00 追記
endfunction
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   ctermbg=235
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  ctermbg=240
" }}}

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
nmap <Leader>t :TagbarToggle<CR>
" }}}

" {{{ vim-django-support
" DJANGO_SETTINGS_MODULE を自動設定
NeoBundleLazy "lambdalisue/vim-django-support", {
      \ "autoload": {
      \   "filetypes": ["python", "python3", "djangohtml"]
      \ }}

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
  let g:jedi#goto_command = '<Leader>G'
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
"NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'osyo-manga/vim-over'
" markdown
NeoBundle 'rcmdnk/vim-markdown'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'kannokanno/previm'
NeoBundle 'h1mesuke/vim-alignta'
" colorscheme
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'cocopon/lightline-hybrid.vim'
NeoBundle 'vim-scripts/twilight'
NeoBundle 'jonathanfilip/vim-lucius'
NeoBundle 'jpo/vim-railscasts-theme'
"NeoBundle 'altercation/vim-colors-solarized'
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

""" Unite
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200
nnoremap <silent> ,uy :<C-u>Unite history/yank<CR>
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> ,uu :<C-u>Unite file_mru buffer<CR>
"""

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

""" colorscheme
"let g:edark_current_line = 1
"let g:edark_ime_cursor = 1
"let g:edark_insert_status_line = 1
colorscheme hybrid
"""

""" for lightline.vim
let g:lightline = {
        \ 'colorscheme': 'hybrid',
        \ 'component': {
        \   'readonly': '%{&readonly?"\u2b64":""}',
        \ },
        \ 'separator': { 'left': "\u2b80", 'right': "\u2b82" },
        \ 'subseparator': { 'left': "\u2b81", 'right': "\u2b83" },
        \ }
"let g:lightline_hybrid_style = "plain"
"""

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

""" binaymode
augroup BinaryXXD
    autocmd!
    autocmd BufReadPre  *.bin,*.exe let &binary =1
    autocmd BufReadPost * if &binary | silent %!xxd -g 1
    autocmd BufReadPost * set ft=xxd | endif
    autocmd BufWritePre * if &binary | %!xxd -r | endif
    autocmd BufWritePost * if &binary | silent %!xxd -g 1
    autocmd BufWritePost * set nomod | endif
augroup END
"""

"source ~/encode.vim
