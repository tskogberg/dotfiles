" Pathogen.vim

" Must turn filetype off and then back on.
filetype off
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on

" Fzf
set rtp+=~/.fzf
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_layout = { 'up': '40%' }
map <silent> <C-p> :Files<CR>

" Files to skip.
" Possibly used by other plugins, like Command-T.
set wildignore+=*.o,*.obj,.git,tmp
set wildignore+=public/uploads,db/sphinx,vim/backup
set wildignore+=.themes  " Octopress.

map <C-b> :CtrlPBuffer<CR>

" Syntastic

let g:syntastic_enable_signs=1
let g:syntastic_quiet_messages = {'level': 'warnings'}
" Slow, so only run on :SyntasticCheck
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [], 'passive_filetypes': [] }
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1

let g:elm_syntastic_show_warnings = 1

" NERDTree

let NERDTreeIgnore=['\.rbc$', '\~$']

" Disable menu.
let g:NERDMenuMode=0

map <leader>n :NERDTreeToggle<CR>
map <leader>N :NERDTreeFindIfFindable<CR>

" Commentary

xmap <leader>c <Plug>Commentary
nmap <leader>c <Plug>Commentary
nmap <leader>cc <Plug>CommentaryLine
nmap <leader>cu <Plug>CommentaryUndo

" Git grep

" Using "a" because it used to be :Ack.
" We need the trailing space.
exe "nnoremap <leader>a :GitGrep "

" Yankstack

" Plugin must redefine mappings before we do.
call yankstack#setup()

" Don't add default keymaps; we'll set our own.
let g:yankstack_map_keys = 0

nmap å <Plug>yankstack_substitute_older_paste
nmap ä <Plug>yankstack_substitute_newer_paste

" vimux

let g:VimuxOrientation = "h"
let g:VimuxUseNearestPane = 1

" turbux

let g:no_turbux_mappings = 1
map M <Plug>SendTestToTmux
map m <Plug>SendFocusedTestToTmux

" CamelCaseMotion

" Make c,w not include the trailing underscore:
" https://github.com/bkad/CamelCaseMotion/issues/10
nmap c,w c,e
nmap ci,w ci,e

" Blockle

" ,b is taken by CamelCaseMotion.
let g:blockle_mapping = '<leader>B'

" Ack.vim

" Use The Silver Searcher.
let g:ackprg = 'ag --nogroup --nocolor --column'

" vim-coffee-script
let g:coffee_compile_vert = 1

" exercism

map § :ExercismTest<CR>

" Shift+§ to run additional tests inlined in the exercise file.
map ° :! ruby %<CR>

" elm-vim
let g:elm_jump_to_error = 0
let g:elm_make_output_file = "elm.js"
let g:elm_make_show_warnings = 0
let g:elm_syntastic_show_warnings = 0
let g:elm_browser_command = ""
let g:elm_detailed_complete = 0
let g:elm_format_autosave = 1
let g:elm_format_fail_silently = 0
let g:elm_setup_keybindings = 0

" air-line
let g:airline#extensions#ale#enabled = 1

" vim-mix-format
let g:mix_format_on_save = 1
let g:mix_format_silent_errors = 1

" coc.nvim

" Ruby: https://github.com/neoclide/coc-solargraph
" ESLint: https://github.com/neoclide/coc-eslint
" TypeScript: https://github.com/neoclide/coc-tsserver
let g:coc_global_extensions = ['coc-solargraph', 'coc-eslint', 'coc-tsserver']

" Fix buggy behaviour where cursor disappears: https://github.com/neoclide/coc.nvim/issues/1775#issuecomment-757764053
let g:coc_disable_transparent_cursor = 1

" In Devbox, use the global node, since per-project nodes may be too old for coc.nvim.
if exists('$DEVBOX')
  let g:coc_node_path = '/devbox/tmp/devbox/binwrappers/node'
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <leader>space coc#refresh()

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
