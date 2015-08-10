"------------------------------------------------
" Settings taken from all over the place.
" ~/.vimrc
" Needs cleaning. For a great config  have a look 
" at https://amix.dk/vim/vimrc.html
"------------------------------------------------

" Use vim settings, rather than vi settings.
" This must be first, because it changes other options as a side effect.
set nocompatible

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Enable filetype plugins
filetype on
filetype plugin on
filetype indent on

" Autocommands
au FileType             make set noet
au Filetype             html ab --- &mdash;
au Filetype             html ab </ </<C-X><C-o>
au Filetype             mail set tw=80 fdm=marker
au FileType             c set sw=8 ts=8 sts=8 noet

set omnifunc=syntaxcomplete#Complete
autocmd FileType python     set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html       set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css        set omnifunc=csscomplete#CompleteCSS
autocmd FileType c          set omnifunc=ccomplete#Complete
autocmd FileType cpp        set omnifunc=ccomplete#Complete

" With a map leader it's possible to do extra key combinations
let mapleader = "\<space>"
let g:mapleader = "\<space>"

" Setup Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle'
Plugin 'LaTeX-Box'
Plugin 'The-NERD-tree'
Plugin 'gorodinskiy/vim-coloresque'
Plugin 'Syntastic'
Plugin 'surround.vim'
Plugin 'neocomplcache'
Plugin 'EasyMotion'
Plugin 'itchyny/calendar.vim'
Plugin 'Shougo/neosnippet'
Plugin 'Shougo/neosnippet-snippets'
Plugin 'whatyouhide/vim-gotham'
Plugin 'mhinz/vim-startify'
Plugin 'Townk/vim-autoclose'
Plugin 'luochen1990/rainbow'
Plugin 'ryanss/vim-hackernews'
Plugin 'joshhartigan/vim-reddit'
Plugin 'bling/vim-airline'
Plugin 'SyntaxRange'
Plugin 'vimwiki/vimwiki'
Plugin 'tpope/vim-markdown'
Plugin 'chriskempson/base16-vim'
Plugin 'edkolev/promptline.vim'
Plugin 'bonsaiben/bootstrap-snippets'
Plugin 'honza/vim-snippets'
Plugin 'justinmk/vim-syntax-extra'
Plugin 'pbrisbin/vim-rename-file'
Plugin 'pbrisbin/vim-mkdir'
Plugin 'loremipsum'
Plugin 'chilicuil/vim-sprunge'
Plugin 'majutsushi/tagbar'
call vundle#end()

"NERDTree
let NERDTreeShowHidden=1
map <C-o> :NERDTreeToggle<CR>
map <C-m> :NERDTree<CR>
nmap <silent> <F9> :NERDTreeToggle<CR>
let g:NERDTreeWinSize = 35
" auto quit nerdtree when buffers closed
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Airline
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_theme="base16"
"let g:airline_theme="gotham256"
" let g:airline_theme="badwolf"
let g:airline_powerline_fonts = 1
"let g:airline_left_sep='▶'
"let g:airline_right_sep='◀'

