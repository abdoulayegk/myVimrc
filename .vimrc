set runtimepath+=~/.vim_runtime

source ~/.vim_runtime/vimrcs/basic.vim
source ~/.vim_runtime/vimrcs/filetypes.vim
source ~/.vim_runtime/vimrcs/plugins_config.vim
source ~/.vim_runtime/vimrcs/extended.vim

" Showing line numbers and length
set number
set tw=80 " with of the document(used by gd)
set nowrap " don't automatically wrap on load

" To Keep lines to less than 80 characters
au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
set relativenumber
" to solve pylint 
autocmd BufWritePost *.py call Flake8()

try
source ~/.vim_runtime/my_configs.vim
catch
endtry

" while in insert mode, moves you to the end of the next line when you type
imap ;ne <esc>/;<cr>a

" Quicksave command
noremap <C-Z> : update<CR>
vnoremap <C-Z> <C-C>:update<CR>
noremap <C-Z> <C-O>:update<CR>

"Quick quit command
noremap <Leader>e :quit<CR> 
noremap <Leader>E :qa!<CR>

syntax on

" Disable the default Vim startup message.
set shortmess+=I

" Always show the status line at the bottom, even if you only have one window open.
set laststatus=2
"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set ttyfast

set hidden

set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

set fileformats=unix,dos,mac

" Enable mouse support. You should avoid relying on this too much, but it can
" sometimes be convenient.
set mouse+=a

" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=

let g:ale_linters = {
      \   'python': ['flake8', 'pylint'],
      \   'ruby': ['standardrb', 'rubocop'],
      \   'javascript': ['eslint'],
      \}

" For making fold
augroup vimrc
  au BufReadPre * setlocal foldmethod=indent
  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
  augroup END


" This setting makes search case-insensitive when all characters in the string
" being searched are lowercase. However, the search becomes case-sensitive if
" it contains any capital letters. This oomakes searching more convenient.
set ignorecase
set smartcase
" Try to prevent bad habits like using the arrow keys for movement. This is
" not the only possible bad habit. For example, holding down the h/j/k/l keys
" for movement, rather than using more efficient movement commands, is also a
" bad habit. The former is enforceable through a .vimrc, while we don't know
" how to prevent the latter.
" Do this in normal mode...
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
" ...and in insert mode
inoremap <Left>  <ESC>:echoe "Use h"<CR>
" set list " To enable by default
" Or use your leader key + l to toggle on/off
map <leader>l :set list!<CR> " Toggle tabs and EOL
" to see the directory names we add the below line
autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | silent! lcd %:p:h | endif
" Add file directory to Vim path
" Add the current file's directory to the path if not already present.
autocmd BufRead *
      \ let s:tempPath=escape(escape(expand("%:p:h"), ' '), '\ ') |
      \ exec "set path+=".s:tempPath