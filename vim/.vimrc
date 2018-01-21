"  __    __)            
" (, )  /  ,            
"    | /    ___   __  _ 
"    |/  _(_// (_/ (_(__
"    |                  

" ---------------------------------------------------------BASIC SETTINGS

execute pathogen#infect()

" indents for different filetypes
autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType text setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType nerdtree :call ChangeBack()

set nobackup
set nowritebackup
set noswapfile " get rid of swapfiles everywhere
set dir=/tmpset


" ---------------------------------------------------------UI SETTINGS

let g:enable_bold_font = 1
let g:enable_italic_font = 1
" autocmd BufWritePre * %s/\s\+$//e " strip trailing whitespaces
syntax on

set list
filetype indent on
set number
set relativenumber                                             " easier to use c ommands su c h as 9k and 21j
set laststatus=2                                               " always show the status line
set nowrap                                                     " dont wrap the text
set noshowmode                                                 " statusline shows the current mode anyways
set cursorline                                                 " highlight current line
set listchars=tab:│\ ,eol:¬,nbsp:␣,trail:▪,extends:>,precedes:< " tab, end of line, non-breakable space chars
set scrolloff=12                                               " start scrolling before end is reached
set ignorecase                                                 " case insensitive searching
set smartcase                                                  " /The searches for 'The but /the searches for 'The' and 'the'
set sidescroll=40                                              " like scrolloff but sideways
set incsearch                                                  " highlight results as you type
set hlsearch                                                   " highlight search results
set undofile                                                   " maintaion undo history
set undodir=~/.vim/undodir                                     " store swaps here
set showcmd                                                    " show current cmd in cmdline
set updatetime=250                                             " instant live status updates
set backspace=indent,eol,start

colorscheme agila


" ---------------------------------------------------------SPACING AND STUFF

set shiftwidth=4     " indent = 4 spaces
set noexpandtab      " tabs are tabs
set tabstop=4        " tab = 4 spaces
set softtabstop=4    " backspace through spaces


" ---------------------------------------------------------AIRLINE CAN GO TO HELL
let g:currentmode={
    \ 'n'  : 'NORMAL ',
    \ 'no' : 'N·Operator Pending ',
    \ 'v'  : 'VISUAL ',
    \ 'V'  : 'V·Line ',
    \ '' : 'V·Block',
    \ 's'  : 'Select ',
    \ 'S'  : 'S·Line ',
    \ '' : 'S·Block',
    \ 'i'  : 'INSERT ',
    \ 'R'  : 'REPLACE ',
    \ 'Rv' : 'V·Replace ',
    \ 'c'  : 'Command ',
    \ 'cv' : 'Vim Ex ',
    \ 'ce' : 'Ex ',
    \ 'r'  : 'Prompt ',
    \ 'rm' : 'MORE ',
    \ 'r?' : 'CONFIRM ',
    \ '!'  : 'SHELL ',
    \ 't'  : 'TERMINAL '}


set statusline=
set statusline+=%#PrimaryBlock#
set statusline+=\ %{g:currentmode[mode()]}
set statusline+=%#SecondaryBlock#
set statusline+=%{StatuslineGit()}
set statusline+=%#TeritaryBlock#
set statusline+=\ %f\ 
set statusline+=%M\ 
set statusline+=%#Blanks#
set statusline+=%=
set statusline+=%#SecondaryBlock#
set statusline+=\ %Y\ 
set statusline+=%#PrimaryBlock#
set statusline+=\ %P\ 

function! GitBranch()
	return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
	let l:branchname = GitBranch()
	return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction



" ---------------------------------------------------------FUNCTIONS

function! Minimalify()  " homemade goyo.vim
	if &laststatus
		setlocal laststatus=0
	else
		setlocal laststatus=2
	endif
	set noshowmode list! number! cursorline! noru! relativenumber!
	:GitGutterSignsToggle
endfunction


function! ChangeBack()  " change background of current buffer upto 256 columns
	:setlocal colorcolumn=1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256
endfunction


function! GetTabber()  " a lil function that integrates well with Tabular.vim
	let c = nr2char(getchar())
	:execute 'Tabularize /' . c
endfunction


let g:help_in_tabs = 1

nmap <silent> H  :let g:help_in_tabs = !g:help_in_tabs<CR>

"Only apply to .txt files...
augroup HelpInTabs
    autocmd!
    autocmd BufEnter  *.txt   call HelpInNewTab()
augroup END

"Only apply to help files...
function! HelpInNewTab ()
    if &buftype == 'help' && g:help_in_tabs
        "Convert the help window to a tab...
        execute "normal \<C-W>T"
    endif
endfunction


" ---------------------------------------------------------KEYBINDINGS

let mapleader=' '

nnoremap <F3>      : call Minimalify()<cr>
nnoremap <F5>      : split
nnoremap <F6>      : vsplit
nnoremap <Leader>o : only<cr>
nnoremap <Leader>f : YcmCompleter FixIt<cr>
nnoremap <Leader>l : Lines<cr>
nnoremap <Leader>b : Buffers<cr>
nnoremap <Leader>z : FZF<cr>
nnoremap <Leader>w : MtaJumpToOtherTag<cr>
nnoremap <Leader>t : call GetTabber()<cr>


nnoremap H H:exec 'norm! '. &scrolloff . 'k'<cr>
nnoremap L L:exec 'norm! '. &scrolloff . 'j'<cr>
cmap w!! %!sudo tee > /dev/null %

vnoremap > >gv
vnoremap < <gv

" I always linger on the shift key
:command! WQ wq
:command! Wq wq
:command! Wqa wqa
:command! W w
:command! Q q

" abbreviations.
iab #i #include
iab #d #define
cab dst put =strftime('%d %a, %b %Y')<cr>
cab vg vimgrep


" ---------------------------------------------------------PLUGINS

" youcompleteme
let g:ycm_error_symbol                              = '>>'
let g:ycm_warning_symbol                            = '->'
let g:ycm_add_preview_to_completeopt                = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_confirm_extra_conf                        = 0


" git gutter settings
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_sign_added                     = '+'
let g:gitgutter_sign_modified                  = '±'
let g:gitgutter_sign_removed                   = '-'
let g:gitgutter_sign_removed_first_line        = '^'
let g:gitgutter_sign_modified_removed          = '#'


" emmet
let g:user_emmet_mode='a'    "enable all function in all mode.
let g:user_emmet_leader_key='<C-X>'


" incsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
