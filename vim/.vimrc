set nocompatible              " be iMproved, required
filetype off                  " required
"filetype on                                                                    
filetype plugin on                                                             
syntax on    
filetype plugin indent on    
     
set smartindent    
set ruler    
set showcmd    
set number    
set cursorline    
set cursorcolumn    
set smartcase    
set incsearch    
set hlsearch    
     
if has("gui_running")    
    colorscheme default    
    set bg=light    
else    
    colorscheme jellybeans    
    set gfn=Inconsolata-dz\ 9    
endif    
     
set tabstop=4    
set shiftwidth=4    
set softtabstop=4    
set expandtab    
set smarttab    
set textwidth=100    
set colorcolumn=100    
set t_Co=256    
set tabpagemax=200    
     
"encoding    
set encoding=utf-8    
set laststatus=2



" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'airblade/vim-gitgutter'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
