
set nocompatible
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'Vundle/Vundle.vim'  " package manager
Plugin 'tomasiser/vim-code-dark'  " theme
Plugin 'vim-airline/vim-airline'  " status bar style
Plugin 'neoclide/coc.nvim'  " autocompletion

call vundle#end()


" ===== Display =====

" style
set ruler  " show current line and col number (bottom right)
set laststatus=2  " always show status line, even in normal mode
set hidden  " allows opening new buffers without saving
set number  " show line numbers on the left side
set showcmd  " show last command


" ===== Language support =====

" enable auto indent and syntax
filetype indent plugin on
syntax on


" ===== Typing & control =====

set backspace=indent,eol,start  " correct usage of backspace

set autoindent  " copy indent with newlines

" default to tab = 4 spaces
set shiftwidth=4
set softtabstop=4
set expandtab

" control with mouse
if has('mouse')
  set mouse=a
endif


" ===== Search =====

set ignorecase  " case insensitive
set smartcase  " if search starts with caps, make it case sensitive
set incsearch  " search as you type
set hlsearch  " highlight search results

" when entering insert mode, remove search highlights
autocmd InsertEnter * set nohls


" ===== Utils =====

" confirm prompt for certain actions (such as closing without saving)
set confirm


" ===== Misc =====

" disable beeps and bells
set visualbell
set t_vb=


" ===== Buffers, tabs, windows =====

set splitright  " vert split goes right of screen instead of left


" ===== Theme & colors =====

colorscheme codedark

hi Search ctermbg=gray ctermfg=black

" unset background colours (uses transparency if available)
hi Normal ctermbg=NONE
hi EndOfBuffer ctermbg=NONE

set relativenumber
set clipboard=unnamedplus
" ===== Autocompletion =====

" Additional things to do by hand (for now)
" - run in shell `cd ~/.vim/bundle/coc.nvim && npm ci`
" - run ":CocInstall coc-clangd" for C/C++ support
" - run ":CocConfig" and add `{"diagnostic.refreshOnInsertMode": true}`
"   for a better working linter


set wildmenu  " vim command autocompletion and suggestions (using tab)

" autocomplete list options
set completeopt=longest,menuone,popuphidden
set completepopup=highlight:Pmenu,border:off

" ----- coc.nvim -----

" always show sign column (warnings/errors), prevents shifting
set signcolumn=yes

" faster time to trigger CursorHold and other coc actions
set updatetime=300

" use tab and enter for completion menu
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" use ctrl+space to force trigger completion (like vscode)
inoremap <silent><expr> <c-@> coc#refresh()

nnoremap <TAB> :term <CR>
" highlight the symbol and its references when holding cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" shortcuts

nmap <F2> <Plug>(coc-rename)  " rename current symbol

" format selected code
xmap <F4>  <Plug>(coc-format-selected)
nmap <F4>  <Plug>(coc-format-selected)

" use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction


" ===== Airline =====

" show opened buffers in tab line
let g:airline#extensions#tabline#enabled = 1

" use ascii symnols for status bar
let g:airline_symbols_ascii = 1

" map unicode symbols
let g:airline_left_sep = ''
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols = {}
let g:airline_symbols.colnr = ' | c'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.linenr = ' | '
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.maxlinenr = '㏑'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'


" ===== Language specific =====

" recognize anything in my .Postponed directory as a news article, and anything
" at all with a .txt extension as being human-language text [this clobbers the
" `help' filetype, but that doesn't seem to prevent help from working
" properly]:
augroup filetype
  autocmd BufNewFile,BufRead */.Postponed/* set filetype=mail
  autocmd BufNewFile,BufRead *.txt set filetype=human
augroup END

autocmd FileType mail set formatoptions+=t textwidth=72  " enable wrapping in mail
autocmd FileType human set formatoptions-=t textwidth=0  " disable wrapping in txt

" for C-like  programming where comments have explicit end
" characters, if starting a new line in the middle of a comment automatically
" insert the comment leader characters:
autocmd FileType c,cpp,java set formatoptions+=ro
" EPITA block comment style
autocmd FileType c,cpp set comments=sl:/*,mb:**,ex:*/"

" two space indentation for some files
autocmd FileType vim,lua,yaml set shiftwidth=2 softtabstop=2

" ensure normal tabs in assembly files
" and set to NASM syntax highlighting
autocmd FileType asm set noexpandtab shiftwidth=8 softtabstop=0 syntax=nasm

" 68000k ASM specific options
autocmd FileType asm set syntax=asm68k
autocmd FileType asm map <F6> :!a68k % -o%:r.hex -s -n -rmal<CR>
autocmd FileType asm map <F7> :silent exec "!d68k %:r.hex &"<CR>
