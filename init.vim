set number                  " set numbered lines
set encoding=utf-8          " general encoding
set fileencoding=utf-8      " encofing written to file
set termencoding=utf-8      " terminal encoding
set mouse=a                 " allow mouse usage
set t_Co=256                " 256-bit terminal color support
set termguicolors           " set term gui colors
set cursorline              " cursor line indicator
set cb+=unnamedplus         " shared clipboard
set tabstop=4               " show existing tab with 4 spaces width
set shiftwidth=4            " when indenting with '>', use 4 spaces width
set expandtab               " on pressing tab, insert 4 spaces
set pastetoggle=<F3>        " paste mode to avoid autoindent
set splitright              " hacky vertical split direction to right
set splitbelow              " hacky horizontal split direction to down
set hlsearch                " highlight all matches from previous search pattern
set noshowmode              " wont show things like --INSERT--
set smartcase               " smart casing
set smartindent             " indenting is smart again
set timeoutlen=500          " time to wait for a mapped sequence to complete (ms)
set undofile                " persistent undo
set updatetime=300          " faster completion
set norelativenumber        " relative numbered lines
set signcolumn=yes          " always show the sign column
set linebreak               " companion to wrap, don't split words
set scrolloff=8             " minimum number of lines above and below cursor
set sidescrolloff=8         " minimum number of columns either side of cursor
set guifont=monospace:h17   " fong used in graphical neovim apps
set nobomb                  " disable bomb characters
set spell                   " enable spellcheck

filetype plugin on          " enable filetype detection
filetype plugin indent on   " indents based on filetype
syntax on                   " syntax highlighting
syntax enable               " syntax highlighting

set whichwrap="bs\<\>\[\]h1 

" Unholy
" set nowrap
" set path+=**,.,,

let mapleader = ","
let maplocalleader = "."

" Don't touch, nvim-tree is weird
autocmd bufenter * if (winnr("$") == 1 && &filetype == "nvimtree") | q | endif

" Printer go brrr
nnoremap <leader><leader><leader>p :r !echo; lpstat -p \| sed 's/printer //g' \| sed 's/is idle.  enabled since.*//g'; echo<cr>

nnoremap <leader><leader>pl :w<cr>:!lpoptions -d Brother_HL_L2340D_series<cr>:!lp -n 1 -o media=a4 -o sides=two-sided-long-edge %<cr><cr>

" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" Black hole deletion
nnoremap <leader>d "_d
xnoremap <leader>d "_d
xnoremap <leader>p "_dP

" Lua plugin modules with custom configs
call v:lua.require('plugins')
call v:lua.require('configs.colorscheme')
call v:lua.require('configs.alpha')
call v:lua.require('configs.faster')
call v:lua.require('configs.gitsigns')
call v:lua.require('configs.lualine')
call v:lua.require('configs.icons')
call v:lua.require('configs.nvim-tree')
call v:lua.require('configs.toggleterm')
call v:lua.require('configs.telescope')
call v:lua.require('configs.treesitter')
call v:lua.require('configs.cmp')
call v:lua.require('configs.lsp')
call v:lua.require('configs.null-ls')
call v:lua.require('configs.whichkey')
call v:lua.require('configs.markdownpreview')
call v:lua.require('configs.vimtex')
call v:lua.require('configs.leap')
call v:lua.require('configs.tabby')
call v:lua.require('configs.mini_jump')

" Plugin setups with default configs
call v:lua.require('nvim-autopairs').setup()
call v:lua.require('todo-comments').setup()
call v:lua.require('Comment').setup()
call v:lua.require('nvim-surround').setup()
