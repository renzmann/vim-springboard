" Basic editor settings {{{
set nocompatible
filetype plugin on
set background=dark
set encoding=utf-8
set noerrorbells
set visualbell
set cursorline
set hidden
syntax on
set linebreak
set shiftround
set number
set relativenumber
set nowrap
set hlsearch
set wildignore=*.o,*.obj,*.db-whl,*.db-shm,*node_modules*,*.venv*,tags,.*.un~,*.pyc
set list listchars=tab:>\ ,trail:·
set mouse=a
set showcmd
" }}}

" Plugins {{{
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'

" Install vim-plug if it's not found
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Install any missing plugins on launch
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

call plug#begin()
" Basics
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Intellisense
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/cmp-vsnip'
Plug 'williamboman/nvim-lsp-installer'
" Fuzzy menus
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Coloring
if !has('win32')
  Plug 'nvim-treesitter/nvim-treesitter'
endif
Plug 'romainl/Apprentice'
Plug 'morhetz/gruvbox'
Plug 'EdenEast/nightfox.nvim'
Plug 'rebelot/kanagawa.nvim'
Plug 'catppuccin/catppuccin'
Plug 'navarasu/onedark.nvim'
" Languages
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
call plug#end()
" }}}

" Color theme {{{
" Dan's color theme: Apprentice
" colo apprentice
" My favorite: nordfox
" colo nordfox
colo gruvbox
" colo kanagawa
" colo onedark
" let g:airline_theme='base16_nord'
" let g:airline_theme='base16_gruvbox_dark_medium'
" }}}

" Auto-complete (intellisense): {{{
set completeopt=menu,menuone,noselect
lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

      -- Wonky ass error when doing TAB inside python function
      -- ["<Tab>"] = cmp.mapping(function(fallback)
      --   if cmp.visible() then
      --     cmp.select_next_item()
      --   elseif vim.fn["vsnip#available"](1) == 1 then
      --     feedkey("<Plug>(vsnip-expand-or-jump)", "")
      --   elseif has_words_before() then
      --     cmp.complete()
      --   else
      --     fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      --   end
      -- end, { "i", "s" }),

      -- ["<S-Tab>"] = cmp.mapping(function()
      --   if cmp.visible() then
      --     cmp.select_prev_item()
      --   elseif vim.fn["vsnip#jumpable"](-1) == 1 then
      --     feedkey("<Plug>(vsnip-jump-prev)", "")
      --   end
      -- end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  -- cmp.setup.cmdline(':', {
  --   mapping = cmp.mapping.preset.cmdline(),
  --   sources = cmp.config.sources({
  --     { name = 'path' }
  --   }, {
  --     { name = 'cmdline' }
  --   })
  -- })

EOF
" }}}

" Language Servers: {{{
" Copied from the suggestions in the nvim-lspconfig README:
" https://github.com/neovim/nvim-lspconfig
lua << EOF
require('nvim-lsp-installer').setup { automatic_installation = true }
local lspconfig = require('lspconfig')

local on_attach = function(client, bufnr)
  local opts = { noremap=true, silent=true }
  -- The bindings here override very similar ones in base vim, and isn't a spot
  -- to add new bindings.  See after/plugin/keymap.vim for those.
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<CMD>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<CMD>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K',  '<CMD>lua vim.lsp.buf.hover()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local servers = {
  "bashls",
  "yamlls",
  -- "rust_analyzer",
  "pyright",
}
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup { on_attach = on_attach, capabilities = capabilities }
end

-- gopls setup
-- Make sure that $GOPATH/bin is on $PATH after installing gopls for this to work
-- cd $HOME && mkdir -p tmp && cd tmp && go install golang.org/x/tools/gopls@latest
-- lspconfig["gopls"].setup { cmd = {'gopls', '--remote=auto'}, capabilities = capabilities }

-- julia setup
-- Make sure to run julia and from the package manager prompt:
-- ] add LanguageServer SymbolServer
-- lspconfig["julials"].setup {
--   cmd = {
--     "julia",
--     "--startup-file=no",
--     "--history-file=no",
--     "-e", [[
--       using Pkg;
--       Pkg.instantiate()
--       using LanguageServer; using SymbolServer;
--       depot_path = get(ENV, "JULIA_DEPOT_PATH", "")
--       project_path = dirname(something(Base.current_project(pwd()), Base.load_path_expand(LOAD_PATH[2])))
--       # Make sure that we only load packages from this environment specifically.
--       @info "Running language server" env=Base.load_path()[1] pwd() project_path depot_path
--       server = LanguageServer.LanguageServerInstance(stdin, stdout, project_path, depot_path);
--       server.runlinter = true;
--       run(server);
--     ]]
--   },
--   capabilities = capabilities,
-- }
EOF

" Format on save
augroup lspfmt
  autocmd!
  autocmd BufWritePre *.go,*.rs lua vim.lsp.buf.formatting()
augroup END

" Uncomment to enable automatic opening of location list with LSP diagnostics
" augroup lsp_loclist
"   autocmd!
"   autocmd BufWrite,BufEnter,InsertLeave * :call LspLocationList()
" augroup END

" }}}

"  TreeSitter: {{{
if !has('win32')
  lua <<EOF
  require('nvim-treesitter.configs').setup {
    ensure_installed = { "python", "bash", "lua", "vim" },
    highlight = { enable = true },
    indent = { enable = true },
  }
EOF
end
"  }}}
