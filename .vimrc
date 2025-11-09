" --- Set leader key ---
let mapleader = " "
let maplocalleader = " "

" --- Save file ---
nnoremap <leader>s :w<CR>
nnoremap <leader>r :w<CR>:make<CR>
nnoremap <leader>S :wq<CR>
nnoremap <leader>md :call mkdir(expand('%:h'), 'p')<CR>

" --- File Explorer ---
nnoremap <leader>nv :Ex<CR>
nnoremap <leader>nq :q!<CR>

" --- Alternate file ---
nnoremap <leader>o :e #<CR>

" --- Delete/Change/Substitute without affecting registers ---
nnoremap x "_x
vnoremap x "_x
nnoremap c "_c
vnoremap c "_c
nnoremap s "_s
vnoremap s "_s

" --- Save session and quit all ---
nnoremap <leader>ns :mksession! Session.vim<CR>:wqa<CR>

" --- Close buffer / New buffer ---
nnoremap <leader>x :bdelete!<CR>
nnoremap <leader>b :enew<CR>

" --- Tabs ---
nnoremap <leader>tn :tabnew<Space>
nnoremap tn :e #<CR>
nnoremap tN :tabn<CR>
nnoremap tp :tabp<CR>

" --- Toggle line wrapping ---
nnoremap <leader>lw :set wrap!<CR>

" --- Keep last yanked text when pasting ---
vnoremap p "_dP

" --- Insert blank lines easily ---
nnoremap <CR> o<Esc>
nnoremap <C-h> O<Esc>

" --- Snippets ---
inoremap {E {<CR>}<Esc>O


" ---------- General Settings ----------
set number                    " Show absolute line numbers
set relativenumber             " Show relative line numbers
set clipboard=unnamedplus      " Use system clipboard
set nowrap                     " Do not wrap long lines
set nolinebreak                " Do not break lines at word boundaries
set mouse=                     " Disable mouse support
set autoindent                 " Copy indent from current line when starting new one
set ignorecase                 " Case-insensitive searching
set smartcase                  " Override ignorecase if search contains uppercase
set shiftwidth=4               " Indent width
set tabstop=4                  " Number of spaces per tab
set softtabstop=4              " Spaces per tab during editing
set expandtab                  " Convert tabs to spaces
set scrolloff=4                " Keep 4 lines visible above/below cursor
set sidescrolloff=8            " Keep 8 columns visible to the sides
set nocursorline               " Disable current line highlight
set splitbelow                 " New horizontal splits open below
set splitright                 " New vertical splits open to the right
set nohlsearch                 " Don't highlight search matches
set noshowmode                 " Don’t show -- INSERT -- mode message
set whichwrap=bs<>[]hl         " Allow certain keys to wrap to next/prev line
set numberwidth=4              " Width of the number column
set noswapfile                 " Disable swapfile
set smartindent                " Smarter auto-indenting
set backspace=indent,eol,start " Allow backspace over indent, EOL, and start
set pumheight=10               " Popup menu height
set conceallevel=0             " Show concealed text in markdown
" set signcolumn=yes             " Always show sign column
set fileencoding=utf-8         " Use UTF-8 encoding
set cmdheight=1                " Command line height
set breakindent                " Indent wrapped lines visually
set updatetime=250             " Faster completion (default 4000 ms)
set timeoutlen=300             " Time to wait for a mapped sequence
set nobackup                   " Disable backup file
set nowritebackup              " Disable write backup
set undofile                   " Maintain undo history
set completeopt=menuone,noselect " Better completion experience
set shortmess+=c               " Don't show completion messages
set iskeyword+=-               " Treat hyphenated words as a single word
set textwidth=0                " No automatic text wrapping

" ---------- Tabline ----------
set showtabline=1              " Show tabline only when multiple tabs

" ---------- Scrolling ----------
set scroll=10                  " Number of lines to scroll with Ctrl+D/Ctrl+U

" ---------- Netrw ----------
let g:netrw_liststyle = 3      " Tree-style netrw view

" ---------- GUI Cursor ----------
set guicursor=n-v-c-i-r-cr-o-sm:block " Use block cursor for all modes

