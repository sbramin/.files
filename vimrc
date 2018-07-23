call plug#begin('~/.vim/')
Plug 'fatih/vim-go'
Plug 'Valloric/YouCompleteMe'
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-scriptease'
call plug#end()

let mapleader = ","
set encoding=utf-8
let g:rehash256 = 1

syntax enable
set t_Co=256

" Some useful quickfix shortcuts for quickfid 
map <C-n> :cn<CR>
map <C-m> :cp<CR>

" put quickfix window always to the bottom
autocmd FileType qf wincmd J

" Fast saving
nnoremap <leader>w :w!<cr>
nnoremap <silent> <leader>q :q!<CR>

" Center the screen
nnoremap <space> zz

" Remove search highlight
nnoremap <leader><space> :nohlsearch<CR>

" Source the current Vim file
nnoremap <leader>pr :Runtime<CR>

" Close all but the current one
nnoremap <leader>o :only<CR>

nnoremap <F6> :setlocal spell! spell?<CR>

" Do not show stupid q: window
map q: :q


"=====================================================
"===================== STATUSLINE ====================

let s:modes = {
      \ 'n': 'NORMAL', 
      \ 'i': 'INSERT', 
      \ 'R': 'REPLACE', 
      \ 'v': 'VISUAL', 
      \ 'V': 'V-LINE', 
      \ "\<C-v>": 'V-BLOCK',
      \ 'c': 'COMMAND',
      \ 's': 'SELECT', 
      \ 'S': 'S-LINE', 
      \ "\<C-s>": 'S-BLOCK', 
      \ 't': 'TERMINAL'
      \}

let s:prev_mode = ""
function! StatusLineMode()
  let cur_mode = get(s:modes, mode(), '')

  " do not update higlight if the mode is the same
  if cur_mode == s:prev_mode
    return cur_mode
  endif

  if cur_mode == "NORMAL"
    exe 'hi! StatusLine ctermfg=236'
    exe 'hi! myModeColor cterm=bold ctermbg=148 ctermfg=22'
  elseif cur_mode == "INSERT"
    exe 'hi! myModeColor cterm=bold ctermbg=23 ctermfg=231'
  elseif cur_mode == "VISUAL" || cur_mode == "V-LINE" || cur_mode == "V_BLOCK"
    exe 'hi! StatusLine ctermfg=236'
    exe 'hi! myModeColor cterm=bold ctermbg=208 ctermfg=88'
  endif

  let s:prev_mode = cur_mode
  return cur_mode
endfunction

function! StatusLineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! StatusLinePercent()
  return (100 * line('.') / line('$')) . '%'
endfunction

function! StatusLineLeftInfo()
 let branch = fugitive#head()
 let filename = '' != expand('%:t') ? expand('%:t') : '[No Name]'
 if branch !=# ''
   return printf("%s | %s", branch, filename)
 endif
 return filename
endfunction

exe 'hi! myInfoColor ctermbg=240 ctermfg=252'

" start building our statusline
set statusline=



" Time out on key codes but not mappings.
" Basically this makes terminal Vim work sanely.
if !has('gui_running')
  set notimeout
  set ttimeout
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
  augroup END
endif



" create a go doc comment based on the word under the cursor
function! s:create_go_doc_comment()
  norm "zyiw
  execute ":put! z"
  execute ":norm I// \<Esc>$"
endfunction
nnoremap <leader>ui :<C-u>call <SID>create_go_doc_comment()<CR>



" ==================== vim-go ====================
"
let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_auto_type_info = 0
let g:go_echo_command_info= 0

let g:go_highlight_space_tab_error = 0
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_addtags_transform = "camelcase"

nmap <C-g> :GoDecls<cr>
imap <C-g> <esc>:<C-u>GoDecls<cr>

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#cmd#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

augroup go
  autocmd!

  autocmd FileType go nmap <silent> <Leader>v <Plug>(go-def-vertical)
  autocmd FileType go nmap <silent> <Leader>s <Plug>(go-def-split)

  autocmd FileType go nmap <silent> <Leader>i <Plug>(go-info)
  autocmd FileType go nmap <silent> <Leader>l <Plug>(go-metalinter)

  autocmd FileType go nmap <silent> <leader>b :<C-u>call <SID>build_go_files()<CR>
  autocmd FileType go nmap <silent> <leader>t  <Plug>(go-test)
  autocmd FileType go nmap <silent> <leader>r  <Plug>(go-run)
  autocmd FileType go nmap <silent> <leader>e  <Plug>(go-install)

  autocmd FileType go nmap <silent> <Leader>d <Plug>(go-doc)
  autocmd FileType go nmap <silent> <Leader>c <Plug>(go-coverage-toggle)

  " I like these more!
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
augroup END

" ==================== UltiSnips ====================
function! g:UltiSnips_Complete()
  call UltiSnips#ExpandSnippet()
  if g:ulti_expand_res == 0
    if pumvisible()
      return "\<C-n>"
    else
      call UltiSnips#JumpForwards()
      if g:ulti_jump_forwards_res == 0
        return "\<TAB>"
      endif
    endif
  endif
  return ""
endfunction

function! g:UltiSnips_Reverse()
  call UltiSnips#JumpBackwards()
  if g:ulti_jump_backwards_res == 0
    return "\<C-P>"
  endif

  return ""
endfunction


if !exists("g:UltiSnipsJumpForwardTrigger")
  let g:UltiSnipsJumpForwardTrigger = "<tab>"
endif

if !exists("g:UltiSnipsJumpBackwardTrigger")
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
endif

au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<cr>"

" ==================== Ag ====================
let g:ackprg = 'ag --vimgrep --smart-case'                             
