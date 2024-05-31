return {

  { "tpope/vim-sleuth" },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        transparent_background = true,
      })
    end,
  },

  -- {
  -- 	"f-person/auto-dark-mode.nvim",
  -- 	config = {
  -- 		set_dark_mode = function()
  -- 			vim.api.nvim_set_option("background", "dark")
  -- 			vim.cmd("colorscheme catppuccin")
  -- 			-- vim.cmd("colorscheme rose-pine")
  -- 		end,
  -- 		set_light_mode = function()
  -- 			vim.api.nvim_set_option("background", "light")
  -- 			vim.cmd("colorscheme catppuccin")
  -- 			-- vim.cmd("colorscheme rose-pine")
  -- 		end,
  -- 	},
  -- },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
      background_colour = "#000000",
    },
  },

  {
    "nvim-orgmode/orgmode",
    config = function()
      -- require("orgmode").setup_ts_grammar()

      require("nvim-treesitter.configs").setup({
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = { "org" }, -- Required for spellcheck, some LaTex highlights and code block highlights that do not have ts grammar
        },
        ensure_installed = { "org" }, -- Or run :TSUpdate org
      })

      require("orgmode").setup({
        org_agenda_files = { "~/Sync/Notes/*" },
        org_default_notes_file = "~/Sync/Notes/Main.org",
      })
    end,
  },

  { "dhruvasagar/vim-table-mode" },

  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = true,
    keys = {
      { [[<C-\>]] },
      {
        "<leader>TT",
        "<cmd>ToggleTerm direction=horizontal<cr>",
        desc = "Open a horizontal terminal",
      },
      {
        "<leader>TV",
        "<cmd>ToggleTerm size=60 direction=vertical<cr>",
        desc = "Open a vertical terminal",
      },
    },
  },

  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },

  { "lukas-reineke/headlines.nvim", opts = { org = { fat_headlines = false } } },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "php",
      })
    end,
  },
}
