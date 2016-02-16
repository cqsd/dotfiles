" --------------------- PLUGINS  ---------------------

execute pathogen#infect()
map <C-n> :NERDTreeToggle<CR>
source ~/.neocompleterc
source ~/.rainbow-parensrc
source ~/.vimplainrc

let g:airline_powerline_fonts = 1
set laststatus=2 " Make airline appear all the time
" Fugitive; show current branch
let g:airline_section_y = '%{fugitive#statusline()}'
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" promptline congif; `:PromptlineSnapshot` generates a new .sh to source in
" `.bash_profile` or whatever for nice prompt
let g:promptline_preset = {
        \'a' : [ promptline#slices#host() ],
        \'b' : [ promptline#slices#user() ],
        \'c' : [ promptline#slices#cwd() ],
        \'y' : [ promptline#slices#vcs_branch() ],
        \'z' : [ promptline#slices#python_virtualenv() ],
        \'warn' : [ promptline#slices#last_exit_code() ]}

" Puts all the syntax errors in a split; you should be able to step through
" error by error, and syntastic will jump you the relevant lines.
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" the popup for neocomplete
let g:neocomplete#use_vimproc = 1
let g:neocomplete#disable_auto_complete = 0

" Syntastic shit
 set statusline+=%#warningmsg#
 set statusline+=%{SyntasticStatuslineFlag()}
 set statusline+=%*

" rainbow_parens
let g:rainbow_active = 1

let g:slimv_preferred = 'clozure'
let g:slimv_repl_split = 4
let g:slimv_disable_clojure = 2
" XXX next line is really broken
"let g:slimv_lisp = '"java -cp clojure.jar;clojure-contrib.jar clojure.main"'

" Rust (Racer.vim)
set hidden
let g:race_cmd = "/Users/tpm/.rust_source/racer/target/release/racer"
let $RUST_SRC_PATH="/Users/tpm/.rust_source/rust/src"

" the following lines come courtesy of github user `arnm`
" thread: `https://github.com/phildawes/racer/issues/194`
" jack racer.vim into neocomplete
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.rust =
    \ '[^.[:digit:] *\t]\%(\.\|\::\)\%(\h\w*\)\?'

" ------ Filetype-specific ------
autocmd FileType rust compiler cargo
autocmd FileType lisp set completeopt=longest,menuone
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"autocmd FileType tex compiler pdflatex
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd BufNewFile,BufReadPost *.asd set filetype=lisp
"" Tries to evaluate clj buffers on load for vim-clojure-highlight
"" Broken for some reason; fix later maybe (I don't actually care)
" autocmd BufRead *.clj try | silent! Require | catch /^Fireplace/ | endtry

" For MacVim GUI
set guifont=Hack:h11

set guioptions-=e

if has('gui_running')
  colorscheme solarized
  set background=light
endif
