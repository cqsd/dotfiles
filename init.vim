source ~/.vimrc
" nvim needs python3. you gotta set this up yourself
" also jedi won't work if you don't expand, so.
let g:python3_host_prog=expand('~/.venvs/nvim/bin/python3')

"  initialize vim-plug...
call plug#begin('~/.vim/bundle')
Plug 'Rip-Rip/clang_complete'
Plug 'kien/ctrlp.vim'
Plug 'Shougo/deoplete.nvim'
Plug 'eagletmt/ghcmod-vim'
Plug 'neovimhaskell/haskell-vim'
Plug 'eagletmt/neco-ghc'
Plug 'Shougo/neocomplete.vim'
Plug 'scrooloose/nerdtree'
Plug 'edkolev/promptline.vim'
Plug 'luochen1990/rainbow'
Plug 'scrooloose/syntastic'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'guns/vim-clojure-static'
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-fireplace'
Plug 'dag/vim-fish'
Plug 'tpope/vim-fugitive'
Plug 'w0ng/vim-hybrid'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'henrik/vim-indexed-search'
Plug 'tpope/vim-surround'
Plug 'Shougo/vimproc.vim'
Plug 'davidhalter/jedi-vim'
Plug 'zchee/deoplete-jedi'
Plug 'xolox/vim-notes'
Plug 'xolox/vim-misc'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
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
    source ~/.neocompleterc
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

" at some point, need to learn vimscript
function Airlinedark()
    let g:airline_solarized_bg='dark'
    AirlineRefresh
endfunction

function Airlinelight()
    let g:airline_solarized_bg='light'
    AirlineRefresh
endfunction

function SetCScopeMappings()
    cnoreabbrev csa cs add
    cnoreabbrev csf cs find
    cnoreabbrev csg cs find g
    cnoreabbrev csk cs kill
    cnoreabbrev csr cs reset
    cnoreabbrev css cs show
    cnoreabbrev csh cs help
endfunction

function PythonWtf()
    setlocal omnifunc=python3complete#Complete
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
autocmd FileType python call PythonWtf()
autocmd FileType markdown set autoindent
autocmd FileType html,htmldjango,css,yaml set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd BufNewFile,BufReadPost *.asd set filetype=lisp
autocmd BufNewFile,BufReadPost *.boot set filetype=clojure
" crontab complains if backup is set to no or auto
autocmd filetype crontab setlocal nobackup nowritebackup
autocmd filetype c,cpp call SetCScopeMappings()
