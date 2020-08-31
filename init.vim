source ~/.vimrc
" nvim needs python3. you gotta set this up yourself
" also jedi won't work if you don't expand, so.
let g:python3_host_prog=expand('~/.venvs/nvim/bin/python3')

"  initialize vim-plug...
call plug#begin('~/.vim/bundle')
Plug 'ctrlpvim/ctrlp.vim'
Plug 'Shougo/vimproc.vim' " consider building vimproc here with 'do':...
Plug 'tpope/vim-surround'
Plug 'Shougo/deoplete.nvim'
Plug 'scrooloose/syntastic'
Plug 'henrik/vim-indexed-search'
Plug 'xolox/vim-misc'
Plug 'tpope/vim-fugitive'

" = lang-specific, enable as necessary
" = python
Plug 'davidhalter/jedi-vim'
Plug 'zchee/deoplete-jedi'
Plug 'vim-python/python-syntax' " updates fstring highlighting

" = ruby
Plug 'vim-ruby/vim-ruby'

" = C/C++
Plug 'zchee/deoplete-clang'
" Plug 'xavierd/clang_complete' " this is good too

" = clojure
" Plug 'guns/vim-clojure-static'
Plug 'tpope/vim-fireplace'

" = haskell
" Plug 'eagletmt/ghcmod-vim'
" Plug 'neovimhaskell/haskell-vim'
" Plug 'eagletmt/neco-ghc'

" = php
Plug 'StanAngeloff/php.vim'

" = golang
Plug 'zchee/deoplete-go'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" = js
Plug 'moll/vim-node' " gf on requires to open appropriate file if local (?)
Plug 'mxw/vim-jsx'
Plug 'leafgarland/typescript-vim'

" = elixir
Plug 'elixir-editors/vim-elixir'
Plug 'slashmili/alchemist.vim'

" = rust
" Plug 'racer-rust/vim-racer'

" = misc
" Plug 'zah/nim.vim'
Plug 'dag/vim-fish'
Plug 'lervag/vimtex'
Plug 'hashivim/vim-terraform'
Plug 'uarun/vim-protobuf'
Plug 'jparise/vim-graphql'

" kinda useless
Plug 'scrooloose/nerdtree'
Plug 'bling/vim-airline' " TODO please just rewrite the statusline

call plug#end() " NOTE you'll need a :PlugInstall the first time

map <C-n> :NERDTreeToggle<CR>
if has('nvim')
    let g:deoplete#enable_at_startup = 1
    " TODO I need like a .plugins.vim for all the plugin config instead of
    " putting it in main vim config
    " source ~/.deocompleterc
    " use tab for deocomplete
    inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
    " yeah definitely time to split out into deoplete's own config file
    call deoplete#custom#option({
    \ 'enable_smart_case': 1,
    \ 'omni_patterns': { 'go': '[^. *\t]\.\w*' },
    \ })

    " highlight python>=3.6 fstrings
    " strike that, actually just turn on all the features why not
    " it seems to pretty much replace built in python support + adds the
    " missing stuff so no harm afaict
    let g:python_highlight_all = 1
else
    source ~/.neocompleterc
endif

colorscheme default
set background=light  " TODO

let g:airline_powerline_fonts = 0
set laststatus=2 " Make airline appear all the time
" Enable the list of buffers and show just the filename
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
" TODO Someday, fix this to just not use airline
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_left_alt_sep = ''
let g:airline_right_alt_sep = ''

" XXX unused
let g:notes_directories = ['~/notes']
let g:notes_smart_quotes = 0

" let g:clang_library_path = '/Library/Developer/CommandLineTools/usr/lib/libclang.dylib'
let g:deoplete#sources#clang#libclang_path = '/Library/Developer/CommandLineTools/usr/lib/libclang.dylib'
let g:deoplete#sources#clang#clang_header = '/Library/Developer/CommandLineTools/usr/lib/clang/'
let g:deoplete#sources#clang#flags = [
    \ "-DDEBUG",
    \ "-isystem", "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include"
    \ ]

map <Leader>C :CtrlPClearCache<CR>
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|vendor'

" golang shit
let g:go_fmt_autosave = 1
let g:go_fmt_fail_silently = 0

" Syntastic
" Put all the syntax errors in the location list
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

" this is basically user-facing syntastic metaprogramming hax
" see :help syntastic-config-makeprg
let g:syntastic_python_python_exec = 'python3'
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args='--ignore=E221,E266,E501'

let g:syntastic_typescript_checkers = ['eslint']
" use eslint_d.js (which runs an eslint daemon---wild!)
let g:syntastic_typescript_eslint_exec = 'eslint_d'
let g:syntastic_typescript_eslint_args='--ext .ts'

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" close preview window automatically after autocomplete
autocmd CompleteDone * pclose

" ------ Filetype-specific ------
autocmd FileType lisp,clojure set completeopt=longest,menuone
autocmd FileType javascript,typescript set shiftwidth=2
autocmd FileType markdown set autoindent
autocmd FileType html,htmldjango,css,yaml set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
" mapping to just <CR> breaks syntastic (cause it tries to save the scratch
" buffer) so switch to leader (f for format?)
autocmd FileType terraform nnoremap <Leader>f :w<cr>:!/usr/local/bin/terraform fmt %<cr>:e!<cr>
autocmd FileType go nnoremap <Leader>f :GoFmt<cr>
autocmd FileType go nnoremap <Leader>r :GoRun<cr>
autocmd FileType go nnoremap <Leader>b :GoBuild<cr>
" unquote resource definitions
autocmd FileType terraform nnoremap <Leader>q :%s/^\(resource\|data\) \+\"\?\(.*\)\"\? \+\"\(.*\)\" \+{/\1 \2 \3 {/g<cr>:w<cr>:e!<cr>
autocmd FileType python nnoremap <Leader>R :w<cr>:!python3 %:p<cr>
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
