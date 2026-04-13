---@diagnostic disable: undefined-global

-- Options
vim.o.number = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smarttab = true
vim.o.clipboard = 'unnamedplus'
vim.o.completeopt = 'menuone,noselect,popup'

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Autocmds
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.cg',
  command = 'setlocal tabstop=2 shiftwidth=2',
})

-- Helper
local gh = function(repo) return 'https://github.com/' .. repo end

-- Plugins
vim.pack.add({
  -- Dependencies
  gh('nvim-lua/plenary.nvim'),                -- lua utility functions used by many plugins
  gh('MunifTanjim/nui.nvim'),                 -- UI component library used by neo-tree
  gh('nvim-tree/nvim-web-devicons'),          -- file type icons

  -- Theme
  gh('folke/tokyonight.nvim'),                -- auto light/dark theme, follows OS appearance

  -- UI
  gh('akinsho/bufferline.nvim'),              -- tab bar for open buffers, :bnext/:bprev
  gh('nvim-lualine/lualine.nvim'),            -- status line at bottom
  gh('nvim-neo-tree/neo-tree.nvim'),          -- file explorer, <leader>e to toggle
  gh('folke/which-key.nvim'),                 -- shows available keybinds after pressing a key
  gh('folke/trouble.nvim'),                   -- diagnostics list, <leader>xx to toggle
  gh('folke/todo-comments.nvim'),             -- highlights TODO/FIXME/HACK in comments

  -- Editor
  gh('folke/flash.nvim'),                     -- quick jump, press s then type target chars
  gh('kylechui/nvim-surround'),                -- cs"' to change surrounding " to '
  gh('windwp/nvim-autopairs'),                -- auto-close brackets and quotes
  gh('cappyzawa/trim.nvim'),                  -- highlights and trims trailing whitespace
  gh('christoomey/vim-tmux-navigator'),       -- ctrl-h/j/k/l to move between vim and tmux panes
  gh('folke/persistence.nvim'),               -- auto-saves and restores sessions per directory

  -- Git
  gh('lewis6991/gitsigns.nvim'),              -- git diff markers in the sign column

  -- Formatting
  gh('nvimtools/none-ls.nvim'),               -- bridge external formatters/linters to LSP

  -- Language support
  gh('hat0uma/csvview.nvim'),                 -- aligned column view for CSV files
  gh('mattn/emmet-vim'),                      -- expand abbreviations, e.g. div>ul>li then ctrl-y,
  gh('nvim-orgmode/orgmode'),                 -- org-mode notes/agenda in nvim
  { src = gh('nvim-treesitter/nvim-treesitter'), version = 'main' }, -- syntax tree parsing for highlighting/code nav

  -- AI
  gh('supermaven-inc/supermaven-nvim'),       -- inline ghost-text suggestions, Tab to accept

  -- Fuzzy finder
  gh('alexpasmantier/television.nvim'),       -- fuzzy finder, <leader>f for files, <leader>/ for text
}, { confirm = false })

-- Theme (auto light/dark based on OS appearance)
require('tokyonight').setup({
  -- style = 'storm',
  -- light_style = 'day',
})
vim.cmd.colorscheme('tokyonight')

-- Plugin configs
require('bufferline').setup()
require('lualine').setup()
require('neo-tree').setup({})
require('which-key').setup()
require('trouble').setup()
require('todo-comments').setup()
require('flash').setup({ jump = { autojump = true } })
require('nvim-surround').setup()
require('nvim-autopairs').setup()
require('trim').setup({
  highlight = true,
  trim_on_write = false,
  ft_blocklist = { 'dashboard' },
})
require('persistence').setup()
require('gitsigns').setup()
require('csvview').setup()
require('supermaven-nvim').setup({})
require('orgmode').setup({
  org_agenda_files = '~/Sync/Notes/*',
  org_default_notes_file = '~/Sync/Notes/Main.org',
})
-- none-ls (blade_formatter)
local null_ls = require('null-ls')
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.blade_formatter,
  },
})

-- Treesitter
vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

-- New UI (0.12+)
require('vim._core.ui2').enable({})

-- Diagnostics
vim.diagnostic.config({ virtual_lines = true })

-- LSP
vim.lsp.config('*', {
  root_markers = { '.git' },
})

vim.lsp.config('elixirls', {
  cmd = { 'elixir-ls' },
  filetypes = { 'elixir', 'eelixir', 'heex', 'surface' },
  root_markers = { 'mix.exs', '.git' },
})

vim.lsp.config('html', {
  cmd = { 'vscode-html-language-server', '--stdio' },
  filetypes = { 'html' },
})

vim.lsp.config('lua_ls', {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },
  settings = {
    Lua = { runtime = { version = 'LuaJIT' } },
  },
})

vim.lsp.config('nixd', {
  cmd = { 'nixd' },
  filetypes = { 'nix' },
  root_markers = { 'flake.nix', 'default.nix', 'shell.nix', '.git' },
})

vim.lsp.config('intelephense', {
  cmd = { 'intelephense', '--stdio' },
  filetypes = { 'php' },
  root_markers = { 'composer.json', '.git' },
})

vim.lsp.config('ts_ls', {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
  root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
})

vim.lsp.config('roc_ls', {
  cmd = { 'roc_language_server' },
  filetypes = { 'roc' },
  root_markers = { '.git' },
})

vim.lsp.enable({
  'elixirls', 'html', 'lua_ls', 'nixd',
  'intelephense', 'ts_ls', 'roc_ls',
})

-- LSP attach: completion + inlay hints
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method('textDocument/inlayHint') then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    end
    vim.lsp.completion.enable(true, args.data.client_id, args.buf)
  end,
})

-- Keymaps
vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle<cr>')
vim.keymap.set('n', '<leader>f', '<cmd>Tv files<cr>')
vim.keymap.set('n', '<leader>/', '<cmd>Tv text<cr>')
vim.keymap.set('n', '<leader>bd', '<cmd>bdelete<cr>')
vim.keymap.set('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>')
vim.keymap.set('n', '<S-l>', '<cmd>bnext<cr>')
vim.keymap.set('n', '<S-h>', '<cmd>bprev<cr>')
vim.keymap.set({ 'n', 'x', 'o' }, 's', function() require('flash').jump() end, { desc = 'Flash' })
vim.keymap.set({ 'n', 'x', 'o' }, 'S', function() require('flash').treesitter() end, { desc = 'Flash Treesitter' })

-- Completion keymaps
vim.keymap.set('i', '<Tab>', function()
  local suggestion = require('supermaven-nvim.completion_preview')
  if suggestion.has_suggestion() then
    suggestion.on_accept_suggestion()
    return
  end
  return vim.fn.pumvisible() == 1 and '<C-n>' or '<Tab>'
end, { expr = true })
vim.keymap.set('i', '<S-Tab>', function()
  return vim.fn.pumvisible() == 1 and '<C-p>' or '<S-Tab>'
end, { expr = true })
vim.keymap.set('i', '<CR>', function()
  return (vim.fn.pumvisible() == 1 and vim.fn.complete_info({ 'selected' }).selected >= 0)
    and '<C-y>' or '<CR>'
end, { expr = true })
