"""""""""""
" Plugins "
"""""""""""

call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" fancy dark color scheme
Plug 'itchyny/landscape.vim'

" fancy staus bar
Plug 'itchyny/lightline.vim'

" integrate git
Plug 'tpope/vim-fugitive'

" set saner defaults
Plug 'tpope/vim-sensible'

" Detect indentation setting from file
Plug 'tpope/vim-sleuth'

" fancy completion
function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }

" vim <--> R communication
Plug 'jalvesaq/Nvim-R'

" fancy python completion
Plug 'zchee/deoplete-jedi'

" Add plugins to &runtimepath
call plug#end()


"""""""""""""""""
" Style Options "
"""""""""""""""""

" Let's try the fancy dark scheme
colorscheme landscape

" Use fancy status bar using settings suggested in the README
let g:lightline = {
      \ 'colorscheme': 'landscape',
      \ 'mode_map': { 'c': 'NORMAL' },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'modified': 'LightLineModified',
      \   'readonly': 'LightLineReadonly',
      \   'fugitive': 'LightLineFugitive',
      \   'filename': 'LightLineFilename',
      \   'fileformat': 'LightLineFileformat',
      \   'filetype': 'LightLineFiletype',
      \   'fileencoding': 'LightLineFileencoding',
      \   'mode': 'LightLineMode',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

" Indicate modification with '+' and non-modifiability with '-' for non-help
" buffers
function! LightLineModified()
  return &ft == 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

" Indicate readonly status for non-help buffers making use of the patched
" powerline fonts
function! LightLineReadonly()
  return &ft != 'help' && &readonly ? '' : ''
endfunction

" Include file status components into file name component
function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

" Indicate git branch making use of the patched powerline fonts
function! LightLineFugitive()
  if exists("*fugitive#head")
    let branch = fugitive#head()
    return branch !=# '' ? ' '.branch : ''
  endif
  return ''
endfunction

" Indicate file format only for wide buffers
function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

" Indicate file type only for wide buffers
function! LightLineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

" Indicate file encoding only for wide buffers
function! LightLineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

" For wide buffers indicate mode in the status bar, for narrow ones below
function! LightLineMode()
  if winwidth(0) > 60
    set noshowmode
    return lightline#mode()
  else
    set showmode
    return ''
  endif
endfunction


" Show (relative) line numbers
set number
set relativenumber


""""""""""""""""""
" Search Options "
""""""""""""""""""

" Seach case-insensitive
set ignorecase

" Seach case-sensitive if pattern contains upper-case letters
set smartcase


""""""""""""""""""
" Buffer Options "
""""""""""""""""""

" Don't allow hidden buffers
set nohidden

" Change working directory automatically
set autochdir


""""""""""""""""""""""
" Completion Options "
""""""""""""""""""""""

" Use deoplete
let g:deoplete#enable_at_startup = 1


"""""""""""""""""""
" Editing Options "
"""""""""""""""""""

" Replace tabs by spaces
set expandtab


""""""""""""""""""""""
" Copy/paste options "
""""""""""""""""""""""

" Enable copy/paste to/from outside neovim (source:
" https://github.com/neovim/neovim/issues/583#issuecomment-227303917)
set clipboard=unnamed


""""""""""""""""""""
" R plugin options "
""""""""""""""""""""

" let's try the key bindings suggested in the README
let maplocalleader = ","
let mapleader = ";"
vmap <Space> <Plug>RDSendSelection
nmap <Space> <Plug>RDSendLine<Paste>

" prevent autocompletion of _ to <-
let vimrplugin_underscore = 0
let vimrplugin_assign = 0

" prevent autocompletion of < to <<>>=\n@
let vimrplugin_rnowebchunk = 0
