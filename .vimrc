call plug#begin('~/.vim/plugged')

" build & run
Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim'

" C/C++ auto complete
" need to install from plugin folder
Plug 'ycm-core/YouCompleteMe' 
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
Plug 'Shougo/echodoc.vim'

" tags
Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/gutentags_plus'
Plug 'skywind3000/vim-preview'

" fuzzy search
Plug 'Yggdroot/LeaderF', {'do': './install.sh'}

" git
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'sodapopcan/vim-twiggy'
Plug 'junegunn/gv.vim'
Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-conflicted'

" c/c++, python syntax highlight
Plug 'octol/vim-cpp-enhanced-highlight'
" need to pip install jedi
Plug 'davidhalter/jedi-vim'
Plug 'hdima/python-syntax'

" lint
Plug 'dense-analysis/ale'

Plug 'NLKNguyen/papercolor-theme'
Plug 'vim-airline/vim-airline'
Plug 'wlemuel/vim-tldr'
" Initialize plugin system
call plug#end()
"
" General
"
let mapleader = ","
map <leader>vimrc :tabe ~/.vimrc<cr>
autocmd bufwritepost .vimrc source $MYVIMRC
set splitbelow


"
" AsyncRun
"
let g:asyncrun_open = 6
noremap <silent> <leader>tb :AsyncTask file-build<cr>
noremap <silent> <leader>tr :AsyncTask file-run<cr>
noremap <silent> <leader>td :AsyncTask file-debug<cr>



"
" VimSpector
"
"F5		When debugging, continue. Otherwise start debugging.	vimspector#Continue()
"F3		Stop debugging.	vimspector#Stop()
"F4		Restart debugging with the same configuration.	vimspector#Restart()
"F6		Pause debugee.	vimspector#Pause()
"F9		Toggle line breakpoint on the current line.	vimspector#ToggleBreakpoint()
"F8		Add a function breakpoint for the expression under cursor	vimspector#AddFunctionBreakpoint( '<cexpr>' )
"F10		Step Over	vimspector#StepOver()
"F11		Step Into	vimspector#StepInto()
"F12		Step out of current function scope	vimspector#StepOut()
"
"F5		When debugging, continue. Otherwise start debugging.	vimspector#Continue()
"Shift F5	Stop debugging.	vimspector#Stop()
"Ctrl Shift F5	Restart debugging with the same configuration.	vimspector#Restart()
"F6		Pause debugee.	vimspector#Pause()
"F9		Toggle line breakpoint on the current line.	vimspector#ToggleBreakpoint()
"Shift F9	Add a function breakpoint for the expression under cursor	vimspector#AddFunctionBreakpoint( '<cexpr>' )
"F10		Step Over	vimspector#StepOver()
"F11		Step Into	vimspector#StepInto()
"Shift F11	Step out of current function scope	vimspector#StepOut()
let g:vimspector_enable_mappings = 'VISUAL_STUDIO'
packadd! vimspector



"
" vim-Gutentags
"
" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root']
let g:gutentags_add_default_project_roots = 0
let g:gutentags_cache_dir = expand('~/.cache/tags')

" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'

let $GTAGSLABEL = 'native-pygments'
let $GTAGSCONF = '/usr/local/share/gtags/gtags.conf'
let g:gutentags_modules = []
if executable('ctags')
	let g:gutentags_modules += ['ctags']
endif
if executable('gtags-cscope') && executable('gtags')
	let g:gutentags_modules += ['gtags_cscope']
endif
" 配置 ctags 的参数，老的 Exuberant-ctags 不能有 --extra=+q，注意
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" 如果使用 universal ctags 需要增加下面一行，老的 Exuberant-ctags 不能加下一行
" let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

" 禁用 gutentags 自动加载 gtags 数据库的行为
let g:gutentags_auto_add_gtags_cscope = 0
" change focus to quickfix window after search (optional).
let g:gutentags_define_advanced_commands = 1

set statusline+=%{gutentags#statusline()}


"
"　gutentags_plus
"  
let g:gutentags_plus_switch = 1
let g:gutentags_plus_nomap = 1
" Find symbol (reference) under cursor
noremap <silent> <leader>gs :GscopeFind s <C-R><C-W><cr>
" Find symbol definition under cursor
noremap <silent> <leader>gg :GscopeFind g <C-R><C-W><cr>
" Functions called by this function
noremap <silent> <leader>gc :GscopeFind c <C-R><C-W><cr>
" Functions calling this function
noremap <silent> <leader>gt :GscopeFind t <C-R><C-W><cr>
" Find text string under cursor
noremap <silent> <leader>ge :GscopeFind e <C-R><C-W><cr>
" Find egrep pattern under cursor
noremap <silent> <leader>gf :GscopeFind f <C-R>=expand("<cfile>")<cr><cr>
" Find file name under cursor
noremap <silent> <leader>gi :GscopeFind i <C-R>=expand("<cfile>")<cr><cr>
" Find files #including the file name under cursor
noremap <silent> <leader>gd :GscopeFind d <C-R><C-W><cr>
" Find places where current symbol is assigned
noremap <silent> <leader>ga :GscopeFind a <C-R><C-W><cr>
autocmd FileType qf nnoremap <silent><buffer> p :PreviewQuickfix<cr>
autocmd FileType qf nnoremap <silent><buffer> P :PreviewClose<cr>

"
" YouCompleteME
"
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_confirm_extra_conf = 0


"
" EchoDoc 
"
set noshowmode
let g:echodoc_enable_at_startup = 1


"
" LeaderF
"
" don't show the help in normal mode
let g:Lf_HideHelp = 1
let g:Lf_UseCache = 0
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1
" popup mode
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline" }
let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }
let g:Lf_RootMarkers = ['.root']
let g:Lf_DefaultExternalTool="find"

let g:Lf_ShortcutF = "<leader>ff"
noremap <leader>fp :<C-U><C-R>=printf("Leaderf function %s", "")<CR><CR>
noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>

noremap <C-B> :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR>
noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>
" search visually selected text literally
xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>
noremap go :<C-U>Leaderf! rg --recall<CR>

" should use `Leaderf gtags --update` first
let g:Lf_GtagsAutoGenerate = 1
let g:Lf_Gtagslabel = 'native-pygments'
noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>

"
"paper color 
"
set t_Co=256   " This is may or may not needed.

set background=dark
colorscheme PaperColor

"
" python syntaxt
"
let python_highlight_all = 1

"
" Jedi-vim 
"
let g:jedi#smart_auto_mappings = 0

"
" ALE
"
let g:ale_linters_explicit = 1
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:ale_linters = { 'sh' : ['shellcheck'] }

let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''


"
" Airline
"
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

"
" tldr
"
let g:tldr_directory_path = '~/.cache/tldr'
let g:tldr_split_type = 'horizontal'
