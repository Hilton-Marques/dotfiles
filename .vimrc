" ==========================================================
" Basic configuration
" ==========================================================

"Turn on syntax highlighting
syntax on

"Disable the default Vim startup message
set shortmess+=I

"Show line numbers.
set number

"Give a relative enumeration from up and down
set relativenumber

"Show the status line
set laststatus=2

"Give a intuitive behavior for backspace
set backspace=indent,eol,start

"Allows to hidden a buffer
set hidden

"Set search case-insensitive
set ignorecase
set smartcase

"start search without start key
set incsearch

"unbinding bad default keys
nmap Q <Nops>

"Disable audible bell
set noerrorbells visualbell t_vb=
set belloff=all

"improve navigation
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
" ...and in insert mode
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>

"Set undo dir
set undofile
set undodir=~/.vim/undodir

" Set leader key as space
let mapleader=" "
let maplocalleader=","

" Configure colorscheme
highlight VertSplit ctermfg=1 ctermbg=NONE cterm=NONE  
colorscheme habiMath
" ==========================================================
" Movements
" ==========================================================

" Highlight last inserted text
noremap gV `[v`]

" Quick start and end of a line
map H ^
map L $

" Bigger vertical jumps
nnoremap K 5k
nnoremap J 5j

" Center screen after search
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz

" Spell checks
setlocal spell
set spelllang=en_us
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" Tabsize
set shiftwidth=2
set tabstop=2
"  ==========================================================
" PLUGINS
" ==========================================================
" Some plugins were took from https://github.com/gillescastel/latex-snippets 

" Check if VimPlug is already installed
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'sirver/ultisnips'
    let g:UltiSnipsExpandTrigger = '<tab>'
    let g:UltiSnipsJumpForwardTrigger = '<tab>'
    let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

Plug 'lervag/vimtex'
    filetype plugin indent on
    syntax enable
    let g:tex_flavor='latex'
    let g:vimtex_view_method='zathura'
    let g:vimtex_quickfix_mode=0
    

Plug 'KeitaNakamura/tex-conceal.vim'
    set conceallevel=1
    let g:tex_conceal='abdmg'
    hi Conceal ctermbg=none

Plug 'jiangmiao/auto-pairs'

Plug 'junegunn/vim-easy-align'
	" Start interactive EasyAlign in visual mode (e.g. vipga)
	xmap ga <Plug>(EasyAlign)
	" Start interactive EasyAlign for a motion/text object (e.g. gaip)
	nmap ga <Plug>(EasyAlign)

Plug 'junegunn/limelight.vim'
	" Color for out of focus sections with limelight
	let g:limelight_conceal_ctermfg = 'gray'

	" Regex for limelight to include % demarcations
	let g:limelight_bop = '\(^\s*$\n\|^\s*%$\n\)\zs'
	let g:limelight_eop = '\ze\(^$\|^\s*%$\)'

Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'  
Plug 'terryma/vim-multiple-cursors'
Plug 'itchyny/lightline.vim'  
Plug 'junegunn/goyo.vim'               " Distraction free mode
Plug 'junegunn/limelight.vim'          " Focus on current paragraph
Plug 'ron89/thesaurus_query.vim'       " Synonym query
Plug 'dpelle/vim-LanguageTool'
	let g:languagetool_jar='/home/hiltonms/Documents/Programas/languagetool/languagetool-commandline.jar'
Plug 'PatrBal/vim-textidote'
	let g:textidote_jar='/opt/textidote/textidote.jar'
call plug#end()

" ==========================================================
" LEADER SHORTCUTS
" ==========================================================

" Quick write and save
nmap <Leader>w :wq<CR>
nmap <Leader>q :q<CR>
nmap <Leader>W :w<CR>
nmap <Leader>Q :q!<CR>

" Quick copy and paste to clipboard
nmap <Leader>y "+y
nmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>y "+y
vmap <Leader>d "+d
vmap <Leader>p "+p
vmap <Leader>P "+P


