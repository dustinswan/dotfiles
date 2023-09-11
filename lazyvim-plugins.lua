return {
  { "catppuccin/nvim", name = "catppuccin" },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },

  {
    "nvim-orgmode/orgmode",
    config = function()
      require("orgmode").setup_ts_grammar()

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
}
