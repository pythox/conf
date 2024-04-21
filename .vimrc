call plug#begin()
" colors
Plug 'chriskempson/base16-vim'
Plug 'itchyny/lightline.vim'
Plug 'daviesjamie/vim-base16-lightline'
Plug 'inkarkat/vim-ingo-library'
Plug 'inkarkat/vim-mark'
Plug 'bfrg/vim-cpp-modern'
Plug 'joshdick/onedark.vim'

" git
"Plug 'tpope/vim-fugitive'
"Plug 'airblade/vim-gitgutter'

" misc
Plug '~/.fzf'
Plug 'tpope/vim-commentary'
Plug 'ojroques/vim-oscyank'
Plug 'justinmk/vim-sneak'
"Plug 'ervandew/supertab'
Plug 'junegunn/fzf.vim'
Plug 'rhysd/vim-clang-format'
call plug#end()

filetype plugin indent on

" mappings
let mapleader=" "
imap jk <Esc>
nnoremap ; :
nnoremap <leader>nh :nohl<CR>
nnoremap <leader>sv <C-w>v
nnoremap <leader>sh <C-w>s
nnoremap <leader>se <C-w>=
nnoremap <leader>sx :close<CR>
nnoremap <leader>sm :MaximizerToggle<CR>
nnoremap <leader>to :tabnew<CR>
nnoremap <leader>tx :tabclose<CR>
nnoremap <leader>tn :tabn<CR>
nnoremap <leader>tp :tabp<CR>
nnoremap <silent> <C-p> :FZF<CR>
vnoremap <silent><leader>c :OSCYank<CR>
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)

autocmd FileType c,cpp,objc vnoremap <buffer><Leader>f :ClangFormat<CR>
let g:clang_format#code_style = "nutanix" 
let g:clang_format#auto_format = 0
let g:clang_format#detect_style_file = 1 
let g:clang_format#style_options = {
      \ "BinPackArguments" : "true"}

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--disabled', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  let spec = fzf#vim#with_preview(spec, 'right', 'ctrl-/')
  call fzf#vim#grep(initial_command, 1, spec, a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
nnoremap <silent> <C-s> :RG<CR>

" options
set nu rnu
set cc=80
set cursorline
set foldmethod=syntax
set nofoldenable
set updatetime=100

" tabs & indentation
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
set smartindent

" line wrapping
set wrap

" search settings
set ignorecase
set smartcase

" appearance
set t_ZH=^[[3m
set t_ZR=^[[23m
set term=xterm-256color
" set t_Co=256
set background=dark
autocmd VimEnter * highlight Normal ctermbg=NONE guibg=NONE
highlight Comment cterm=italic

" backspace
set backspace=indent,eol,start

" clipboard
set clipboard=unnamedplus

" split windows
set splitright
set splitbelow

" misc
set ttymouse=xterm2
set mouse=a
set laststatus=2
set autoread

" oscyank
let g:oscyank_silent=1

" git commits
au FileType gitcommit setlocal tw=72
au FileType gitcommit set cc=50,72

" file type detections
au BufRead,BufNewFile COMMIT_EDITMSG set filetype=gitcommit
au BufRead,BufNewFile *.INFO*,*.ERROR*,*.WARNING*,*.out* set filetype=log

let g:lightline = {
      \ 'component_function': {
      \   'filename': 'FilenameForLightline'
      \ }
  \ }

function! FilenameForLightline()
  return expand('%')
endfunction

" sneak
let g:sneak#label = 1
let g:sneak#use_ic_scs = 1

" ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPCurWD'

" cpp highlight
let g:cpp_attributes_highlight = 1
let g:cpp_member_highlight = 1

" git gutter
let g:gitgutter_sign_column_always = 1

" save fzf history.
let g:fzf_history_dir = '~/.local/share/fzf-history'
