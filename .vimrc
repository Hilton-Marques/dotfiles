" ==========================================================
" Basic configuration
" ==========================================================
"Enable fyletype detection
filetype plugin indent on

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
"inoremap <Left>  <ESC>:echoe "Use h"<CR>
"inoremap <Right> <ESC>:echoe "Use l"<CR>
"inoremap <Up>    <ESC>:echoe "Use k"<CR>
"inoremap <Down>  <ESC>:echoe "Use j"<CR>

"Set undo dir
set undofile
set undodir=~/.vim/undodir

" Set leader key as space
let mapleader=" "
let maplocalleader=","

" Configure colorscheme
"highlight VertSplit ctermfg=1 ctermbg=NONE cterm=NONE  
"highlight VertSplit ctermfg=1 ctermbg=NONE cterm=NONE  
"colorscheme habiMath
"colorscheme evening

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
"setlocal spell
"set spelllang=en
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
autocmd FileType tex setlocal spell spelllang=pt,en

" Tabsize
set shiftwidth=2
set tabstop=2

" Go to bracket
map  <C-\> %

" Save window_id to manage focus on zathura
if !exists("g:vim_window_id")
  let g:vim_window_id = system("xdotool getactivewindow")
endif
function! s:TexFocusVim(delay_ms) abort
  " Give window manager time to recognize focus 
  " moved to PDF viewer before focusing Vim.
  let delay = a:delay_ms . "m"
  execute 'sleep ' . delay
  execute "!xdotool windowfocus " . expand(g:vim_window_id)
  redraw!
endfunction

" Remaps to handle inkscape-figures
inoremap <C-f> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/pictures/"'<CR><CR>:w<CR>
nnoremap <C-f> : silent exec '!inkscape-figures edit "'.b:vimtex.root.'/pictures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>
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
    syntax enable
    let g:tex_flavor='latex'
    let g:vimtex_view_method='zathura'
    let g:vimtex_quickfix_mode=0
		let g:Tex_BIBINPUTS="/home/hiltonms/Documents/Notes/PHD/thesis-latex" "Set BibTex path
    let g:vimtex_grammar_vlty = {
            \ 'lt_directory': '/home/hiltonms/Documents/Programas/languagetool/',
            \ 'lt_command': '',
            \ 'lt_disable': 'WHITESPACE_RULE',
            \ 'lt_enable': '',
            \ 'lt_disablecategories': '',
            \ 'lt_enablecategories': '',
            \ 'server': 'no',
            \ 'shell_options': '',
            \ 'show_suggestions': 0,
            \ 'encoding': 'auto',
            \}
		"Config for Zathura conversation (taken from https://www.ejmastnak.com/tutorials/vim-latex/pdf-reader/#summary-what-works-on-what-platform )	
		" This will only work if `vim --version` includes `+clientserver`!
		if empty(v:servername) && exists('*remote_startserver')
			call remote_startserver('VIM')
		endif
		augroup vimtex_event_focus
			au!
		" Post-forward-search refocus with 200ms delay---tweak as needed
		au User VimtexEventView call s:TexFocusVim(200)
		" Only perform post-inverse-search refocus on gVim; delay unnecessary
		if has("gui_running")
			au User VimtexEventViewReverse call s:TexFocusVim(0)
		endif
		augroup END 

Plug 'KeitaNakamura/tex-conceal.vim'
		" It seems that conceal does not worked well with onedark
    set conceallevel=0
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
	
	nmap <Leader>[ <Plug>(Limelight)
	xmap <Leader>[ <Plug>(Limelight)

Plug 'easymotion/vim-easymotion'
	let g:EasyMotion_use_upper = 1
	let g:EasyMotion_keys = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ;'
	" Turn on case-insensitive feature
	let g:EasyMotion_smartcase = 1
	map <Leader> <Plug>(easymotion-prefix)
	map <Leader>h <Plug>(easymotion-linebackward)
	map <Leader>j <Plug>(easymotion-j)
	map <Leader>k <Plug>(easymotion-k)
	map <Leader>l <Plug>(easymotion-lineforward)

	" <Leader>f{char} to move to {char}
	map  <Leader>f <Plug>(easymotion-bd-f)
	nmap <Leader>f <Plug>(easymotion-overwin-f)
	" vim-sneak behaviour through easymotio
	map <Leader>t <Plug>(easymotion-t2)
	nmap <Leader>t <Plug>(easymotion-overwin-t2)
	map <Leader>s <Plug>(easymotion-f2)
	nmap <Leader>s <Plug>(easymotion-overwin-f2)
Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'tpope/vim-surround'  
Plug 'terryma/vim-multiple-cursors'
Plug 'itchyny/lightline.vim'  
Plug 'junegunn/goyo.vim'               " Distraction free mode
Plug 'junegunn/limelight.vim'          " Focus on current para
Plug 'ron89/thesaurus_query.vim'       " Synonym query
Plug 'dpelle/vim-LanguageTool'
	let g:languagetool_jar='/home/hiltonms/Documents/Programas/languagetool/languagetool-commandline.jar'
	"let g:languagetool_cmd = '$HOME/.vim/lt_tex_filter.sh'
	let g:languagetool_disable_rules = 'WHITESPACE_RULE'
	map <F9> :LanguageToolCheck<CR>
Plug 'PatrBal/vim-textidote'
	let g:textidote_jar='/opt/textidote/textidote.jar'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
	" Make <CR> to accept selected completion item or notify coc.nvim to format
	" <C-g>u breaks current undo, please make your own choice
	inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
Plug 'github/copilot.vim'

" Rainbow Parentheses
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

Plug 'frazrepo/vim-rainbow'
let g:rainbow_active = 0 

" Dynamic highlighting 
Plug 'joshdick/onedark.vim'
"
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" Suggestion from https://github.com/lervag/vimtex/issues/1800
" #:~:text=Recording%20my%20solution%20here%20for%20anyone
augroup texcolors
	au!
	au ColorScheme * highlight! link Conceal       Special 
	au ColorScheme * highlight! link texCmdGreek   Special
	au ColorScheme * highlight! link texMathOper   texDelim
	au ColorScheme * highlight! link texMathDelim  texDelim
	au ColorScheme * highlight texDelim gui=bold guifg=#8ebd6b "See below
augroup end

" More highligs based on languages
Plug 'sheerun/vim-polyglot'
call plug#end()

" The colorscheme should be defined after the plug#end()
colorscheme onedark

" ==========================================================
" LEADER SHORTCUTS
" ==========================================================


" Quick write and save
nmap <Leader>W :wq<CR>
nmap <Leader>q :q<CR>
nmap <Leader>w :w<CR>
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

