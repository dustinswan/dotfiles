vim.g.mapleader = ' '
vim.g.maplocalleader = ','
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.timeoutlen = 100
vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.o.inccommand = "split"
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.termguicolors = true
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.laststatus = 3 -- global status line
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.scrolloff = 8
vim.opt.updatetime = 50

vim.api.nvim_create_autocmd('FileType', { pattern = 'org', command = 'setlocal nowrap' })
vim.api.nvim_create_autocmd('TextYankPost', {
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch' }
  end,
})

local ensure_packer = function()
  local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'felipec/vim-sanegx'
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
  use 'folke/neodev.nvim'
  use 'jamessan/vim-gnupg'
  use 'dhruvasagar/vim-table-mode'
  use 'mfussenegger/nvim-dap'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'LnL7/vim-nix'
  use 'AndrewRadev/splitjoin.vim'

  use {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    requires = { 'nvim-lua/plenary.nvim' }
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }

  use { 'nvim-orgmode/orgmode', config = function()
    require('orgmode').setup_ts_grammar()

    require 'nvim-treesitter.configs'.setup {
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'org' }, -- Required for spellcheck, some LaTex highlights and code block highlights that do not have ts grammar
      },
      ensure_installed = { 'org' }, -- Or run :TSUpdate org
    }

    require('orgmode').setup({
      org_agenda_files = { '~/Sync/Notes/*' },
      org_default_notes_file = '~/Sync/Notes/Main.org',
    })
  end }

  use {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      require("catppuccin").setup {
        flavour = "mocha", -- mocha, macchiato, frappe, latte
        transparent_background = true
      }
      vim.api.nvim_command "colorscheme catppuccin"
    end
  }

  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function() require('lualine').setup() end
  }

  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup({
        plugins = {
          spelling = {
            enabled = true
          }
        }
      })
    end
  }

  use {
    'akinsho/bufferline.nvim',
    ag = "v3.*",
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require("bufferline").setup()
    end
  }

  use 'nvim-tree/nvim-web-devicons'

  use {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    }
  }

  use({
    "folke/noice.nvim",
    event = "VimEnter",
    config = function()
      require("noice").setup()
      require("notify").setup({
        background_colour = "#000000"
      })
    end,
    requires = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  })
  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    },
    config = function()
      local lsp = require('lsp-zero')
      lsp.preset('recommended')
      lsp.setup()
    end
  }

  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup({
        toggler = {
          line = '<leader>cc',
          block = '<leader>cb',
        },
        opleader = {
          line = '<leader>cc',
          block = '<leader>cb',
        }
      })
    end
  }

  use {
    'JoosepAlviste/nvim-ts-context-commentstring',
    config = function()
      require 'nvim-treesitter.configs'.setup({
        context_commentstring = {
          enable = true
        }
      })
    end
  }

  use {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require 'alpha'.setup(require 'alpha.themes.startify'.config)
    end
  }

  use {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup {}
    end
  }

  use {
    'alexghergh/nvim-tmux-navigation', config = function()
      require 'nvim-tmux-navigation'.setup {
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
  }

  use {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      require("null-ls").setup({
        -- sources = {
        -- 	require("null-ls").builtins.formatting.stylua,
        -- 	require("null-ls").builtins.diagnostics.eslint,
        -- 	require("null-ls").builtins.completion.spell,
        -- },
      })
    end,
    requires = { "nvim-lua/plenary.nvim" }
  }

  use {
    "akinsho/toggleterm.nvim", tag = '*', config = function()
      require("toggleterm").setup({
        direction = 'float',
        open_mapping = [[<c-t>]]
      })
    end
  }

  use {
    'ggandor/leap.nvim',
    config = function()
      require('leap').add_default_mappings()
    end
  }

  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup()
    end
  }

  use {
    'notjedi/nvim-rooter.lua',
    config = function()
      require 'nvim-rooter'.setup()
    end
  }

  use({ 'sindrets/winshift.nvim',
    config = function()
      require("winshift").setup()
    end
  })

  use("mbbill/undotree");

  use({
    "roobert/search-replace.nvim",
    config = function()
      require("search-replace").setup()
    end
  })

  if packer_bootstrap then
    require('packer').sync()
  end
end)

local wk = require("which-key")

wk.register({
  ["<leader>"] = {
    a = { ":Alpha<cr>", "Alpha" },
    b = {
      name = "Buffer",
      d = { ":bdelete!<cr>", "Delete" },
      b = { "<cmd>Telescope buffers<cr>", "Buffers" },
      t = { ":Neotree buffers<cr>", "Tree" },
    },
    c = "Comment",
    f = {
      name = "File",
      f = { "<cmd>Telescope find_files<cr>", "Files" },
      g = { "<cmd>Telescope live_grep<cr>", "Grep" },
      r = { "<cmd>Telescope oldfiles<cr>", "Recent" },
      t = { ":Neotree<cr>", "Tree" },
      d = { ":cd %:p:h<cr>", "Set Directory" },
    },
    g = {
      name = "Git",
      g = { ":2TermExec cmd='gitui'<cr>", "Gitui" },
      t = { ":Neotree git_status<cr>", "Tree" },
      b = { ":Gitsigns blame_line<cr>", "Blame" },
      d = { ":DiffviewOpen<cr>", "Diff" },
      h = { ":DiffviewFileHistory<cr>", "History" },
    },
    F = { ":lua vim.lsp.buf.format()<cr>", "Format" },
    J = { ":SplitjoinJoin<cr>", "Join" },
    t = {
      name = "Table",
      m = "Toggle Table Mode",
      t = "Tableize",
      r = { ":TableModeRealign<cr>", "Realign" },
      e = { ":TableEvalFormulaLine<cr>", "Evaluate" },
    },
    w = {
      name = "Window",
      s = { ":WinShift<cr>", "Shift" },
    },
    o = "Org",
    p = {
      name = "Packer",
      s = { ":PackerSync<cr>", "Sync" },
    },
    S = { ":SplitjoinSplit<cr>", "Split" },
    T = { ":TroubleToggle<cr>", "Trouble" },
    u = { ":UndoTreeToggle<cr>", "UndoTree" },
    r = {
      name = "Replace",
      s = { "<CMD>SearchReplaceSingleBufferSelections<CR>", "selction list" },
      o = { "<CMD>SearchReplaceSingleBufferOpen<CR>", "open" },
      w = { "<CMD>SearchReplaceSingleBufferCWord<CR>", "word" },
      W = { "<CMD>SearchReplaceSingleBufferCWORD<CR>", "WORD" },
      e = { "<CMD>SearchReplaceSingleBufferCExpr<CR>", "expr" },
      f = { "<CMD>SearchReplaceSingleBufferCFile<CR>", "file" },
      b = {
        name = "MultiBuffer",
        s = { "<CMD>SearchReplaceMultiBufferSelections<CR>","selction list" },
        o = { "<CMD>SearchReplaceMultiBufferOpen<CR>", "open" },
        w = { "<CMD>SearchReplaceMultiBufferCWord<CR>", "word" },
        W = { "<CMD>SearchReplaceMultiBufferCWORD<CR>", "WORD" },
        e = { "<CMD>SearchReplaceMultiBufferCExpr<CR>", "expr" },
        f = { "<CMD>SearchReplaceMultiBufferCFile<CR>", "file" },
      },
    },
  },
  ["<S-l>"] = { ":BufferLineCycleNext<cr>", "Next Tab" },
  ["<S-h>"] = { ":BufferLineCyclePrev<cr>", "Previous Tab" },
})
