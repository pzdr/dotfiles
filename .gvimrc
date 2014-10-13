"カーソル上の文字色は文字の背景色にする。
"IME が無効なとき Green
"IME が有効なとき Purple
"にする。
if has('multi_byte_ime')
"  hi Cursor guifg=bg guibg=Green gui=NONE
  hi CursorIM guifg=NONE guibg=Red gui=NONE
endif
set guioptions-=T
set guioptions-=m
set guicursor+=a:blinkon0
set guicursor+=i-ci:block-cursor/iCursor
set visualbell t_vb=
colorscheme badwolf
