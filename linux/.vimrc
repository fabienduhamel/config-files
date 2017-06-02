filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-markdown'
Plugin 'suan/vim-instant-markdown'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
"Plugin 'edkolev/tmuxline.vim' "leave this commented out unless changing theme
Plugin 'benmills/vimux'
" Plugin 'christoomey/vim-tmux-navigator'
Plugin 'tommcdo/vim-fugitive-blame-ext'
Plugin 'kana/vim-arpeggio'
Plugin 'rking/ag.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'groenewege/vim-less'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'ConradIrwin/vim-bracketed-paste'
Plugin 'slim-template/vim-slim'
" Plugin 'tmux-plugins/vim-tmux'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'airblade/vim-gitgutter'

" required
call vundle#end()

" set 256 colors
set t_Co=256

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on

" Enable syntax highlighting
syntax on

" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent
set smartindent
set wrap

" Autosave buffers on focus lost except untitled ones
autocmd CursorHold,CursorHoldI,BufLeave,FocusLost * silent! wall

" Move correctlry in wrapped lines
noremap  <buffer> <silent> j gj
noremap  <buffer> <silent> k gk
noremap  <buffer> <silent> <Up> gk
noremap  <buffer> <silent> <Down> gj
noremap  <buffer> <silent> 0 g0
noremap  <buffer> <silent> $ g$

" line length
let &colorcolumn=join(range(121,999),",")
highlight ColorColumn ctermbg=235 guibg=#2c2d27

" Matching bracket/parenthesis color
hi MatchParen cterm=none ctermbg=red ctermfg=black

" Sets how many lines of history VIM has to remember
set history=500

" With a map leader, it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" For regular expressions turn magic on
set magic

" https://github.com/christoomey/vim-tmux-navigator
"let g:tmux_navigator_no_mappings = 1
" These are Alt + hjkl chars (does not work on Linux)
"nnoremap <silent> Ì :TmuxNavigateLeft<cr>
"nnoremap <silent> Ï :TmuxNavigateDown<cr>
"nnoremap <silent> È :TmuxNavigateUp<cr>
"nnoremap <silent> ¬ :TmuxNavigateRight<cr>
"nnoremap <silent> œ :TmuxNavigatePrevious<cr>
" Write all buffers before navigating from Vim to tmux pane (does not work
" well - eg losing focus for a Cocoa window does not save buffers)
"let g:tmux_navigator_save_on_switch = 2

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Set the command window height to 2 lines, to avoid many cases of having to
" press <Enter> to continue"
set cmdheight=2

set encoding=utf-8
set expandtab
set smarttab

" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch

" This stops Vim from redrawing the screen during complex operations and results
" in much smoother looking plugins.
set lazyredraw

" Always display the status line, even if only one window is displayed
set laststatus=2

" display unprintable characters
set list

" Use textmate-style whitespace characters
set listchars=tab:▸\ ,eol:¬

" Enable use of the mouse for all modes - helpful for resizing buffers
set mouse=a

" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible

