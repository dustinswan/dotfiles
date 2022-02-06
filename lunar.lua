lvim.log.level = "warn"
lvim.format_on_save = true
lvim.leader = "space"
lvim.colorscheme = "nord"
lvim.transparent_window = true

lvim.builtin.dashboard.active = true
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.treesitter.highlight.enabled = true

lvim.plugins = {
  { "ChristianChiarulli/nvcode-color-schemes.vim" },
  { "nacro90/numb.nvim", event = "BufRead", config = function() require("numb").setup() end },
  { "npxbr/glow.nvim", ft = { "markdown" } },
  { "tpope/vim-repeat" },
  { "tpope/vim-surround" },
  { "ggandor/lightspeed.nvim", event = "BufRead" },
  {
    'wfxr/minimap.vim',
    config = function()
      vim.cmd ("let g:minimap_auto_open = 0")
      vim.cmd ("let g:minimap_highlight_range = 1")
      vim.cmd ("let g:minimap_highlight_search = 1")
      vim.cmd ("let g:minimap_git_colors = 1")
    end,
  },
  { "folke/trouble.nvim", cmd = "TroubleToggle" },
  { "folke/todo-comments.nvim", event = "BufRead", config = function() require("todo-comments").setup() end },
  { "ray-x/lsp_signature.nvim", event = "BufRead", config = function() require "lsp_signature".setup() end },
  { "lukas-reineke/indent-blankline.nvim", event = "BufRead" },
  {
    "nvim-neorg/neorg",
    tag = "latest",
    config = function()
      require('neorg').setup()
    end,
    requires = "nvim-lua/plenary.nvim"
  },
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

lvim.builtin.which_key.mappings["m"] = { "<cmd>MinimapToggle<cr>", "Toggle Minimap" }
lvim.builtin.which_key.mappings["B"] = { "<cmd>BlamerShow<cr>", "Show Blamer" }
