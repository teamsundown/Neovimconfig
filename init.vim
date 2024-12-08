" Create a nvim config file in your personal home directory, at ~/.config/nvim/init.vim
" Warning! You should already have neovim, nodejs, npm, python3, python3-pip installed! Ensure all are updated!
" File: ~/.config/nvim/init.vim

" General Settings
set number               " Show line numbers
set relativenumber       " Show relative line numbers
set tabstop=4            " Number of spaces for a tab
set shiftwidth=4         " Indentation levels use 4 spaces
set expandtab            " Use spaces instead of tabs
set autoindent           " Auto-indent new lines
set clipboard=unnamedplus " Use system clipboard
set termguicolors        " Enable true color support
set cursorline           " Highlight the current line
set scrolloff=8          " Keep 8 lines visible when scrolling
set wrap                 " Wrap long lines

" Appearance - Atom-like UI
syntax on                " Enable syntax highlighting
set background=dark      " Set dark background
colorscheme gruvbox      " Atom-like theme (requires gruvbox plugin)

" Plugin Manager - vim-plug
call plug#begin('~/.local/share/nvim/plugged')

" Appearance Plugins
Plug 'morhetz/gruvbox'               " Atom-like color scheme
Plug 'nvim-tree/nvim-web-devicons'   " File icons

" File Explorer
Plug 'nvim-tree/nvim-tree.lua'

" Status Line
Plug 'nvim-lualine/lualine.nvim'     " VSCode-like status line

" Treesitter for Better Syntax Highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" LSP and Autocompletion
Plug 'neovim/nvim-lspconfig'         " Core LSP support
Plug 'williamboman/mason.nvim'       " LSP/DAP/Formatter installer
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'hrsh7th/nvim-cmp'              " Autocompletion framework
Plug 'hrsh7th/cmp-nvim-lsp'          " LSP source for nvim-cmp
Plug 'hrsh7th/cmp-buffer'            " Buffer source for nvim-cmp
Plug 'hrsh7th/cmp-path'              " Path source for nvim-cmp
Plug 'L3MON4D3/LuaSnip'              " Snippets engine
Plug 'saadparwaiz1/cmp_luasnip'      " Snippets source for nvim-cmp

" Debugger
Plug 'mfussenegger/nvim-dap'         " Debug Adapter Protocol

" Python Support
Plug 'psf/black', {'branch': 'stable'} " Black formatter

" JavaScript/TypeScript Support
Plug 'jose-elias-alvarez/typescript.nvim'

" C# Support
Plug 'OmniSharp/omnisharp-vim'

" Git Integration
Plug 'tpope/vim-fugitive'

call plug#end()

" Lualine Configuration
require('lualine').setup {
    options = { theme = 'gruvbox' },
}

" Nvim Tree Configuration
require("nvim-tree").setup()

" Treesitter Configuration
require'nvim-treesitter.configs'.setup {
    ensure_installed = { "python", "javascript", "c_sharp" },  " Languages to support
    highlight = { enable = true },  " Enable syntax highlighting
    indent = { enable = true },     " Enable smart indentation
}

" Mason Configuration for LSP/DAP/Formatters
require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = { "pyright", "tsserver", "omnisharp" }  " Language servers
}

" LSP Configuration
local lspconfig = require'lspconfig'
lspconfig.pyright.setup{}          " Python LSP
lspconfig.tsserver.setup{}         " JavaScript/TypeScript LSP
lspconfig.omnisharp.setup{}        " C# LSP

" Completion Configuration
local cmp = require'cmp'
cmp.setup {
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)  -- Use LuaSnip
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

" Key Bindings for Common Actions
nnoremap <C-n> :NvimTreeToggle<CR> " Toggle file explorer
nnoremap <C-f> :Telescope find_files<CR> " Find files
nnoremap <leader>f :lua vim.lsp.buf.format()<CR> " Format code
nnoremap <leader>r :lua vim.lsp.buf.rename()<CR> " Rename symbol
nnoremap <leader>g :Git<CR> " Git integration

" Debugger Keybindings (DAP)
nnoremap <F5> :lua require'dap'.continue()<CR> " Start/continue debugging
nnoremap <F10> :lua require'dap'.step_over()<CR> " Step over
nnoremap <F11> :lua require'dap'.step_into()<CR> " Step into
nnoremap <F12> :lua require'dap'.step_out()<CR> " Step out
