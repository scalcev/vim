filetype plugin on 
filetype indent on

" Enable syntax highlighting
syntax on

" Set line numbering options
" Show the line number relative to the line
set relativenumber 
" Set code folding options
set fdm=syntax
set nofoldenable
" Set indentation options
set softtabstop=4
set tabstop=4
set shiftwidth=4
set shiftround
set expandtab
set smarttab
set autoindent
set ignorecase
" Only if in grapphics mode?"
set clipboard=exclude:.*
set nocscopeverbose " suppress 'duplicate connection' error
set scrolloff=1
" Delete comment character when joining commented lines
set formatoptions+=j
"set cryptmethod=blowfish2

" Set search options
set ignorecase

" Override 'ignorecase' option if search pattern contains upper case characters
set smartcase

" When there is a previous search pattern, highlight all its matches.
set hlsearch
set hidden
set gdefault
" Incremental search
set incsearch

set scrolloff=1
set wildmenu

" make completion bash-like
set wildmode=longest,list,full
colorscheme desert

" http://vim.wikia.com/wiki/VimTip906
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
" See https://github.com/scrooloose/nerdtree/issues/108
set encoding=utf-8

" Auto-indent entire file (and return to current line)
nnoremap <F7> mzgg=G`z<CR>

nnoremap gr :grep <cword> *<CR>
nnoremap Gr :grep <cword> %:p:h/*<CR>
nnoremap gR :grep '\b<cword>\b' *<CR>
nnoremap Gr :grep '\b<cword>\b' %:p:h/*<CR>

nnoremap <F9> :bn<cr>
nnoremap <F10> :bp<cr> 

inoremap ( ()<Esc>i
inoremap { {}<Esc>i
inoremap [ []<Esc>i
inoremap " ""<Esc>i
inoremap ' ''<Esc>i
inoremap ` ``<Esc>i
inoremap jk <Esc>
inoremap <Esc> <nop>
" Map Ctrl-C to the escape key since Escape generate the InsertLeave event
" while Ctrl-C doesn't'"
inoremap <c-c> <esc>

" http://www.terminally-incoherent.com/blog/2012/04/02/nifty-vim-tricks/
" Insert blank lines without entering insert mode
nnoremap <silent> <leader>o o<ESC>
nnoremap <silent> <leader>O O<ESC>

