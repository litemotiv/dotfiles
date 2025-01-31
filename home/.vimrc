set hidden										" allow multiple buffers to be opened
set number										" show line numbers
set cindent tabstop=4 shiftwidth=4				" keep indentation on new line
filetype plugin indent on
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2
autocmd FileType json setlocal tabstop=2 shiftwidth=2

"set list
set listchars=tab:▸·,trail:·					" Make tab characters and trailing spaces visible

set laststatus=2								" double status line
"set statusline=
"set statusline+=%F								" File path 
"set statusline+=\ %y							" File type 
"set statusline+=\ %{&ff}						" File encoding
"set statusline+=\ %{strlen(&fenc)?&fenc:&enc}	" File encoding
"set statusline+=\ %m\ %r						" Modified and readonly flags
"set statusline+=%=line\ %l/%L\ (%p%%)\ col\ %c\ 

"hi statusline ctermbg=0 ctermfg=76				" statusline colors

hi Folded ctermfg=Black							" fold colors
hi Folded ctermbg=LightBlue
hi SpecialKey ctermfg=235						" tabs and special chars colors

hi TablineFill ctermbg=22 ctermfg=234			" plugin: buftabline
hi Tabline cterm=NONE ctermbg=234 ctermfg=240
hi TabLineSel ctermfg=236 ctermbg=39
 
let g:buftabline_numbers=1
let g:buftabline_indicators=1
let g:buftabline_separators=0

let g:netrw_home = '/home/olivier/.cache/vim'	" location of netrw history file
