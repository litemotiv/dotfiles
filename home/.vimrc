set hidden                                      " allow multiple buffers to be opened
set number                                      " show line numbers
set cindent expandtab tabstop=4 shiftwidth=4    " keep indentation on new line

set list
set listchars=tab:▸·,trail:·                    " Make tab characters and trailing spaces visible

set laststatus=2                                " double status line
set statusline=
set statusline+=%F                              " File path 
set statusline+=\ %y                            " File type 
set statusline+=\ %{&ff}                        " File encoding
set statusline+=\ %{strlen(&fenc)?&fenc:&enc}   " File encoding
set statusline+=\ %m\ %r                        " Modified and readonly flags
set statusline+=%=line\ %l/%L\ (%p%%)\ col\ %c\ 

hi statusline ctermbg=0 ctermfg=76              " statusline colors

hi Folded ctermfg=Black                         " fold colors
hi Folded ctermbg=LightBlue
