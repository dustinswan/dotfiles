{ ... }:

{
  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    withRuby = true;

    colorschemes.catppuccin.enable = true;
    colorschemes.catppuccin.settings.transparent_background = true;

    opts = {
      number = true;
      ignorecase = true;
      smartcase = true;

      tabstop = 4;
      shiftwidth = 4;
      softtabstop = 0;
      expandtab = true;
      smarttab = true;

      clipboard = "unnamedplus";
    };

    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    keymaps = [
      { key = "<leader>e"; action = "<cmd>Neotree toggle<cr>"; }
      { key = "<leader>ff"; action = "<cmd>Telescope find_files<cr>"; }
      { key = "<leader>fr"; action = "<cmd>Telescope oldfiles<cr>"; }
      { key = "<leader>bd"; action = "<cmd>bdelete<cr>"; }
      { key = "<S-l>"; action = "<cmd>bnext<cr>"; }
      { key = "<S-h>"; action = "<cmd>bprev<cr>"; }
    ];

    plugins = {
      bufferline.enable = true;
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings.sources = [
          { name = "nvim_lsp"; }
          { name = "path"; }
          { name = "buffer"; }
        ];
      };
      cmp-nvim-lsp.enable = true;
      cmp-buffer.enable = true;
      cmp-path.enable = true;
      codeium-nvim.enable = true;
      commentary.enable = true;
      # conform-nvim.enable = true;
      dashboard.enable = true;
      emmet.enable = true;
      gitsigns.enable = true;
      lazygit.enable = true;
      lint.enable = true;
      lualine.enable = true;
      luasnip.enable = true;
      lsp = { 
        enable = true;
        inlayHints = true;
        servers = {
          eslint.enable = true;
          html.enable = true;
          lua-ls.enable = true;
          nil-ls.enable = true;
          # phpactor.enable = true;
          intelephense.enable = true;
          # rust-analyzer.enable = true;
          tsserver.enable = true;

        };
      };
      lsp-format.enable = true;
      lsp-lines.enable = true;
      neo-tree.enable = true;
      notify.enable = true;
      nix.enable = true;
      noice.enable = true;
      nvim-autopairs.enable = true;
      oil.enable = true;
      orgmode = {
        enable = true;
        settings.org_agenda_files = "~/Sync/Notes/*";
        settings.org_default_notes_file = "~/Sync/Notes/Main.org";
      };
      persistence.enable = true;
      surround.enable = true;
      telescope.enable = true;
      tmux-navigator.enable = true;
      todo-comments.enable = true;
      treesitter.enable = true;
      trouble.enable = true;
      ts-autotag.enable = true;
      which-key.enable = true;
    };
  };
}
