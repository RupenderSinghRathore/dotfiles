let s:cpo_save=&cpo
set cpo&vim
cnoremap <silent> <Plug>(TelescopeFuzzyCommandSearch) e "lua require('telescope.builtin').command_history { default_text = [=[" . escape(getcmdline(), '"') . "]=] }"
inoremap <C-W> u
inoremap <C-U> u
nnoremap  O
nnoremap  <Cmd>nohlsearch|diffupdate|normal! 
nnoremap  o
tnoremap  
nmap  d
nnoremap  :<BS>
vnoremap <silent>  <Cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())
nnoremap  gp :Git push 
nnoremap  gc :Git commit -m 
nnoremap  ga :Git add .
nnoremap  ge oif err != nil {}Oreturn err
nnoremap  lw <Cmd>set wrap!
nnoremap  tn :tabnew 
nnoremap  b <Cmd> enew 
nnoremap  x :bdelete!
nnoremap  nS :source Session.vim
nnoremap  ns :mksession!Session.vim:wq
nnoremap  o <Cmd>e #
nnoremap  nq <Cmd>q!
nnoremap  nv <Cmd>Ex
nnoremap  md <Cmd>call mkdir(expand('%:h'), 'p')
nnoremap  S <Cmd>wq
nnoremap  s <Cmd>w
omap <silent> % <Plug>(MatchitOperationForward)
xmap <silent> % <Plug>(MatchitVisualForward)
nmap <silent> % <Plug>(MatchitNormalForward)
nnoremap & :&&
xnoremap <silent> <expr> @ mode() ==# 'V' ? ':normal! @'.getcharstr().'' : '@'
tnoremap JJ 
xnoremap <silent> <expr> Q mode() ==# 'V' ? ':normal! @=reg_recorded()' : 'Q'
nnoremap U :undo
nnoremap Y y$
omap <silent> [% <Plug>(MatchitOperationMultiBackward)
xmap <silent> [% <Plug>(MatchitVisualMultiBackward)
nmap <silent> [% <Plug>(MatchitNormalMultiBackward)
nnoremap <silent> \ :Neotree reveal
omap <silent> ]% <Plug>(MatchitOperationMultiForward)
xmap <silent> ]% <Plug>(MatchitVisualMultiForward)
nmap <silent> ]% <Plug>(MatchitNormalMultiForward)
xmap a% <Plug>(MatchitVisualTextObject)
vnoremap c "_c
nnoremap c "_c
xnoremap gb <Plug>(comment_toggle_blockwise_visual)
nnoremap gb <Plug>(comment_toggle_blockwise)
omap <silent> g% <Plug>(MatchitOperationBackward)
xmap <silent> g% <Plug>(MatchitVisualBackward)
nmap <silent> g% <Plug>(MatchitNormalBackward)
xnoremap gc <Plug>(comment_toggle_linewise_visual)
nnoremap gc <Plug>(comment_toggle_linewise)
snoremap <silent> p p
xnoremap p "_dP
vnoremap s "_s
nnoremap s "_s
nnoremap tp :tabp
nnoremap tN :tabn
nnoremap tn <Cmd>e #
nnoremap u <Nop>
vnoremap x "_x
nnoremap x "_x
vnoremap <silent> <C-/> <Cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())
vnoremap <silent> <C-_> <Cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())
xnoremap <Plug>(comment_toggle_blockwise_visual) <Cmd>lua require("Comment.api").locked("toggle.blockwise")(vim.fn.visualmode())
xnoremap <Plug>(comment_toggle_linewise_visual) <Cmd>lua require("Comment.api").locked("toggle.linewise")(vim.fn.visualmode())
xmap <silent> <Plug>(MatchitVisualTextObject) <Plug>(MatchitVisualMultiBackward)o<Plug>(MatchitVisualMultiForward)
onoremap <silent> <Plug>(MatchitOperationMultiForward) :call matchit#MultiMatch("W",  "o")
onoremap <silent> <Plug>(MatchitOperationMultiBackward) :call matchit#MultiMatch("bW", "o")
xnoremap <silent> <Plug>(MatchitVisualMultiForward) :call matchit#MultiMatch("W",  "n")m'gv``
xnoremap <silent> <Plug>(MatchitVisualMultiBackward) :call matchit#MultiMatch("bW", "n")m'gv``
nnoremap <silent> <Plug>(MatchitNormalMultiForward) :call matchit#MultiMatch("W",  "n")
nnoremap <silent> <Plug>(MatchitNormalMultiBackward) :call matchit#MultiMatch("bW", "n")
onoremap <silent> <Plug>(MatchitOperationBackward) :call matchit#Match_wrapper('',0,'o')
onoremap <silent> <Plug>(MatchitOperationForward) :call matchit#Match_wrapper('',1,'o')
xnoremap <silent> <Plug>(MatchitVisualBackward) :call matchit#Match_wrapper('',0,'v')m'gv``
xnoremap <silent> <Plug>(MatchitVisualForward) :call matchit#Match_wrapper('',1,'v'):if col("''") != col("$") | exe ":normal! m'" | endifgv``
nnoremap <silent> <Plug>(MatchitNormalBackward) :call matchit#Match_wrapper('',0,'n')
nnoremap <silent> <Plug>(MatchitNormalForward) :call matchit#Match_wrapper('',1,'n')
nnoremap <Plug>PlenaryTestFile :lua require('plenary.test_harness').test_file(vim.fn.expand("%:p"))
nnoremap <C-H> O
tnoremap <C-O> 
nmap <C-W><C-D> d
nnoremap <C-L> <Cmd>nohlsearch|diffupdate|normal! 
inoremap  u
inoremap  u
inoremap {E {}O
let &cpo=s:cpo_save
unlet s:cpo_save
set number
set relativenumber
set clipboard=unnamedplus
set completeopt=menuone,noselect
set expandtab
set formatoptions=jtq
set ignorecase
set mouse=
set scrolloff=4
set shiftwidth=4
set smartcase
set smartindent
set softtabstop=4
set splitbelow
set splitright
set noswapfile
set tabstop=4
set termguicolors
