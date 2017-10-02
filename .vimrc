source ~/.vimplainrc

" --------------------- PLUGINS  ---------------------
execute pathogen#infect()
map <C-n> :NERDTreeToggle<CR>
source ~/.neocompleterc
" source ~/.rainbow-parensrc

let g:airline_powerline_fonts = 1
let g:airline_theme='solarized'
" let g:airline_left_sep='|'
set laststatus=2 " Make airline appear all the time
" Enable the list of buffers and show just the filename
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
" TODO Someday, fix this to just not use airline
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_left_alt_sep = ''
let g:airline_right_alt_sep = ''

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
"
" Puts all the syntax errors in a split; you should be able to step through
" error by error, and syntastic will jump you the relevant lines.
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Make syntastic use python3 for syntax checking
let g:syntastic_python_python_exec = 'python3'
let g:syntastic_python_checkers = ['flake8']

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" for clang_complete
let g:clang_library_path='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/'

" rainbow_parens
" let g:rainbow_active = 1

" let g:slimv_preferred = 'sbcl'
" let g:slimv_preferred = 'clozure'
" let g:slimv_repl_split = 4
" let g:slimv_disable_clojure = 2
" XXX next line is broken
" let g:slimv_lisp = '"java -cp clojure.jar;clojure-contrib.jar clojure.main"'
" let g:paredit_disable_clojure = 0

" vim-slime config (tmux is not default)
" let g:slime_target = "tmux"

" close preview window automatically after autocomplete
autocmd CompleteDone * pclose

" ------ Filetype-specific ------
autocmd FileType lisp set completeopt=longest,menuone
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd BufNewFile,BufReadPost *.asd set filetype=lisp
autocmd BufNewFile,BufReadPost *.boot set filetype=clojure
" crontab complains if backup is set to no or auto
autocmd filetype crontab setlocal nobackup nowritebackup
autocmd filetype c,cpp call SetCScopeMappings()
"" Tries to evaluate clj buffers on load for vim-clojure-highlight
"" Broken for some reason; fix later maybe (I don't actually care)
" autocmd BufRead *.clj try | silent! Require | catch /^Fireplace/ | endtry

command! Figwheel :Piggieback (figwheel-sidecar.repl-api/repl-env)

" MacVim GUI
set guioptions-=e
" set guifont=Inconsolata\ for\ Powerline:h14
set guifont=Hack:h12

if has('gui_running')
  " colorscheme solarized
  " set background=light
  let g:airline_theme='lucius'
endif
