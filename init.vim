" Create a nvim config file in your personal home directory, at ~/.config/nvim/init.vim
set number            " Show line numbers
set tabstop=4         " Number of spaces for a tab
set shiftwidth=4      " Indentation levels use 4 spaces
set expandtab         " Use spaces instead of tabs
set autoindent        " Copy indent from current line when starting a new line
set clipboard=unnamedplus " Use system clipboard
colorscheme darkblue
set hlsearch          " Highlight search results
set incsearch         " Show search matches as you type
set ignorecase        " Ignore case in searches
set cursorline        " Highlight the current line
set termguicolors     " Enable true color support
set scrolloff=8       " Keep 8 lines visible when scrolling

call plug#begin('~/.local/share/nvim/plugged')

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'

call plug#end()