" show line numbers by default
set relativenumber
set number

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Add git branch to statusline
set statusline=%F\ %m\ %{fugitive#statusline()}\ %y%=%l,%c\ %P

" INDENTATION OPTIONS
" Indentation settings for using 2 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set softtabstop=4 " insert mode tab and backspace use 2 spaces
set shiftwidth=4 " normal mode indentation commands use 2 spaces

set showtabline=2 " always show tab bar

" enables bash aliases from vim shell
set shell=bash
" this allows you to use bash aliases from the vim shell
" sadly, it breaks fugitive's git patch which is really nice
" set shellcmdflag=-ic

" Show partial commands in the last line of the screen
set showcmd

" search remap
nnoremap / /\v
vnoremap / /\v
set ignorecase
set gdefault
set incsearch
set showmatch
set hlsearch
" case-sensitive search if any caps
set smartcase

" if opening a file from :ls, :buffers, :files, etc. jump to open version
" of the file, if one exists
set switchbuf=useopen

" And reset the terminal code for the visual bell.  If visualbell is set, and
" this line is also included, vim will neither flash nor beep.  If visualbell
" is unset, this does nothing.
set t_vb=

" Allow an unusually high tab limit - helpful for ':tab ball' with a huge
" buffer list
set tabpagemax=200

" Use visual bell instead of beeping when doing something wrong
set visualbell

" Better command-line completion
set wildmenu
set wildmode=longest,list,full

" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" if exists('$TMUX')  " Support resizing in tmux
"   set ttymouse=xterm2
" endif

" vv to generate new vertical split
nnoremap <silent> vv <C-w>v
" ss to generate new horizontal split
nnoremap <silent> ss <C-w>s
" Smart split
set splitbelow
set splitright

" save left pinky - map minus sign to colon!
nore - :

" Gitv settings:
" do not allow gitv to generate control key mappings
" as these collide with the above
let g:Gitv_DoNotMapCtrlKey = 1
nmap <leader>gv :Gitv --all<cr>
nmap <leader>gV :Gitv! --all<cr>
vmap <leader>gV :Gitv! --all<cr>

" manage working dir:  the nearest ancestor that contains a .git
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_max_height = 10
let g:ctrlp_max_depth = 20
let g:ctrlp_match_window = 'bottom,order:ttb,min:10,max:10,results:100'

" tells snipmate to only use custom snippets
let g:snippets_dir = "~/.vim/snippets"

" used patched fonts for airline arrows/triangles
let g:airline_powerline_fonts=1

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_close_button = 0

let g:airline_theme='molokai'

" quickly clear highlights
map <leader>n :noh<CR>

" quickly close quickfix
map <leader>C :ccl<CR><CR>

" quickly open a new tab
map <leader>t :tabnew<CR>

" no more pesky escape (for insert and visual mode)
imap kj <Esc>
imap kJ <Esc>
imap Kj <Esc>
imap KJ <Esc>

nmap <leader><space> :call whitespace#strip_trailing()<CR>

" System clipboard
set clipboard=unnamed
vnoremap <C-S-c> "+y
vnoremap <C-S-v> "+p

" reload files when they change on disk (e.g., git checkout)
set autoread

" highlight whitespace symbols
hi NonText ctermfg=240 guifg=#666666

" trailing whitespace intentional
map <leader>a :Ag

nmap <leader>p :CtrlPClearAllCaches<CR>

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
 let g:ackprg = 'ag --nogroup --column'

  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -g "" -l --hidden --ignore-dir .git --ignore-dir Library --ignore-dir Cache --ignore-dir .Trash --ignore-dir app/cache --ignore-dir .composer'
endif

" Current line customization
" high light current line in insert mode
" Enable CursorLine
set cursorline
autocmd InsertEnter * highlight  CursorLine ctermbg=236 ctermfg=None
autocmd InsertLeave * highlight  CursorLine ctermbg=235 ctermfg=None

" Vimux configuration
" Prompt for a command to run
"map <Leader>vp :VimuxPromptCommand<CR>
" Run last command executed by VimuxRunCommand
"map <Leader>vl :VimuxRunLastCommand<CR>
" Inspect runner pane
"map <Leader>vi :VimuxInspectRunner<CR>
" Close vim tmux runner opened by VimuxRunCommand
"map <Leader>vq :VimuxCloseRunner<CR>
" Open vimux pane
"map <Leader>vo :VimuxOpenPane<CR>
" Interrupt any command running in the runner pane
"map <Leader>vx :VimuxInterruptRunner<CR>
"
" Function to make tmux zoom its runner pane.
"function! VimuxZoomRunner()
"  call VimuxInspectRunner()
"  call system("tmux resize-pane -Z")
"endfunction
" Zoom the runner pane (use <bind-key> z to restore runner pane)
"map <Leader>vz :call VimuxZoomRunner()<CR>
" Chords
"call arpeggio#map('n', '', 0, 'vl', ':VimuxRunLastCommand<CR>')
"call arpeggio#map('n', '', 0, 'vp', ':VimuxPromptCommand<CR>')
"call arpeggio#map('n', '', 0, 'vq', ':VimuxCloseRunner<CR>')
"call arpeggio#map('n', '', 0, 'pr', 'VimuxRunCommand("clear; pr<CR>')

" NERDTree
nnoremap <leader>d :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>

" Ugh, vim 7.4 doesn't indent the following by default - breaks shit
let g:html_indent_inctags = "html,body,head,tbody"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a markdown buffer for scribble
map <leader>x :e ~/buffer.md<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $e <esc>`>a"<esc>`<i"<esc>

" Map auto complete of (, ", ', [
inoremap $1 ()<esc>i
inoremap $2 []<esc>i
inoremap $3 {}<esc>i
inoremap $4 {<esc>o}<esc>O
inoremap $q ''<esc>i
inoremap $e ""<esc>i


