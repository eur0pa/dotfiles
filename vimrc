syntax on
filetype indent on
filetype plugin on

set hidden
set history=4000
set cryptmethod=blowfish2
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set autoindent
set laststatus=2
set showmatch
set incsearch
set hlsearch
set ignorecase smartcase       " make searches case-sensitive only if they contain upper-case characters
set cursorline
set switchbuf=useopen
set number
set numberwidth=5
set backspace=indent,eol,start
set showcmd                    " display incomplete commands
set nocompatible               " be iMproved
set fileformats=unix,dos,mac   " support all three, in this order
set foldmethod=manual
set foldlevel=7
set tags=tags;
set mouse=a

" Force terminal to 256 colors
"set t_Co=256
" http://vim.wikia.com/wiki/VimTip102
set omnifunc=syntaxcomplete#Complete
inoremap <tab> <c-r>=Smart_TabComplete()<CR>

" Clear highlighting on escape in normal mode
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[

" Ctrl+H opens hex edit mode
nnoremap <c-h> :%!xxd<cr>

" gui colors if running iTerm
if $TERM_PROGRAM =~ "iTerm"
    set termguicolors
endif

" Use tabs with Ctrl and arrow keys, Ctrl+n to open a new tab, and Ctrl+w to
" close it
map <C-up> :tabr<cr>
map <C-down> :tabl<cr>
map <C-left> :tabp<cr>
map <C-right> :tabn<cr>
"map <C-m> :tabnew<cr>
map <C-w> :tabclose<cr>

" Ctrl-D opens a shell.
nmap <silent> <C-D> :shell<CR>

if has("gui_running")
    " setup for gui
    set guioptions-=r  " no scrollbar on the right
    set guioptions-=l  " no scrollbar on the left
    set guioptions-=m  " no menu
    set guioptions-=T  " no toolbar
    set guioptions-=L

    "if has("gui_gtk2")
    "    set guifont=Inconsolata\ 9
    "elseif has("gui_win32")
    "    set guifont=Consolas:h11:cANSI
    "else
    "    set guifont=Monaco_for_Powerline\ 9
    "endif
endif

" reload files as they change
set autoread
augroup checktime
    au!
    if !has("gui_running")
        "silent! necessary otherwise throws errors when using command
        "line window.
        autocmd BufEnter        * silent! checktime
        autocmd CursorHold      * silent! checktime
        autocmd CursorHoldI     * silent! checktime
        "these two _may_ slow things down. Remove if they do.
        autocmd CursorMoved     * silent! checktime
        autocmd CursorMovedI    * silent! checktime
    endif
augroup END

" set theme
set background=dark
colorscheme hybrid

" force two spaces indentation for some files
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd Filetype eruby setlocal ts=2 sts=2 sw=2
autocmd FileType python setlocal ts=2 sts=2 sw=2
autocmd FileType java setlocal ts=2 sts=2 sw=2
autocmd FileType sh setlocal ts=2 sts=2 sw=2
autocmd FileType bash setlocal ts=2 sts=2 sw=2

" tagbar
autocmd FileType go nested :TagbarOpen
autocmd FileType python nested :TagbarOpen
autocmd Filetype ruby nested :TagbarOpen
autocmd FileType sh nested :TagbarOpen

" go build and test
autocmd FileType go nmap <F5> :GoBuild<CR>
autocmd FileType go nmap <F6> :GoTest<CR>

augroup vimrc_autocmds
    autocmd!
    " highlight characters past column 180
    autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python match Excess /\%180v.*/
    autocmd FileType python set nowrap
augroup END

augroup filetypedetect
    au BufRead,BufNewFile *.zr set filetype=c
    au BufRead,BufNewFile *.yy set filetype=cpp
    au BufRead,BufNewFile *.rl set filetype=cpp
augroup END

" By pressing Ctrl + R in the visual mode you will be prompted to enter text to replace with.
" Press enter and then confirm each change you agree with 'y' or decline with 'n'.
" This command will override your register 'h' so you can choose other one
" ( by changing 'h' in the command above to other lower case letter ) that you don't use.
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" Initialize vundle runtime
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"
" PLUGINS
"

" Vundle package
Plugin 'VundleVim/Vundle.vim'


" A file tree explorer
Plugin 'scrooloose/nerdtree'
    " Ctrl+d to toggle NerdTree
    " nmap <silent> <C-D> :NERDTreeToggle<CR>
    " Open it on vim startup
    autocmd VimEnter * NERDTree
    " Mirror tree position for every buffer
    autocmd BufEnter * NERDTreeMirror
    " Go to previous (last accessed) window ( move focus to file buffer
    " instead of the tree itself).
    autocmd VimEnter * wincmd p
    " Close nerdtree when it's the only buffer left open
    autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()
    " Change dir to the dir of the new root
    let NERDTreeChDirMode = 2
    " Single click to open files and expand folders.
    let NERDTreeMouseMode = 3
    " Display hidden files
    " let NERDTreeShowHidden=1
    " Do not display these files
    " let NERDTreeIgnore=['\.DS_Store', '\~$', '\.swp']
    let NERDTreeRespectWildIgnore=1

Plugin 'octref/RootIgnore'
    let loaded_netrwPlugin=1


" GIT support for NERDTree
Plugin 'Xuyuanp/nerdtree-git-plugin'
    let g:NERDTreeIndicatorMapCustom = {
        \ "Modified"  : "✹",
        \ "Staged"    : "✚",
        \ "Untracked" : "✭",
        \ "Renamed"   : "➜",
        \ "Unmerged"  : "═",
        \ "Deleted"   : "✖",
        \ "Dirty"     : "✗",
        \ "Clean"     : "✔︎",
        \ "Unknown"   : "?"
        \ }

" lightweight powerline
Plugin 'vim-airline/vim-airline'
    " Use powerline symbols
    let g:airline_powerline_fonts = 0

" Sublime/Atom multi cursor selection ( CTRL+n ).
Plugin 'terryma/vim-multiple-cursors'

" C+p fuzzy search
Plugin 'kien/ctrlp.vim'

" Vim for Go
Plugin 'fatih/vim-go'
    let g:autowrite = 1
    let g:go_fmt_autosave = 1
    let g:go_highlight_types = 1    
    let g:go_highlight_fields = 1
    let g:go_highlight_functions = 1
    let g:go_highlight_function_calls = 1
    let g:go_highlight_operators = 1
    let g:go_highlight_extra_types = 1
    let g:go_highlight_build_constraints = 1
    let g:go_metalinter_autosave = 1
    "let g:go_auto_type_info = 1
    "let g:go_auto_sameids = 1
    let g:go_list_type = "quickfix"
    let g:go_fmt_command = "goimports"
    let g:go_addtags_transform = "camelcase"
    let g:tagbar_ctags_bin = "/usr/local/bin/ctags"
    map <C-n> :cnext<CR>
    map <C-m> :cprevious<CR>
    nnoremap <leader>a :cclose<CR>
    " run :GoBuild or :GoTestCompile based on the go file
    function! s:build_go_files()
      let l:file = expand('%')
      if l:file =~# '^\f\+_test\.go$'
        call go#test#Test(0, 1)
      elseif l:file =~# '^\f\+\.go$'
        call go#cmd#Build(0)
      endif
    endfunction
    autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
    autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
    autocmd FileType go nmap <leader>r <Plug>(go-run)
    

" TagBar
Plugin 'majutsushi/tagbar'

" Proper autocomplete
Plugin 'Shougo/neocomplete.vim'
    " Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
    " Disable AutoComplPop.
    let g:acp_enableAtStartup = 0
    " Use neocomplete.
    let g:neocomplete#enable_at_startup = 1
    " Use smartcase.
    let g:neocomplete#enable_smart_case = 1
    " Set minimum syntax keyword length.
    let g:neocomplete#sources#syntax#min_keyword_length = 3

    " Define dictionary.
    let g:neocomplete#sources#dictionary#dictionaries = {
        \ 'default' : '',
        \ 'vimshell' : $HOME.'/.vimshell_hist',
        \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

    " Define keyword.
    if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns['default'] = '\h\w*'

    " Plugin key-mappings.
    inoremap <expr><C-g>     neocomplete#undo_completion()
    inoremap <expr><C-l>     neocomplete#complete_common_string()

    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
      return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
      " For no inserting <CR> key.
      "return pumvisible() ? "\<C-y>" : "\<CR>"
    endfunction
    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
    " Close popup by <Space>.
    "inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

    " AutoComplPop like behavior.
    "let g:neocomplete#enable_auto_select = 1

    " Shell like behavior(not recommended).
    "set completeopt+=longest
    "let g:neocomplete#enable_auto_select = 1
    "let g:neocomplete#disable_auto_complete = 1
    "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

    " Enable heavy omni completion.
    if !exists('g:neocomplete#sources#omni#input_patterns')
      let g:neocomplete#sources#omni#input_patterns = {}
    endif
    "let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
    "let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
    "let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

    " For perlomni.vim setting.
    " https://github.com/c9s/perlomni.vim
    let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
    " Ending vundle runtime
call vundle#end()

filetype plugin indent on


"
" FUNCTIONS
"

" http://vim.wikia.com/wiki/VimTip102
function! Smart_TabComplete()
  let line = getline('.')                         " current line

  let substr = strpart(line, -1, col('.'))        " from the start of the current
                                                  " line to one character on
                                                  " the cursor
  let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
  if (strlen(substr)==0)                          " nothing to match on empty string
    return "\<tab>"
  endif
  let has_period = match(substr, '\.') != -1      " position of period, if any
  let has_slash = match(substr, '\/') != -1       " position of slash, if any
  if (!has_period && !has_slash)
    return "\<C-X>\<C-P>"                         " existing text matching
  elseif ( has_slash )
    return "\<C-X>\<C-F>"                         " file matching
  else
    return "\<C-X>\<C-O>"                         " plugin matching
  endif
endfunction


" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
function! s:CloseIfOnlyNerdTreeLeft()
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      if winnr("$") == 1
        q
      endif
    endif
  endif
endfunction

" https://coderwall.com/p/if9mda/automatically-set-paste-mode-in-vim-when-pasting-in-insert-mode
function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

" inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()


" custom commands
"

" delete urls starting with a 2-letters country codes
" useful to trim down long lists of retrieved subdomains
:command DelCC :%g/^\(\(https\?:\/\/\)\?\|\(\w\.\)\?\)\(a[cd-gilmo-uwxz]\|b[abd-jl-oq-tv-z]\|c[acdf-ik-prsu-z]\|d[aejkmoyz]\|e[ace-hl-npr-wz]\(-mx\|-us\|-gb\)\?\|f[i-morx]\|g[a-il-np-uwy]\|h[ekmnrtu]\|i[b-el-oq-t]\|j[aemop]\|k[eg-im-prwyz]\|l[a-cfikr-vy]\|m[ac-hk-z]\|n[ace-gilopruz]\|o[am]\|p[ae-ik-nr-twy]\|qa\|r[a-cehil-psuw]\|s[a-or-uvx-z]\|t[acdf-hj-ortvwz]\|u[agknsyz]\|v[aceginu]\|w[fglosv]\|y[etv]\|z[ahmw]\(-t\|-cn\)\?\)[\.\-]/d

" execute current file with F9
nnoremap <F9> :!%:p<Enter>
