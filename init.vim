set number                  " set numbered lines
set encoding=utf-8          " general encoding
set fileencoding=utf-8      " encofing written to file
set termencoding=utf-8      " terminal encoding
set mouse=a                 " allow mouse usage
set t_Co=256                " 256-bit terminal color support
set termguicolors           " set term gui colors
syntax on                   " syntax highlighting
syntax enable               " 
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
set timeoutlen=300          " time to wait for a mapped sequence to complete (ms)
set undofile                " persistent undo
set updatetime=300          " faster completion
set norelativenumber        " relative numbered lines
set signcolumn=yes          " always show the sign column
set nowrap                  " display lines as one long line
set linebreak               " companion to wrap, don't split words
set scrolloff=8             " minimum number of lines above and below cursor
set sidescrolloff=8         " minimum number of columns either side of cursor
set guifont=monospace:h17   " fong used in graphical neovim apps
set whichwrap="bs\<\>\[\]h1"" which horizontal keys are allowed to travel to the prev/next line
filetype plugin indent on   " indents based on filetype

" Unholy


let mapleader = ","

" Hacky terminal stuff
" map <Leader>t :vs \| te<CR>
" autocmd TermOpen * startinsert
" autocmd TermClose * execute 'bdelete! ' . expand('<abuf>')
" tnoremap kj <C-\><C-n>

" NvimTree shortcut toggle
map <Leader>m :NvimTreeToggle .<CR>

" Don't touch, nvim-tree is weird
autocmd bufenter * if (winnr("$") == 1 && &filetype == "nvimtree") | q | endif

" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" Search highlighting disable
map <Leader>c :noh<CR>

" Tagbar mappings
" map <Leader>b :TagbarToggle<CR>

" Open vs code in curr dir
map <Leader>n :!code .<CR>

" Toggle term presets
map <Leader>s :lua _PYTHON_TOGGLE()<CR>
map <Leader>g :lua _LAZYGIT_TOGGLE()<CR>
map <Leader>v :ToggleTerm direction=vertical size=60<CR>

" Telescope stuff
map <Leader>f :Telescope find_files<CR>
map <Leader>l :Telescope live_grep<CR>

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

" Plugin setups with default configs
call v:lua.require('nvim-autopairs').setup()
call v:lua.require('todo-comments').setup()
call v:lua.require('Comment').setup()
