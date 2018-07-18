source ~/.vimrc
" nvim needs python3. you gotta set this up yourself
" also jedi won't work if you don't expand, so.
let g:python3_host_prog=expand('~/.venvs/nvim/bin/python3')

"  initialize vim-plug...
call plug#begin('~/.vim/bundle')
" core
Plug 'kien/ctrlp.vim'
Plug 'Shougo/vimproc.vim'
Plug 'tpope/vim-surround'
" nice to have
Plug 'Shougo/deoplete.nvim'
Plug 'scrooloose/syntastic'
Plug 'henrik/vim-indexed-search'
Plug 'xolox/vim-notes'
Plug 'xolox/vim-misc'
Plug 'tpope/vim-fugitive'
" lang-specific, enable as necessary
Plug 'davidhalter/jedi-vim'  " python
Plug 'zchee/deoplete-jedi'   " python
Plug 'zchee/deoplete-clang'
" Plug 'guns/vim-clojure-static'
" Plug 'tpope/vim-fireplace'
" Plug 'eagletmt/ghcmod-vim'
" Plug 'neovimhaskell/haskell-vim'
" Plug 'eagletmt/neco-ghc'
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Plug 'dag/vim-fish'
" getting sort of extra
Plug 'scrooloose/nerdtree'
Plug 'luochen1990/rainbow'
" absolutely not necessary
Plug 'altercation/vim-colors-solarized'
Plug 'w0ng/vim-hybrid'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end() " you'll need a :PlugInstall the first time

map <C-n> :NERDTreeToggle<CR>
if has('nvim')
    let g:deoplete#enable_at_startup = 1
    " TODO I need like a .plugins.vim for all the plugin config instead of
    " putting it in main vim config
    " source ~/.deocompleterc
    " use tab for deocomplete
    inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
else
    source ~/.neocomplete.vim
endif
colorscheme hybrid_material
set background=dark

let g:airline_powerline_fonts = 1
let g:airline_theme='zenburn'
set laststatus=2 " Make airline appear all the time
" Enable the list of buffers and show just the filename
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
" TODO Someday, fix this to just not use airline
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_left_alt_sep = ''
let g:airline_right_alt_sep = ''

let g:notes_directories = ['~/notes']

" lol
map <Leader>C :CtrlPClearCache<CR>

function SetCScopeMappings()
    cnoreabbrev csa cs add
    cnoreabbrev csf cs find
    cnoreabbrev csg cs find g
    cnoreabbrev csk cs kill
    cnoreabbrev csr cs reset
    cnoreabbrev css cs show
    cnoreabbrev csh cs help
endfunction

" Syntastic
" Puts all the syntax errors in the location list
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

let g:syntastic_python_python_exec = 'python3'
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args='--ignore=E221,E266,E501'

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" close preview window automatically after autocomplete
autocmd CompleteDone * pclose

" ------ Filetype-specific ------
autocmd FileType lisp,clojure set completeopt=longest,menuone foldmethod=syntax
autocmd FileType markdown set autoindent
autocmd FileType html,htmldjango,css,yaml set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd BufNewFile,BufReadPost *.asd set filetype=lisp
autocmd BufNewFile,BufReadPost *.boot set filetype=clojure
" crontab complains if backup is set to no or auto
autocmd filetype crontab setlocal nobackup nowritebackup
autocmd filetype c,cpp call SetCScopeMappings()
