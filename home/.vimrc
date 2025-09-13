set hidden													" allow multiple buffers to be opened
set number													" show line numbers
set cindent tabstop=4 shiftwidth=4							" keep indentation on new line
filetype plugin indent on									" autodetect filetype and set default indenting
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2	" override js indenting
autocmd FileType json setlocal tabstop=2 shiftwidth=2		" override json indenting

"set list
set listchars=tab:▸·,trail:·								" Make tab characters and trailing spaces visible

set laststatus=2											" double status line

hi Folded ctermfg=Black										" fold colors
hi Folded ctermbg=LightBlue
hi SpecialKey ctermfg=235									" tabs and special chars colors

hi TablineFill ctermbg=22 ctermfg=234						" plugin: buftabline
hi Tabline cterm=NONE ctermbg=234 ctermfg=240
hi TabLineSel ctermfg=236 ctermbg=39

let g:buftabline_numbers=1									" show buffer number in tab
let g:buftabline_indicators=1								" show buffer state in tab
"let g:buftabline_separators=1								" draw left line on tabs

:hi MatchParen ctermbg=black cterm=underline				" plugin: matchup

let g:netrw_home = '/home/olivier/.cache/vim'				" location of netrw history file

autocmd BufRead * let &modifiable = !&readonly 				" disallow editing files that are RO
