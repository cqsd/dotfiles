source ~/.vimrc
" nvim needs python3. you gotta set this up yourself
" also jedi won't work if you don't expand, so.
let g:python3_host_prog=expand('~/.venvs/nvim/bin/python3')

"  initialize vim-plug...
call plug#begin('~/.vim/bundle')
" core
Plug 'kien/ctrlp.vim'
Plug 'Shougo/vimproc.vim' " consider building vimproc here with 'do':...
Plug 'tpope/vim-surround'
" nice to have
Plug 'Shougo/deoplete.nvim'
Plug 'scrooloose/syntastic'
Plug 'henrik/vim-indexed-search'
Plug 'xolox/vim-notes'
Plug 'xolox/vim-misc'
Plug 'tpope/vim-fugitive'
" Plug 'mhinz/vim-rfc' " requires +Ruby, which I don't like :)
" Plug 'vim-scripts/rfc-syntax', { 'for': 'rfc' } " syntax highlighting for RFCs
" lang-specific, enable as necessary
Plug 'davidhalter/jedi-vim'
Plug 'zchee/deoplete-jedi'
Plug 'vim-ruby/vim-ruby'
" Plug 'zchee/deoplete-clang'
" Plug 'guns/vim-clojure-static'
Plug 'tpope/vim-fireplace'
" Plug 'eagletmt/ghcmod-vim'
" Plug 'neovimhaskell/haskell-vim'
" Plug 'eagletmt/neco-ghc'
Plug 'zchee/deoplete-go'
Plug 'StanAngeloff/php.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'mdempsky/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }
Plug 'moll/vim-node' " gf on requires to open appropriate file if local (?)
Plug 'mxw/vim-jsx'
Plug 'hashivim/vim-terraform'
Plug 'elixir-editors/vim-elixir'
Plug 'slashmili/alchemist.vim'
Plug 'racer-rust/vim-racer'

Plug 'dag/vim-fish'
Plug 'lervag/vimtex'
Plug 'leafgarland/typescript-vim'

" getting sort of extra
Plug 'scrooloose/nerdtree'
" Plug 'luochen1990/rainbow'

" absolutely not necessary
" Plug 'altercation/vim-colors-solarized'
Plug 'w0ng/vim-hybrid'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'jparise/vim-graphql'
call plug#end() " you'll need a :PlugInstall the first time

map <C-n> :NERDTreeToggle<CR>
if has('nvim')
    let g:deoplete#enable_at_startup = 1
    " TODO I need like a .plugins.vim for all the plugin config instead of
    " putting it in main vim config
    " source ~/.deocompleterc
    " use tab for deocomplete
    inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
    " yeah definitely time to split out into deoplete's own config file
    let g:deoplete#enable_smart_case = 1

    " deoplete-go shit?
    let g:deoplete#sources#go#gocode_binary = $GOBIN . '/gocode'
else
    source ~/.neocompleterc
endif

" colorscheme hybrid_material
" set background=dark

" vimr-specific
if has("gui_vimr")
  colorscheme hybrid_material
  set background=dark
  let g:go_version_warning = 0
else
  colorscheme default
  set background=light
endif

let g:airline_powerline_fonts = 0
" let g:airline_theme='hybrid' " we'll just take the default for now
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
let g:notes_smart_quotes = 0

" let g:clang_library_path = '/Library/Developer/CommandLineTools/usr/lib/libclang.dylib'
let g:deoplete#sources#clang#libclang_path = '/Library/Developer/CommandLineTools/usr/lib/libclang.dylib'

" ctrp lol
map <Leader>C :CtrlPClearCache<CR>
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|vendor'

" vim-surround overrides these
" function SetCScopeMappings()
"     cnoreabbrev csa cs add
"     cnoreabbrev csf cs find
"     cnoreabbrev csg cs find g
"     cnoreabbrev csk cs kill
"     cnoreabbrev csr cs reset
"     cnoreabbrev css cs show
"     cnoreabbrev csh cs help
" endfunction

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
autocmd FileType lisp,clojure set completeopt=longest,menuone
autocmd FileType javascript set shiftwidth=2
autocmd FileType markdown set autoindent
autocmd FileType html,htmldjango,css,yaml set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
autocmd FileType terraform nnoremap <cr> :w<cr>:!/usr/local/bin/terraform fmt %<cr>
" autocmd FileType python nnoremap <cr> :w<cr>:!python3 %:p<cr>
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd BufNewFile,BufReadPost *.asd set filetype=lisp
autocmd BufNewFile,BufReadPost *.boot set filetype=clojure
autocmd BufNewFile,BufReadPost Dockerfile* set filetype=dockerfile
" i'm pretty much never not going to use nasm
autocmd BufNewFile,BufReadPost *.s set filetype=nasm
" crontab complains if backup is set to no or auto
autocmd filetype crontab setlocal nobackup nowritebackup
" Go devs really do the whole line length thing
autocmd filetype go setlocal tw=0

" set tw=90 " Because of Go, I have to do this here. I dunno, lol
" autocmd filetype c,cpp call SetCScopeMappings()
