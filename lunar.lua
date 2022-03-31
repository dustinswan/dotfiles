lvim.log.level = "warn"
lvim.format_on_save = false
lvim.leader = "space"
lvim.colorscheme = "nord"
lvim.transparent_window = true
-- vim.opt.cmdheight = 1
vim.opt.conceallevel = 2 -- TODO: only for org files

lvim.builtin.alpha.mode = 'startify'
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.treesitter.highlight.enabled = true

lvim.builtin.nvimtree.setup.hijack_netrw = false -- to get gx working again
lvim.builtin.nvimtree.setup.disable_netrw = true -- TODO: but it isn't working

table.insert(lvim.builtin.cmp.sources, { name = "orgmode" })

lvim.plugins = {
  { "shaunsingh/nord.nvim" },
  -- { "rose-pine/neovim" },
  -- { "folke/tokyonight.nvim" },
  { 'dhruvasagar/vim-table-mode' },
  { 'michaelb/sniprun', run = 'bash ./install.sh' },
  { "nacro90/numb.nvim", event = "BufRead", config = function() require("numb").setup() end },
  { "npxbr/glow.nvim", ft = { "markdown" } },
  { "tpope/vim-repeat" },
  { "tpope/vim-surround" },
  { "ggandor/lightspeed.nvim", event = "BufRead" },
  { "folke/trouble.nvim", cmd = "TroubleToggle" },
  { "folke/todo-comments.nvim", event = "BufRead", config = function() require "todo-comments".setup() end },
  { "ray-x/lsp_signature.nvim", event = "BufRead", config = function() require "lsp_signature".setup() end },
  { "lukas-reineke/indent-blankline.nvim", event = "BufRead" },
  {
    "nvim-orgmode/orgmode",
    config = function()
      require('orgmode').setup_ts_grammar()

      require('orgmode').setup {
        org_agenda_files = {'~/Sync/Notes/*'},
        org_default_notes_file = '~/Sync/Notes/Main.org',
        org_log_done = false,
        -- org_todo_keywords = {'TODO', 'WAIT', '|', 'DONE'},
      }
      -- vim.opt.conceallevel = 1
    end
  },
  { "akinsho/org-bullets.nvim",
    config = function()
      require("org-bullets").setup {
        symbols = { "◉", "○", "✸" }
      }
    end
  },
  -- {
  --   'lukas-reineke/headlines.nvim',
  --   config = function()
  --     require('headlines').setup()
  --   end,
  -- },
  {
    'rmagatti/goto-preview',
    config = function()
      require('goto-preview').setup {
        default_mappings = true,
      }
    end
  },
  { "APZelos/blamer.nvim" },
  { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' },
  -- {
  --   'f-person/auto-dark-mode.nvim',
  --   config = function()
  --     local auto_dark_mode = require('auto-dark-mode')
  --     auto_dark_mode.setup({
  --       set_dark_mode = function()
  --         -- vim.api.nvim_set_option('background', 'dark')
  --         -- vim.cmd('colorscheme rose-pine')
  --       end,
  --       set_light_mode = function()
  --         -- vim.api.nvim_set_option('background', 'light')
  --         -- vim.cmd('colorscheme rose-pine')
  --       end
  --     })
  --     auto_dark_mode.init()
  --   end
  -- },
  { "jamessan/vim-gnupg" },
  { "simrat39/symbols-outline.nvim" },
  { "voldikss/vim-floaterm" },
  { "github/copilot.vim" },
  { 'alexghergh/nvim-tmux-navigation', config = function()
        require'nvim-tmux-navigation'.setup {
            disable_when_zoomed = true, -- defaults to false
            keybindings = {
                left = "<C-h>",
                down = "<C-j>",
                up = "<C-k>",
                right = "<C-l>",
                last_active = "<C-\\>",
                next = "<C-Space>",
            }
        }
    end
  },
}

lvim.builtin.which_key.mappings["t"] = {
  name = "Diagnostics",
  t = { "<cmd>TroubleToggle<cr>", "trouble" },
  w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "workspace" },
  d = { "<cmd>TroubleToggle document_diagnostics<cr>", "document" },
  q = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
  l = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
  r = { "<cmd>TroubleToggle lsp_references<cr>", "references" },
}
lvim.builtin.which_key.mappings["T"] = {
  name = "Table Mode",
  t = { "<cmd>:TableModeToggle<cr>", "Toggle enable" },
  e = { "<cmd>:TableEvalFormulaLine<cr>", "Eval formula line" },
  T = { "<cmd>:TableModeRealign<cr>", "Realign" },
}

lvim.builtin.which_key.mappings["B"] = { "<cmd>BlamerShow<cr>", "Show Blamer" }
lvim.builtin.which_key.mappings["S"] = { "<cmd>SymbolsOutline<cr>", "Symbols Outline" }

-- Org mode stuff

-- local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
-- parser_config.org = {
--   install_info = {
--     url = 'https://github.com/milisims/tree-sitter-org',
--     revision = 'f110024d539e676f25b72b7c80b0fd43c34264ef',
--     files = {'src/parser.c', 'src/scanner.cc'},
--   },
--   filetype = 'org',
-- }

-- require'nvim-treesitter.configs'.setup {
--   -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
--   highlight = {
--     enable = true,
--     disable = {'org'}, -- Remove this to use TS highlighter for some of the highlights (Experimental)
--     additional_vim_regex_highlighting = {'org'}, -- Required since TS highlighter doesn't support all syntax features (conceal)
--   },
--   ensure_installed = {'org'}, -- Or run :TSUpdate org
-- }

-- require('orgmode').setup({
--   org_agenda_files = {'~/Dropbox/org/*', '~/my-orgs/**/*'},
--   org_default_notes_file = '~/Dropbox/org/refile.org',
-- })

-- Prettier configuration
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    exe = "prettier",
    -- filetypes = { "javascriptreact", "javascript", "typescriptreact", "typescript", "json", "markdown", },
  },
}

-- ESLint
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  {
    exe = "eslint",
    -- filetypes = { "javascriptreact", "javascript", "typescriptreact", "typescript", "vue", },
  },
}
