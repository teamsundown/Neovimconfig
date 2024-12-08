" Create a nvim config file in your personal home directory, at ~/.config/nvim/init.vim
" Warning! You should already have neovim, nodejs, npm, python3, python3-pip installed! Ensure all are updated!
" START UI PORTION
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
syntax on                " Enable syntax highlighting
set background=dark      " Set dark background
" END UI PORTION
" START FUNCTIONALITY PORTION
call plug#begin('~/.local/share/nvim/plugged')

Plug 'nvim-tree/nvim-web-devicons'   
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-lualine/lualine.nvim'     
Plug 'neovim/nvim-lspconfig'         
Plug 'williamboman/mason.nvim'      
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'hrsh7th/nvim-cmp'             
Plug 'hrsh7th/cmp-nvim-lsp'         
Plug 'hrsh7th/cmp-buffer'            
Plug 'hrsh7th/cmp-path'             
Plug 'L3MON4D3/LuaSnip'             
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'mfussenegger/nvim-dap'
Plug 'psf/black', {'branch': 'stable'} " Black formatter
Plug 'jose-elias-alvarez/typescript.nvim'
Plug 'OmniSharp/omnisharp-vim'
Plug 'tpope/vim-fugitive'

call plug#end()
" END FUNCTIONALITY PORTION
" START LUA CONFIG
require('lualine').setup {
    options = { theme = 'darkblue' },
}
"END LUA CONFIG
"START TREESITTER CONFIG
require("nvim-tree").setup()
require'nvim-treesitter.configs'.setup {
    ensure_installed = { "python", "javascript", "c_sharp" },  " Languages to support
    highlight = { enable = true },  " Enable syntax highlighting
    indent = { enable = true },     " Enable smart indentation
}
"END TREESITTER CONFIG
"START MASON CONFIG
require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = { "pyright", "tsserver", "omnisharp" }  " Language servers
}
"END MASON CONFIG
"START LSP CONFIG
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
"END LSP CONFIG

" KEYBINDS FOR COMMON FUNCTIONS
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
