" Create a nvim config file in your personal home directory, at ~/.config/nvim/init.vim
" Warning! You should already have neovim, nodejs, npm, python3, python3-pip installed! Ensure all are updated!
" File: ~/.config/nvim/init.vim

" Ensure Vim-Plug is installed before using this file:
" curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
" https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

" Load Vim-Plug for plugin management
call plug#begin('~/.local/share/nvim/plugged')

" Appearance - Atom-like theme
Plug 'morhetz/gruvbox'                  " Gruvbox theme
Plug 'nvim-tree/nvim-web-devicons'      " File icons

" Statusline - Like Atom/VSCode
Plug 'nvim-lualine/lualine.nvim'

" File Explorer
Plug 'nvim-tree/nvim-tree.lua'

" Treesitter for Better Syntax Highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" LSP and Autocompletion for VSCode-like features
Plug 'neovim/nvim-lspconfig'            " Core LSP configuration
Plug 'williamboman/mason.nvim'          " LSP/DAP/Formatter installer
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'hrsh7th/nvim-cmp'                 " Autocompletion framework
Plug 'hrsh7th/cmp-nvim-lsp'             " LSP source for nvim-cmp
Plug 'hrsh7th/cmp-buffer'               " Buffer source for nvim-cmp
Plug 'hrsh7th/cmp-path'                 " Path source for nvim-cmp
Plug 'L3MON4D3/LuaSnip'                 " Snippet engine
Plug 'saadparwaiz1/cmp_luasnip'         " Snippet source for nvim-cmp

" Debugging
Plug 'mfussenegger/nvim-dap'            " Debug Adapter Protocol

" Language-Specific Plugins
Plug 'psf/black', {'branch': 'stable'}  " Black formatter for Python
Plug 'jose-elias-alvarez/typescript.nvim' " TypeScript/JavaScript tools
Plug 'OmniSharp/omnisharp-vim'          " C# support

call plug#end()
PlugInstall
" General Settings
set number                " Show line numbers
set relativenumber        " Show relative line numbers
set tabstop=4             " Number of spaces for a tab
set shiftwidth=4          " Indentation levels use 4 spaces
set expandtab             " Use spaces instead of tabs
set autoindent            " Auto-indent new lines
set clipboard=unnamedplus " Use system clipboard
set termguicolors         " Enable true color support
set cursorline            " Highlight the current line
set scrolloff=8           " Keep 8 lines visible when scrolling
set wrap                  " Wrap long lines
set background=dark       " Use dark background
colorscheme gruvbox       " Apply Gruvbox theme

" Configure Lualine (Statusline)
require('lualine').setup {
    options = { theme = 'gruvbox' },
}

" Configure Nvim-Tree (File Explorer)
require('nvim-tree').setup()

" Configure Treesitter for Enhanced Syntax Highlighting
require'nvim-treesitter.configs'.setup {
    ensure_installed = { "python", "javascript", "c_sharp", "html", "css", "bash", "json" },
    highlight = { enable = true },
    indent = { enable = true },
}

" Configure Mason (LSP/DAP/Formatters Installer)
require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = { "pyright", "tsserver", "omnisharp" },
}

" LSP Configuration
local lspconfig = require'lspconfig'
lspconfig.pyright.setup{}        " Python LSP
lspconfig.tsserver.setup{}       " JavaScript/TypeScript LSP
lspconfig.omnisharp.setup{}      " C# LSP

" Completion Configuration
local cmp = require'cmp'
cmp.setup {
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }, {
        { name = 'buffer' },
    })
}

" Debugging Keybindings (DAP)
nnoremap <F5> :lua require'dap'.continue()<CR>    " Start/continue debugging
nnoremap <F10> :lua require'dap'.step_over()<CR>  " Step over
nnoremap <F11> :lua require'dap'.step_into()<CR>  " Step into
nnoremap <F12> :lua require'dap'.step_out()<CR>   " Step out

" Keybindings for Productivity
nnoremap <C-n> :NvimTreeToggle<CR>   " Toggle file explorer
nnoremap <leader>f :lua vim.lsp.buf.format({ async = true })<CR> " Format code
nnoremap <leader>r :lua vim.lsp.buf.rename()<CR> " Rename symbol