onoremap p i(
onoremap q i'

set statusline=%f\ -\ FileType:\ %y\ %l/%L

let g:ctrlp_map='<c-p>'
let g:ctrlp_cmd='CtrlP'
let g:ctrlp_custom_ignore='deps\|ResolveDeps'
let g:ctrlp_max_files=0
let g:ctrlp_match_func={'match' : 'matcher#cmatch' }
let g:ctrlp_clear_cache_on_exit=0

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

if has("lua")
    let g:neocomplete#enable_at_startup = 1
endif

let g:powerline_loaded = 1

let g:pymode_rope = 0
let g:pymode_rope_lookup_project = 0
let g:pymode_rope_complete_on_dot = 0

" See http://stackoverflow.com/questions/5700389/using-vims-persistent-undo
let vimDir = '$HOME/.vim'
let &runtimepath.=','.vimDir

" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
    let myUndoDir = expand(vimDir . '/undodir')
    " Create dirs
    call system('mkdir ' . vimDir)
    call system('mkdir ' . myUndoDir)
    let &undodir = myUndoDir
    set undofile
endif

if !exists("autocommands_loaded")
    let autocommands_loaded = 1

    autocmd FileType python setlocal foldmethod=indent
    autocmd FileType python setlocal textwidth=79 " PEP-8 Friendly
    autocmd FileType python iabbrev & and
    autocmd FileType python iabbrev && and
    autocmd FileType cucumber setlocal shiftwidth=2

    autocmd FileType c,cpp,java,scala inoremap { {<CR>}<Esc>O
    autocmd FileType html inoremap < <><Esc>i
    autocmd FileType xml inoremap < <><Esc>i

    " When editing a file, always jump to the last cursor position
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line ("'\"") <= line("$") |
                \   exe "normal! g'\"" |
                \ endif

    " http://www.vex.net/~x/python_and_vim.html
    "autocmd FileType python set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
    autocmd FileType make set noexpandtab

    autocmd FileType xml              compiler xmlwf
    autocmd BufWritePost *.xml make %

    autocmd BufNewFile *.py 0read ~/.vim/skeleton.py
    autocmd BufNewFile *.c 0read ~/.vim/skeleton.c
    autocmd BufNewFile *.cpp 0read ~/.vim/skeleton.cpp
    autocmd BufNewFile *.sh 0read ~/.vim/skeleton.sh
    autocmd BufNewFile *.xsd 0read ~/.vim/skeleton.xsd
    autocmd BufNewFile *.html 0read ~/.vim/skeleton.html

    autocmd BufWritePost *.sh call SetExecutableBit()
    autocmd BufWritePost *.py call SetExecutableBit()

    autocmd BufNewFile,BufRead *.gdb set filetype=python

    " Enable doxygen highlighting for C/C++
    autocmd FileType c,cpp set syntax=cpp.doxygen

    " vim -b : edit binary using xxd-format!
    augroup Binary
      au!
      au BufReadPre  *.bin let &bin=1
      au BufReadPost *.bin if &bin | %!xxd
      au BufReadPost *.bin set ft=xxd | endif
      au BufWritePre *.bin if &bin | %!xxd -r
      au BufWritePre *.bin endif
      au BufWritePost *.bin if &bin | %!xxd
      au BufWritePost *.bin set nomod | endif
    augroup END

    augroup filetype_vim
        autocmd!
        autocmd FileType vim setlocal foldmethod=marker
    augroup END
endif

"let g:NERDTreeDirArrows=0
set encoding=utf-8

" See http://vimcasts.org/episodes/the-edit-command/
let mapleader=','
nnoremap <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <leader>b :call BehaveYourself()<CR>
nnoremap <leader>rm :call RunResMan()<CR>
" Uncomment next line to uncomment entries in kernel configuration files
nnoremap <SPACE> ^2xwd$xa=y<ESC>
"nnoremap <SPACE> ^i# <ESC>wd$a is not set<ESC>

" See http://www.pinkjuice.com/howto/vimxml/moretasks.xml
nnoremap <leader>x :make %

nnoremap <leader>m :MRU <CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" http://vim.wikia.com/wiki/Search_and_replace_the_word_under_the_cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

nnoremap <leader>vg :vimgrep <cword> <C-R>=expand("%:p:h") . "/*" <CR>

" Recursively search for word under cursor
nnoremap <leader>ag :ack <cword> <C-R>=expand("%:p:h")<CR>

" Shortcut to rapidly toggle `set list`
nnoremap <leader>l :set list!<CR>
"Invisible character colors 
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

" Shortcut to rapidly toggle `set nu`
nnoremap <leader>n :call ToggleLinesNos()<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:?\ ,eol:¬
if has('gui_running')
    set guioptions-=T  " no toolbar
    colorscheme elflord
endif

" Buffers - explore/next/previous: Alt-F12, F12, Shift-F12.
nnoremap <silent> <M-F12> :BufExplorer<CR>
nnoremap <silent> <F12> :bn<CR>
nnoremap <silent> <S-F12> :bp<CR>

set laststatus=2
"set path+=$CDPATH

set path+=steps,suites/hip,gherkin/steps,gherkin/suites/hip
set suffixesadd=.feature

" Replace word with contents of yank register without changing the contents of
" default register
nnoremap <leader>r _cw<C-R>0<Esc>

" Avoid need to shift
nnoremap : <nop>
nnoremap ; :

if has('win32')
  nnoremap ,cs :let @*=substitute(expand("%"), "/", "\\", "g")<CR>
  nnoremap ,cl :let @*=substitute(expand("%:p"), "/", "\\", "g")<CR>

  " This will copy the path in 8.3 short format, for DOS and Windows 9x
  nnoremap ,c8 :let @*=substitute(expand("%:p:8"), "/", "\\", "g")<CR>
else
  nnoremap ,cs :let @*=expand("%")<CR>
  nnoremap ,cl :let @*=expand("%:p")<CR>
endif

nnoremap <up> nop
nnoremap <down> nop
nnoremap <left> nop
nnoremap <right> nop

execute pathogen#infect()

" See http://vim.wikia.com/wiki/Cscope
if has('cscope')
    "set cscopetag cscopeverbose

    if has('quickfix')
        set cscopequickfix=s-,c-,d-,i-,t-,e-
    endif

    cnoreabbrev csa cs add
    cnoreabbrev csf cs find
    cnoreabbrev csk cs kill
    cnoreabbrev csr cs reset
    cnoreabbrev css cs show
    cnoreabbrev csh cs help

    "command -nargs=0 Cscope cs add $VIMSRC/src/cscope.out $VIMSRC/src
endif

function! ToggleLinesNos()
    let &number = !&number
    let &relativenumber = !&relativenumber
endfunction

function! BehaveYourself()
    let highlighting=&hlsearch

    if highlighting
        set nohlsearch
    endif

    " set a mark so that we can return to the same cursor position later
    execute "normal! mZ"

    let current=expand("<cword>")
    echom current

    if expand("<cword>") != "@"
        " Find previous @
        execute "normal! ?@\<cr>"
    endif

    execute "normal! l"

    if highlighting
        set nohlsearch
    endif

    " return cursor to its original position
    execute "normal! 'Z"

    let result=system("behave --logging-level ERROR " . @% . " -t " . expand("<cword>"))

    execute "rightbelow split __behave_output__"
    normal! ggdG
    setlocal buftype=nofile

    call append(0, split(result, "\n"))
endfunction

"function! CallResMan()
function! RunResMan()
    let result=system("cd ..;./l3_run_resman.sh eu-q-vstb-uk-hip -f gherkin -s hip -c -e pstb_only -i " . expand("<cword>") . " -b $HOME/eu-q-vstb-uk-hip/flash0/;cd -")

    split __behave_output__
    normal! ggdG
    setlocal buftype=nofile
    wincmd r

    call append(0, split(result, "\n"))
endfunction

" See http://stackoverflow.com/questions/8965497/how-do-i-append-a-list-to-a-file-in-vim
" Version working with file *possibly* containing trailing newline
function! AppendToFile(file, lines)
    let fcontents=readfile(a:file, 'b')
    if !empty(fcontents) && empty(fcontents[-1])
        call remove(fcontents, -1)
    endif
    call writefile(fcontents+a:lines, a:file)
endfunction

function! Hijack(...)
    let hijacked=$HOME . "/.hijacked"
    if a:0 == 0
        let expr="%:p"
    else
        let expr=a:1
    endif
    let name=expand(expr)
    let list=split(name)
    if filereadable(hijacked)
        call AppendToFile(hijacked, list)
    else
        call writefile(list, hijacked)
    endif
endfunction

function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction

au FileType qf call AdjustWindowHeight(3, 10)

" See http://vim.wikia.com/wiki/Autoloading_Cscope_Database
function! LoadCscope()
    "let db = findfile("cscope.out", ".;")
    let db = findfile("cscope.out", ";")
    if (!empty(db))
        let path = strpart(db, 0, match(db, "/cscope.out$"))
        set nocscopeverbose " suppress 'duplicate connection' error
        exe "cscope add " . db . " " . path
        set cscopeverbose
    endif
endfunction
"au BufEnter /* call LoadCscope()
call LoadCscope()

function! SetExecutableBit()
  let fname = expand("%:p")
  checktime
  execute "au FileChangedShell " . fname . " :echo"
  silent !chmod a+x %
  checktime
  execute "au! FileChangedShell " . fname
endfunction
command! Xbit call SetExecutableBit()
