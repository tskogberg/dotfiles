" Pathogen.vim

" Must turn filetype off and then back on.
filetype off
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on

" Fzf
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_layout = { 'down': '40%' }
map <C-p> :FZF<CR>

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

" ale

let g:ale_fixers = {'elixir': []}

" Enable completion where available.
let g:ale_completion_enabled = 1

" invoke 'bundle exec rubocop' in order for rubocop to pickup local configuration
let g:ale_ruby_rubocop_executable = "bundle"

" Set this variable to 1 to fix files when you save them.
let g:ale_fix_on_save = 1

" air-line
let g:airline#extensions#ale#enabled = 1

" vim-mix-format
let g:mix_format_on_save = 1
let g:mix_format_silent_errors = 1
