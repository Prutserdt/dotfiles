" ~/.vimrc
"       _                    
"__   _(_)_ __ ___  _ __ ___ 
"\ \ / / | '_ ` _ \| '__/ __|
" \ V /| | | | | | | | | (__ 
"(_)_/ |_|_| |_| |_|_|  \___|
"       Modified by Prutserdt
"
set nocompatible              " Don't try to be vi compatible
filetype off                  " Helps plugins to load correctly in case of errors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugged plugin manager. :PlugList :PlugInstall :PlugUpdate
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')     " start plugged section, about plugins, managed by plug
Plug 'godlygeek/tabular'              " Select visually, enter :Tab /=, to analign to = character
Plug 'frazrepo/vim-rainbow'           " Colored Parentheses
Plug 'preservim/nerdtree'             " Nerdtree
Plug 'itchyny/lightline.vim'          " Lightline statusbar
Plug 'ap/vim-css-color'               " Shows color of css color coding in vim: yellow, 503fa9
Plug 'neoclide/coc.nvim', {'branch': ',()release'} " Conquer of Completion plugin, autocomplete!
                                      ":CocInstall coc-python
                                      ":CocInstall py-right
Plug 'joshdick/onedark.vim'           " Color scheme
Plug 'machakann/vim-highlightedyank/' " Highlight yanked text
"Plug 'sainnhe/gruvbox-material'      " Gruvbox color schemes, with several options
"Plug 'puremourning/vimspector'       " vimspector, debugging of multiple programming languages
call plug#end()                       " End of the plugged section
""""""""""""""""""""""""""""""  Configuration of the statubar plugin lightline
"let g:lightline = {'colorscheme' : 'gruvbox_material'}
let g:lightline = {'colorscheme' : 'onedark'}
""""""""""""""""""""""""""""""  Configuration of plugin vim-rainbow. Otherwise plugin make vim super slow! 
let g:rainbow_active = 1
let g:rainbow_load_separately = [
    \ [ '*' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.cpp' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.{html,htm,xml}' , [['(', ')'], ['\[', '\]'], ['{', '}'], ['<\a[^>]*>', '</[^>]*>']] ],
    \ ]
let g:rainbow_guifgs = ['RoyalBlue3', 'DarkOrange3', 'DarkOrchid3', 'FireBrick']
let g:rainbow_ctermfgs = ['lightblue', 'lightgreen', 'yellow', 'red', 'magenta']
let &t_SI = "\<Esc>]12;red\x7"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           Non-Plugin stuff
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set cursorline           " I like it but it leads to unacceptable slowdown of vim....
"set cursorcolumn         " I like it but it leads to unacceptable slowdown of vim....
set number relativenumber " Set current line to 0 but show actual line number!
set t_Co=256              " Use 256 colours (Use this setting only if your terminal supports 256 colours)
set noshowmode            " Uncomment to prevent non-normal modes showing in powerline and below powerline.
set tabstop=4             " Number of spaces that a <Tab> in the file counts for.
set shiftwidth=4          " Number of spaces to use for each step of (auto)indent.
set expandtab             " Use the appropriate number of spaces to insert a <Tab>.
                          " Spaces are used in indents with the '>' and '<' commands
                          " and when 'autoindent' is on. To insert a real tab when
                          " 'expandtab' is on, use CTRL-V <Tab>.
set smarttab              " When on, a <Tab> in front of a line inserts blanks
                          " according to 'shiftwidth'. 'tabstop' is used in other
                          " places. A <BS> will delete a 'shiftwidth' worth of space
                          " at the start of the line.
set showcmd               " Show (partial) command in status line.
set laststatus=2          " Always show statusline
set number                " Show line numbers.
set showmatch             " When a bracket is inserted, briefly jump to the matching
                          "rch  one. The jump is only done if the match can be seen on the
                          " screen. The time to show the match can be set with
                          " 'matchtime'.
set hlsearch              " When there is a previous search pattern, highlight all
                          " its matches.
set incsearch             " While typing a search command, show immediately where the
                          " so far typed pattern matches.
set ignorecase            " Ignore case in search patterns.
set smartcase             " Override the 'ignorecase' option if the search pattern
                          " contains upper case characters.
