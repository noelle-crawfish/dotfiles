" Vim Plug
call plug#begin()

Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
Plug 'fxn/vim-monochrome'

call plug#end()

" General requirements
filetype off
set expandtab
set nocompatible
set backspace=indent,eol,start
set tabstop=2 
set softtabstop=2
set autoindent
" Search / Completion
set wildmenu
set hlsearch
set ignorecase
set smartcase

" Filetype recognition
filetype off

" Colors
syntax on
colorscheme monotone

" Statusline / Numbers
set laststatus=2
set statusline=
set statusline+=%#Function#
set statusline+=\ %*
set statusline+=\ <<
set statusline+=\ %f\ %*
set statusline+=\ >>
set statusline+=\ %m
set statusline+=%#keyword#\ %F
set statusline+=%=
set statusline+=\ <<
set statusline+=\ %l/%L
set statusline+=\ ::
set statusline+=\ %p
set statusline+=\ >>

set number
set numberwidth=5
highlight clear LineNr
highlight clear SignColumn
highlight LineNr ctermfg=238

" Keybindings
nmap <C-n> :NERDTreeToggle<CR>

" Hexmode
nnoremap <C-H> :Hexmode<CR>
inoremap <C-H> <Esc>:Hexmode<CR>
vnoremap <C-H> :<C-U>Hexmode<CR>

command -bar Hexmode call ToggleHex()
function ToggleHex()
  let l:modified=&mod
  let l:oldreadonly=&readonly
  let &readonly=0
  let l:oldmodifiable=&modifiable
  let &modifiable=1
  if !exists("b:editHex") || !b:editHex
    " save old options
    let b:oldft=&ft
    let b:oldbin=&bin
    " set new options
    setlocal binary " make sure it overrides any textwidth, etc.
    silent :e " this will reload the file without trickeries
              "(DOS line endings will be shown entirely )
    let &ft="xxd"
    " set status
    let b:editHex=1
    " switch to hex editor
    %!xxd
  else
    " restore old options
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    " set status
    let b:editHex=0
    " return to normal editing
    %!xxd -r
  endif
  " restore values for modified and read only state
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfunction

set shiftwidth=2
