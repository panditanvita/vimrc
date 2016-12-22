" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8
" disable vi compatibility
set nocompatible


" Vundle
filetype off
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'chriskempson/base16-vim'
Plugin 'powerline/fonts'
Plugin 'vim-airline/vim-airline'
Plugin 'mhinz/vim-startify'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'sheerun/vim-polyglot'
Plugin 'arecarn/vim-crunch'
Plugin 'Valloric/YouCompleteMe'
Plugin 'tpope/vim-sensible'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'rhysd/vim-clang-format'
Plugin 'airblade/vim-gitgutter'
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" airline customization
let g:airline_powerline_fonts=1
let g:airline_theme='base16_tomorrow'
let g:Powerline_symbols='fancy'
let g:airline_section_a = airline#section#create(['mode'])

" Install OmniCppComplete like described on http://vim.wikia.com/wiki/C++_code_completion
" This offers intelligent C++ completion when typing ‘.’ ‘->’ or <C-o>
" Load standard tag files
set tags+=~/.vim/tags/cpp
set tags+=~/.vim/tags/gl
set tags+=~/.vim/tags/sdl
set tags+=~/.vim/tags/qt4

let $VIMRC = '~/.vimrc'   " for portability

set t_Co=256
syntax on              " turn syntax highlighting on
set textwidth=80          " wrap lines at 80 chars
" turn line numbers on
set number
" highlight matching braces
set showmatch
" enable mouse
if has('mouse')
    set mouse=a
endif
" hide mouse after chars typed
set mousehide
" open split buffer on bottom/right
set splitbelow
set splitright
" enable filetype detection
filetype on
set hid                   " don't auto-remove hidden buffers
set history=1000          " 1000 commands stored in history
set hlsearch              " highlight all search pattern matches
set incsearch             " incremental search
set isk+=%,#              " none of these should be word dividers
set linebreak             " enable smart linebreaking
set matchtime=0           " prevent matching delay
set scrolloff=2           " keep 2 lives visible above/below the cursor
set laststatus=2          " always show status line.
set shortmess+=IA         " suppress intro and swap file messages
set showcmd               " show command on last line
set showmode              " show mode
set wig=*.o,*.pyc         " Ignore these files for wildmenu completion
set wildmenu              " Better command-line completion
set wildmode=longest:full " Makes tab completion smarter
set winheight=3           " Never let a window be less than 3 lines
set winminheight=3        " Never let a window be less than 3 lines

set autoindent            " indent like the last line, by default
set cindent               " indent for c syntax
set cinkeys-=0#           " I should look up what this does again
set cinoptions+=g2        " indent scope declarations by 2
set cinoptions+=h2        " indent statements after scope declarations by 2
set smarttab              " delete shifted spaces as if they were tabs
set tabstop=4             " tabs = 4 spaces
set shiftwidth=4          " basic indents = 4 spaces
set expandtab             " expand tabs to spaces
set paste                 " enable paste in insert mode

function! ShowRuler()
    if exists("+colorcolumn")
        set colorcolumn=81    " highlight 81st column
        highlight ColorColumn ctermbg=darkgray guibg=darkgray
    endif
endfunction

function! SetupOmnirankEnvironment()
  let l:path = expand('%:p')
  if l:path =~ '.*/omnirank/.*'
    setlocal expandtab smarttab tabstop=2 shiftwidth=2
  endif
endfunction

function! CPPHeader()
  " run
  " g++ -E -x c++ - -v < /dev/null
  " to find out the default compiler header file path
  if system("uname") =~ "Linux"
    set path+=/usr/include/c++/4.8,/usr/include/x86_64-linux-gnu/c++/4.8,/usr/include/c++/4.8/backward,/usr/lib/gcc/x86_64-linux-gnu/4.8/include,/usr/local/include,/usr/lib/gcc/x86_64-linux-gnu/4.8/include-fixed,/usr/include/x86_64-linux-gnu,/usr/include
  endif
endfunction

""""""""""""""""""""""""""""""""""
" ===== Auto command section =====
""""""""""""""""""""""""""""""""""
if has('autocmd')
    augroup vimrc
    au!
    " Set up CPP specific autocommands
    au FileType c,cpp,cc setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,f://

    au BufNewFile,BufRead *.{c,cpp,cc,cxx,h}        set ft=cpp
    " show 80 character ruler
    au FileType c,cpp,cc,py,cxx,h   call ShowRuler()
    " special indentation
    au FileType c,cpp,cc        call SetupOmnirankEnvironment()
    au FileType c,cpp,cc        call CPPHeader()
    au BufNewFile,BufRead *.{sig,cnf,conf,config}   set ft=config
    au BufNewFile,BufRead *.slaqur                  set filetype=yaml

    " When entering a buffer, cd to the file's directory, silently fail
    autocmd BufEnter * silent! lcd %:p:h

    " Auto remove trailing whitespace
    autocmd BufWritePre *.{py,c,cpp,cc,cxx,h} :%s/\s\+$//e

    " Auto source the vimrc file when it is saved
    au! BufWritePost [\._]vimrc source $VIMRC

    augroup END
endif

"""""""""""""""""""""""""""""""
" ===== Nice Window Title =====
"""""""""""""""""""""""""""""""
if has('title') && (has('gui_running') || &title)
    set titlestring=
    set titlestring+=%f\                                              " file name
    set titlestring+=%h%m%r%w                                         " flags
    set titlestring+=\ -\ %{v:progname}                               " program name
    set titlestring+=\ -\ %{substitute(getcwd(),\ $HOME,\ '~',\ '')}  " working directory
endif

" switch between .h and .cc file Easily
let g:alternateExtensions_cc = "he,h"
let g:alternateExtensions_h = "cc,c"
let g:alternateExtensions_he = "cc,c"
let g:alternateRelativeFiles = 1
" map <F2> :A<CR>

""""""""""""""""""""""""""""
" ===== Switching tabs =====
""""""""""""""""""""""""""""
nmap <c-j> <c-w>j
nmap <c-k> <c-w>k
nmap <c-h> <c-w>h
nmap <c-l> <c-w>l

" Open nerdtree
map <C-n> :NERDTreeToggle<CR>

" Jump to definition
nnoremap <C-]> :YcmCompleter GoToDefinition<CR>

"Tab switching shortcuts
nnoremap <A-h> :tabp<CR>
nnoremap <A-l> :tabn<CR>


colorscheme badwolf

