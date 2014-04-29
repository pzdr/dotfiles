syntax on
set t_Co=256
set number
set ruler
set title
set hidden
set list
set listchars=tab:»\ ,eol:¬
set whichwrap=b,s,h,s,<,>,[,]
set wildmenu
set wildmode=list:full
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
inoremap jj <ESC>
noremap <Space>h  ^
noremap <Space>l  $
nnoremap <Space>/  *
noremap <Space>m %
noremap k gk
noremap j gj
noremap gk k
noremap gj j
nnoremap : ;
nnoremap ; :
noremap <Down> gj
noremap <UP> gk
noremap ,ev :<C-u>tabnew $HOME/.vimrc<CR>
noremap ,rv :<C-u>source $HOME/.vimrc<CR>
nnoremap <F3> :<C-u>setlocal relativenumber!<CR>

" カーソル行を強調表示しない
set nocursorline
" 挿入モードの時のみ、カーソル行をハイライトする
autocmd InsertEnter,InsertLeave * set cursorline!

let mapleader = ","

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


"binaymode
augroup BinaryXXD
  autocmd!
  autocmd BufReadPre  *.bin,*.exe let &binary =1
  autocmd BufReadPost * if &binary | silent %!xxd -g 1
  autocmd BufReadPost * set ft=xxd | endif
  autocmd BufWritePre * if &binary | %!xxd -r | endif
  autocmd BufWritePost * if &binary | silent %!xxd -g 1
  autocmd BufWritePost * set nomod | endif
augroup END

""" for cygwin
let s:is_windows =  has('win16') || has('win32') || has('win64')
let s:is_cygwin  =  has('win32unix')
let s:is_cui     = !has('gui_running')

if s:is_cygwin
  if &term =~# '^xterm' && &t_Co < 256
    set t_Co=256  " Extend terminal color of xterm
  endif
  if &term !=# 'cygwin'  " not in command prompt
    " Change cursor shape depending on mode
    let &t_ti .= "\e[1 q"
    let &t_SI .= "\e[5 q"
    let &t_EI .= "\e[1 q"
    let &t_te .= "\e[0 q"
  endif
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

NeoBundle 'tpope/vim-fugitive'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'osyo-manga/vim-over'
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

" vim-over
cnoreabb <silent><expr>s getcmdtype()==':' && getcmdline()=~'^s' ? 'OverCommandLine<CR><C-u>%s/<C-r>=get([], getchar(0), '')<CR>' : 's'
nnoremap <Leader>o :OverCommandLine %s/<CR>

filetype plugin indent on

let g:edark_current_line = 1
let g:edark_ime_cursor = 1
let g:edark_insert_status_line = 1
colorscheme badwolf

let g:lightline = {}
let g:lightline.colorscheme = 'hybrid'
"let g:lightline_hybrid_style = "plain"

"source ~/encode.vim