set backspace=2           " Influences the working of <BS>, <Del>, CTRL-W
                          " and CTRL-U in Insert mode. This is a list of items,
                          " separated by commas. Each item allows a way to backspace
                          " over something.
set updatetime=50         " default is 4000 ms, that's way too long for diagnostic messages (coc)
set smartindent           " Automated indenting, should work especially in C
set textwidth=79          " Maximum width of text that is being inserted.
set formatoptions=c,q,r,t " This is a sequence of letters which describes how
                          " automatic formatting is to be done.
                          " letter    meaning when present in 'formatoptions'
                          " ------    ---------------------------------------
                          " c         Auto-wrap comments using textwidth, inserting
                          " the current comment leader automatically.
                          " q         Allow formatting of comments with 'gq'.
                          " r         Automatically insert the current comment leader
                          " after hitting <Enter> in Insert mode.
                          " t         Auto-wrap text using textwidth (does not apply
                          " to comments)
set ruler                 " Show the line and column number of the cursor position
set background=dark       " dark/white: use colors that look good on a dark/white

"let g:gruvbox_material_background = 'hard' "material/mix/original soft/medium/hard
"colorscheme gruvbox-material
colorscheme onedark

" highlighting yanked text:
let g:highlightedyank_highlight_duration =1000

if !exists('##TextYankPost')
  map y <Plug>(highlightedyank)
endif

set mouse=a               " Enable the use of the mouse.
set colorcolumn=80        " Show the 80 boundary
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Leader key settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Map leader to colon
let mapleader = ","
" Set timeout length to 10 ms
set timeoutlen=200 ttimeoutlen=10
set showcmd

" Run Python script by <leader>p. First saves and then runs script
autocmd FileType python map <buffer> <leader>y :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <leader>y <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>
"autocmd Filetype python nnoremap <buffer> <leader>y :w<CR>:ter python2 "%"<CR>
"autocmd Filetype python nnoremap <buffer> <leader>y :w<CR>:vert ter python3 "%"<CR>
autocmd Filetype python nnoremap <buffer> <leader>p :w<CR>:vert bo ter python3 "%"<CR>

au BufNewFile, BufRead *.py
    \ set autoindent

" Folding identation. Handig voor verbergen van gedeeltes van idented code
set foldmethod=indent
set foldlevel=99
"remap za, toggle folding, to space
nnoremap <space> za

"NERDTreeFocus by <leader>n
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>h :NERDTreeFind<CR>
"nnoremap <leader>n :NERDTreeFocus<CR>
"Move between windows in vim, can also be used for nerdtree :-) 
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"Debugging sofware; vimspector
" for normal mode - the word under the cursor
" LET OP: vimspector werkt niet, foutmeldingen....
nmap <Leader>di <Plug>VimspectorBalloonEval
" for visual mode, the visually selected text
xmap <Leader>di <Plug>VimspectorBalloonEval""

" CoC. Use <Tab> and <S-Tab> to navigate the completion list
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" Block up/down arrow for selection of CoC suggestions (pumvisible). Then the 
" arrow keys can be used to po up/down on rows without selecting in the list.
inoremap <expr> <Up> pumvisible() ? "\<C-y>\<Up>" : "\<Up>"
inoremap <expr> <Down> pumvisible() ? "\<C-y>\<Down>" : "\<Down>"

" Auto parentheses. Automatically add closing signs to parentheses.
inoremap " ""<left>
inoremap ( ()<left>
inoremap ' ''<left>
"inoremap < <><left>
"inoremap [ []<left>
"inoremap { {}<left>
"inoremap {<CR> {<CR>}<ESC>O
"inoremap {;<CR> {<CR>};<ESC>O

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set clipboard^=unnamed,unnamedplus "set clipboard to system clipboard (required gvim) AND primary selection!
" Paste system clipboard middlemouse, paste/nopaste om auto ident te omzijlen.
noremap <MiddleMouse> :set paste<cr><S-Insert>:set nopaste<cr>
" in normal mode is paste/nopaste niet nodig:
inoremap <MiddleMouse> <cr><S-Insert><cr>

vnoremap <C-c> "*y :let @+=@*<CR> 
"CTRL-C puts selection in clipboard
map <C-p> "+P
syntax enable             " Enables syntax highlighting. An alternative to 'syntax on'
