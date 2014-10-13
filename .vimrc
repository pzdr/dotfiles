syntax on
set runtimepath^=$HOME/.vim
set runtimepath+=$HOME/.vim/after
set shellslash
set t_Co=256
set number
set ruler
"set title
set hidden
set list
"set listchars=tab:≫\ ,eol:￢
set listchars=tab:^\ ,eol:\
set whichwrap=b,s,h,s,<,>,[,]
set wildmenu
set wildmode=list,full
set smartindent
set ignorecase
set wrapscan
set noswapfile
set nobackup
set clipboard+=unnamed,autoselect
set hlsearch
set expandtab
set shiftwidth=2 tabstop=2 softtabstop=2
set scrolloff=20
set backspace=indent,eol,start
set showmatch
set showcmd
set showmode
set mouse=a
set ttymouse=xterm2
set laststatus=2

" key mapping
inoremap <C-C> <ESC>
inoremap jj <ESC>
noremap <Space>h  ^
noremap <Space>l  $
nnoremap <Space>/  *<C-o>
nnoremap g<Space>/  g*<C-o>
noremap <Space>m %
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
if has('unix') || has('macunix') || has('win32unix')
  noremap ,ev :<C-u>tabnew $HOME/.vimrc<CR>
  noremap ,rv :<C-u>source $HOME/.vimrc<CR>
elseif has('win32') || has('win64')
  noremap ,ev :<C-u>tabnew $HOME/_vimrc<CR>
  noremap ,eg :<C-u>tabnew $HOME/_gvimrc<CR>
  noremap ,rv :<C-u>source $HOME/_vimrc<CR>
endif
nnoremap <F3> :<C-u>setlocal relativenumber!<CR>

" カーソル行を強調表示しない
set nocursorline
" 挿入モードの時のみ、カーソル行をハイライトする
autocmd InsertEnter,InsertLeave * set cursorline!

let mapleader = ","

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

NeoBundleLazy 'vim-jp/cpp-vim', {
            \ 'autoload' : {'filetypes' : 'cpp'}
            \ }
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
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
"""

"------------------------------------
" neocomplete
"------------------------------------
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
  " return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

" Close popup by <Space>.
inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"""

""" colorscheme
let g:edark_current_line = 1
let g:edark_ime_cursor = 1
let g:edark_insert_status_line = 1
colorscheme badwolf
"""

""" for lightline.vim
let g:lightline = {
      \ 'colorscheme': 'wombat',
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
    autocmd FileType cpp setlocal path=.,/usr/include,/usr/local/include,/usr/lib/c++/v1
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
