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
    colorschemes.catppuccin.settings.flavour = "auto";

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
      { key = "<leader>f"; action = "<cmd>Tv files<cr>"; }
      { key = "<leader>/"; action = "<cmd>Tv text<cr>"; }
      { key = "<leader>bd"; action = "<cmd>bdelete<cr>"; }
      { key = "<leader>nd"; action = "<cmd>NoiceDismiss<cr>"; }
      { key = "<leader>xx"; action = "<cmd>Trouble diagnostics toggle<cr>"; }
      { key = "<S-l>"; action = "<cmd>bnext<cr>"; }
      { key = "<S-h>"; action = "<cmd>bprev<cr>"; }
    ];

    plugins = {
      # avante.enable = true;
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
      codecompanion = {
        enable = true;
        settings = {
          strategies = {
            chat = { adapter = "claude_code"; };
            inline = { adapter = "claude_code"; };
          };
        };
      };
      commentary.enable = true;
      csvview.enable = true;
      dashboard.enable = true;
      emmet.enable = true;
      flash.enable = true;
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
          elixirls.enable = true;
          html.enable = true;
          lua_ls.enable = true;
          nil_ls.enable = true;
          # phpactor.enable = true;
          intelephense.enable = true;
          intelephense.package = null;
          # rust-analyzer.enable = true;
          ts_ls.enable = true;
          roc_ls.enable = true;
          roc_ls.package = null;
        };
      };
      none-ls = {
        enable = true;
        sources.formatting.blade_formatter.enable = true;
        sources.formatting.blade_formatter.package = null;
      };
      # lsp-format.enable = true;
      lsp-lines.enable = true;
      # markview.enable = true;
      neo-tree.enable = true;
      notify.enable = true;
      nix.enable = true;
      noice.enable = true;
      nvim-autopairs.enable = true;
      orgmode = {
        enable = true;
        settings.org_agenda_files = "~/Sync/Notes/*";
        settings.org_default_notes_file = "~/Sync/Notes/Main.org";
      };
      persistence.enable = true;
      vim-surround.enable = true;
      tmux-navigator.enable = true;
      todo-comments.enable = true;
      treesitter.enable = true;
      trim = {
        enable = true;
        settings = {
          highlight = true;
          trim_on_write = false;
        };
      };
      trouble.enable = true;
      ts-autotag.enable = true;
      tv.enable = true;
      web-devicons.enable = true;
      which-key.enable = true;
    };

    # extraPlugins = [(pkgs.vimUtils.buildVimPlugin {
    #   name = "vim-lumen";
    #   src = pkgs.fetchFromGitHub {
    #     owner = "f-person";
    #     repo = "auto-dark-mode.nvim";
    #     rev = "4531f8b2b09ed8f0b8875a706419f9cecda1d969";
    #     hash = "sha256-JPoyRRwDJ9KOGWnqOEG4VkEX4rJHFhFYV3bwS9F2f9E=";
    #   };
    # })];

    # extraConfigLua = ''
    #   local auto_dark_mode = require('auto-dark-mode')
    #   auto_dark_mode.setup()
    # '';
  };
}
