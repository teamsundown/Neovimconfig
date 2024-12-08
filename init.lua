" === General Settings ===
set nocompatible          " Disable Vi compatibility
filetype off              " Disable filetype detection

" Enable filetype plugins and indentation
filetype plugin indent on
syntax enable             " Enable syntax highlighting

" === Appearance ===
set background=dark       " Set background to dark for better contrast
colorscheme gruvbox       " Use gruvbox theme (similar to Atom)
set termguicolors         " Enable 24-bit RGB colors
set number                " Show line numbers
set relativenumber        " Show relative line numbers
set cursorline            " Highlight the current line
set wrap                  " Enable word wrapping
set showcmd               " Display incomplete commands
set wildmenu              " Enhanced command-line completion
set showmatch             " Highlight matching parentheses

" === Atom-like Features ===
set autoindent            " Enable automatic indentation
set smartindent           " Smarter indentation
set expandtab             " Use spaces instead of tabs
set tabstop=4             " Number of spaces per tab
set shiftwidth=4          " Spaces for auto-indents
set softtabstop=4         " Spaces per tab press
set clipboard=unnamedplus " Enable system clipboard integration
set hidden                " Allow switching buffers without saving
set splitbelow            " Open horizontal splits below
set splitright            " Open vertical splits to the right

" === Plugin Manager ===
call plug#begin('~/.vim/plugged')

" Themes and Appearance
Plug 'morhetz/gruvbox'               " Gruvbox theme
Plug 'ryanoasis/vim-devicons'        " File icons
Plug 'vim-airline/vim-airline'       " Statusline
Plug 'vim-airline/vim-airline-themes'

" LSP and Syntax Highlighting
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Completion and LSP

" File Navigation
Plug 'preservim/nerdtree'            " File explorer
Plug 'junegunn/fzf', {'do': './install --all'}  " Fuzzy finder
Plug 'junegunn/fzf.vim'

" Git Integration
Plug 'tpope/vim-fugitive'            " Git commands in Vim

" Language-Specific Plugins
Plug 'pangloss/vim-javascript'       " JavaScript syntax
Plug 'leafgarland/typescript-vim'    " TypeScript support
Plug 'vim-python/python-syntax'      " Python syntax highlighting
Plug 'OmniSharp/omnisharp-vim'       " C# support

" Additional Features
Plug 'airblade/vim-gitgutter'        " Git diff markers in the gutter
Plug 'tpope/vim-commentary'          " Commenting helper
Plug 'jiangmiao/auto-pairs'          " Auto-closing of parentheses and quotes

call plug#end()

" === Keybindings ===
nnoremap <C-n> :NERDTreeToggle<CR>            " Toggle NERDTree
nnoremap <C-p> :FZF<CR>                       " Open FZF fuzzy finder
nnoremap <Leader>f :Files<CR>                 " Search for files
nnoremap <Leader>g :GFiles<CR>                " Search Git files
nnoremap <Leader>b :Buffers<CR>               " Search open buffers
nnoremap <Leader>/ :BLines<CR>                " Search in buffer

" === CoC.nvim Configuration ===
" Use <Tab> and <S-Tab> for navigation in completion menu
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Format on save
autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx,*.py,*.cs :call CocAction('format')

" Set up language servers
let g:coc_global_extensions = [
\ 'coc-python',
\ 'coc-tsserver',
\ 'coc-html',
\ 'coc-css',
\ 'coc-json',
\ 'coc-sh',
\ 'coc-omnisharp'
\]

" === Airline Configuration ===
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'gruvbox'

" === GitGutter Configuration ===
let g:gitgutter_enabled = 1

" === Auto-pairs Configuration ===
let g:AutoPairsFlyMode = 1

" === Python-Specific Settings ===
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=4

" === JavaScript-Specific Settings ===
autocmd FileType javascript setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2

" === C#-Specific Settings ===
autocmd FileType cs setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=4

" === Miscellaneous ===
set updatetime=300     " Faster completion
set timeoutlen=500     " Faster key sequences
set incsearch          " Incremental search
set ignorecase         " Ignore case in searches
set smartcase          " Case-sensitive if uppercase is used

" Save session when leaving
autocmd VimLeavePre * :mksession! ~/.vim/session.vim
