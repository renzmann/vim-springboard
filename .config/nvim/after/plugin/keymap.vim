" =============================================================================
"                              Keyboard Shortcuts
" =============================================================================
" Search for [<letter>] to see what's mapped under <leader><letter>.
" e.g. /[s will take you to the settings navigation section.

" Faster scrolling
nnoremap <C-e>                2<C-E>
nnoremap <C-y>                2<C-Y>

" Make spacebar the leader key
let mapleader=" "
nnoremap <Space>              <Nop>

" Case-insensitive search
" nnoremap <leader>/            /\c<Left><Left>

" Make `cgn` operate on the currently selected word
" https://vi.stackexchange.com/a/18895
nnoremap <silent>cgn          :<C-u>let @/=expand('<cword>')<cr>cgn

" Capitalize last word while inserting text
" inoremap <C-j>                <Esc>gUiwea

" [v]imscript execution
" -----------------------------------------------------------------------
" Execute the whole line under cursor in normal mode
" nnoremap <silent><leader>ve   yy:@"<CR>0
" Execute visual selection
" vnoremap <silent><leader>ve   y:@"<CR>

" [s]ettings navigation
" -----------------------------------------------------------------------
" nnoremap <silent><leader>si   :<C-u>e $MYVIMRC<CR>
" nnoremap <silent><leader>sk   :<C-u>e ~/.config/nvim/after/plugin/keymap.vim<CR>
" nnoremap <silent><leader>sap  :<C-u>e ~/.config/nvim/after/plugin<CR>
" nnoremap <silent><leader>saf  :<C-u>e ~/.config/nvim/after/ftplugin<CR>

" [t]ree view of the CWD or current file's directory
" -----------------------------------------------------------------------
" nnoremap <silent><leader>t    :<C-u>30Lexplore<CR>
" nnoremap <silent><leader>T    :<C-u>30Lexplore %:p:h<CR>

" Markdown and RST headers [1] [2] [3] [4]
" -----------------------------------------------------------------------
" nnoremap <leader>1            yypVr=
" nnoremap <leader>2            yypVr-
" nnoremap <leader>3            yypVr+
" nnoremap <leader>4            yypVr*
" onoremap ih                   :<C-U>execute "normal! ?^==\\+$\r:nohlsearch\rkvg_"<CR>

" Tab movement [h] [l]
" -----------------------------------------------------------------------
" nnoremap <silent><leader>h    :<C-u>tabp<CR>
" nnoremap <silent><leader>l    :<C-u>tabn<CR>

" [c]lipboard [c]ommands
" -----------------------------------------------------------------------
" nnoremap <leader>cv           "+p
" vnoremap <leader>cv           "+p
" vnoremap <leader>cc           "+y

" [f]ind things
" -----------------------------------------------------------------------
" nnoremap <leader>ff         :Files<CR>
" nnoremap <leader>fb         :Buffers<CR>
" nnoremap <leader>fg         :GitFiles<CR>
" nnoremap <leader>ft         :Tags<CR>
" nnoremap <leader>fr         :Rg<CR>
" nnoremap <leader>fa         :<C-u>e ~/.aws/credentials<CR>

" Language server bindings
" -----------------------------------------------------------------------
inoremap <silent><C-s>         <ESC>l:lua vim.lsp.buf.signature_help()<CR>i
nnoremap <silent><leader>wa    :lua vim.lsp.buf.add_workspace_folder()<CR>
nnoremap <silent><leader>wr    :lua vim.lsp.buf.remove_workspace_folder()<CR>
nnoremap <silent><leader>wl    :lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>
" [r]ename
nnoremap <silent><leader>rn    :lua vim.lsp.buf.rename()<CR>
" [g]o references
nnoremap <silent><leader>gr    :lua vim.lsp.buf.references()<CR>
" [d]iagnostics
nnoremap <silent><leader>de    :lua vim.diagnostic.open_float()<CR>
nnoremap <silent><leader>dn    :lua vim.diagnostic.goto_next()<CR>
nnoremap <silent><leader>dp    :lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent><leader>dq    :lua vim.diagnostic.setqflist()<CR>