" for some fonts withowt triangles
"let g:airline_left_sep='▓▒░'
"let g:airline_right_sep='░▒▓'
"let g:airline_left_alt_sep='▓▒░'
"let g:airline_powerline_symbols = 'fancy'
" promptline
let g:promptline_preset = {
        \'b': [ promptline#slices#cwd() ],
        \'c': [ promptline#slices#vcs_branch() ],
        \'z': [ promptline#slices#git_status() ],
        \'warn' : [ promptline#slices#last_exit_code() ]}
let g:promptline_theme = 'airline'

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \Line:\ %l

" Neocomplcache
let g:neocomplcache_enable_at_startup = 1

" Neosnippet
" Plugin  neosnippets key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'

" For snippet_complete marker.
"if has('conceal')
"  set conceallevel=2 concealcursor=i
"endif

" Vim-startify
let g:startify_custom_header = 
    \ map(split(system('fortune | cowthink'), '\n'), '" ". v:val') + ['']

" Rainbow parentheses
let g:rainbow_active = 1
let g:rainbow_operators = 1
let g:rainbow_conf = {
\   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
\   'ctermfgs': ['blue', 'yellow', 'cyan', 'magenta'],
\   'operators': '_,_',
\   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\   'separately': {
\       '*': {},
\       'tex': {
\           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
\       },
\       'lisp': {
\           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
\       },
\       'vim': {
\           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
\       },
\       'html': {
\           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
\       },
\       'css': 0,
\   }
\}

" Syntastic

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let g:syntastic_enable_signs = 1
let g:syntastic_enable_balloons = 1
let g:syntastic_enable_highlighting = 1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_check_on_open = 1
let g:syntastic_stl_format = '[%E{%e Errors}%B{, }%W{%w Warnings}]'
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0

" Tagbar
let g:tagbar_usearrows = 1

" LaTeX stuff
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats='pdf, aux'
let g:Tex_ViewRule_ps = 'zathura'
let g:Tex_ViewRule_pdf = 'zathura'
let g:Tex_ViewRule_dvi = 'zathura'
"let g:Tex_CompileRule_pdf = 'pdflatex -synctex=1 -src-specials -interaction=nonstopmode $*'
"let g:Tex_ViewRule_pdf = 'zathura --unique'
"function! SyncTexForward()
"    let s:syncfile = fnamemodify(fnameescape(Tex_GetMainFileName()), ":r").".pdf"
"    let execstr = "silent !zathura --unique ".s:syncfile."\\#src:".line(".").expand("%\:p").' &'
"    exec execstr
"endfunction
"nnoremap <Leader>f :call SyncTexForward()<CR> '


" Keep 1000 lines of command line history
set history=1000

" Set directory to put swap files in
set directory=~/.vim/tmp

" Always switch to the current file directory
set autochdir

" Save all buffers when quitting
set autowriteall

autocmd BufEnter * :syntax sync fromstart
autocmd BufEnter * :set number

" Strip trailing whitespace
nnoremap <Leader>W :%s/\s\+$//<CR>:let @/=""<CR>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
    set mouse=a
endif

"selectmode+=mouse

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
    filetype plugin indent on
    set shellslash

" Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx
    au!

" For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
    autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \ exe "normal! g`\"" |
        \ endif

    augroup END
else
    set autoindent " always set autoindenting on
endif

" Adds line numbers on the left margin.
set number

" Number of spaces that a <Tab> in the file counts for.
set tabstop=4

" Number of spaces to use for each step of (auto)indent.
set shiftwidth=4

" Use the appropriate number of spaces to insert a <Tab>. Spaces are used
" in indents with the '>' and '<' commands and when 'autoindent' is on.
" To insert a real tab when 'expandtab' is on, use CTRL-V <Tab>.
set expandtab

"Highlight the screen line of the cursor
set cursorline

" When on, a <Tab> in front of a line inserts blanks according to 'shiftwidth'
" 'tabstop' is used in other places. A <BS> will delete a 'shiftwidth'
" worth of space at the start of the line.
set smarttab

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines"

set modeline
set modelines=4

" Makes h, l keys wrap around lines, as they should
set whichwrap+=<,>,h,l

" Show (partial) command in status line.
set showcmd

" Show the matching braces when highlighted by the cursor
set showmatch

" When there is a previous search pattern, highlight all its matches.
set hlsearch

" While typing a search command, show immediately where the so far typed
" pattern matches.
set incsearch

" Ignore case in search patterns.
set ignorecase

" Override the 'ignorecase' option if the search pattern contains upper case
" characters.
set smartcase

" Copy indent from current line when starting a new line (typing <CR> in Insert
"" mode or when using the "o" or "O" command).
set autoindent

" Show the line + column number of the cursor position, separated by a comma.
set ruler

" Change buffers without saving
set hidden

" No error bells
set noerrorbells
set tm=500

" Turn on command line completition wild style
set wildmenu

" Turn on wild mode huge list
set wildmode=list:longest

" You've got a fast terminal
set ttyfast

" For regular expressions turn magic on
set magic

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Colorscheme
"set t_Co=256
" When set to "dark", Vim will try to use colors that look good on a dark
" background. When set to "light", Vim will try to use colors that look
" good on a light background. Any other value is illegal.
" possibilities: Mustang, astronaut, darkburn, desert256, gentooish?
" herald, jellybeans, molokai, desertEx, matrix, wombat, wombat256, zenburn,

set background=dark
"colorscheme gotham256
"colorscheme molokai-transparent
"colorscheme seti
"colorsheme base16-grayscale
let base16colorspace=256
colorscheme base16-summerfruit

" Transparent background
hi Normal ctermbg=NONE
highlight NonText ctermbg=none
hi Comment ctermbg=NONE
hi Constant ctermbg=NONE
hi Special ctermbg=NONE
hi Identifier ctermbg=NONE
hi Statement ctermbg=NONE
hi PreProc ctermbg=NONE
hi Type ctermbg=NONE
hi Underlined ctermbg=NONE
hi Todo ctermbg=NONE
hi String ctermbg=NONE
hi Function ctermbg=NONE
hi Conditional ctermbg=NONE
hi Repeat ctermbg=NONE
hi Operator ctermbg=NONE
hi Structure ctermbg=NONE


" Add a vertical column at line 80
set colorcolumn=80

" Let vim display unicode reasonably.
set encoding=utf-8
set fileencoding=utf-8

" Set to auto read when a file is changed from the outside
set autoread

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Insert current date and time
nnoremap <leader>d "=strftime("%d %b, %Y %X")<CR>p
nnoremap <leader>D "=strftime("%d %b, %Y")<CR>P

" Split file combos:
"open a new split and switch to it
nnoremap <leader>s <C-w>v<C-w>l

"Move around splits using leader-hjkl
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

" Tab switching with leader tp, tn
nmap <leader>tp :tabprevious<CR>
vmap <leader>tp :tabprevious<CR>
nmap <leader>tn :tabnext<CR>
vmap <leader>tn :tabnext<CR>

" Create new tab with leader to
nmap <leader>to :tabnew<CR>
vmap <leader>to :tabnew<CR>
imap <leader>to <esc>:tabnew<CR>i

" Press leader pp on insert to go into paste mode
nnoremap <leader>pp :set invpaste paste?<CR>
set pastetoggle=<leader>pp
set showmode

" Fast saving
nmap <leader>w :w!<cr>

" Toggle tagbar
nnoremap <leader>ž :TagbarToggle<CR>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

" Close buffer
map <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>

" Treat long lines as break lines (useful when moving)
map j gj
map k gk
noremap <Up> g<Up>
noremap <Down> g<Down>

" Show tabs and trailing spaces, toggle with F6
noremap <F6> :set list!<CR>
set list listchars=tab:»-,nbsp:·,eol:¶,trail:§
autocmd filetype html,xml,txt set listchars-=tab:»-,nbsp:·,eol:¶,trail:§

" Remember info about open buffers on close
set viminfo^=%

source ~/.vim/ftplugin/zsh.vim
source ~/.vim/ftplugin/htmldjango.vim

" upload to sprunge.us (without range, upload the whole file)
command! -range=% Sprunge <line1>,<line2>w !curl -F 'sprunge=<-'http://sprunge.us

inoremap šđ <esc>
inoremap đš <esc>

" vim:fenc=utf-8:nu:ai:si:et:ts=4:sw=4:ft=vim
