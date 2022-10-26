vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.termguicolors = true
vim.opt.completeopt = "menu,menuone,noselect"

require('packer').startup(function(use)
	use {
		'wbthomason/packer.nvim',
		config = function()
			vim.keymap.set('n', '<leader>ps', ":PackerSync<cr>", { silent = true })
		end
	}

	use {
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		requires = { 'nvim-lua/plenary.nvim' },
		config = function()
			local builtin = require('telescope.builtin')
			vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
			vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
			vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
			vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
		end,
	}

	use {
		'nvim-treesitter/nvim-treesitter',
		run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
	}

	use { 'nvim-orgmode/orgmode', config = function()
		require('orgmode').setup_ts_grammar()

		require'nvim-treesitter.configs'.setup {
			-- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = {'org'}, -- Required for spellcheck, some LaTex highlights and code block highlights that do not have ts grammar
			},
			ensure_installed = {'org'}, -- Or run :TSUpdate org
		}

		require('orgmode').setup({
			org_agenda_files = {'~/Sync/Notes/*'},
			org_default_notes_file = '~/Sync/Notes/Main.org',
		})
	end}

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

	use "folke/neodev.nvim"

	use {
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup({
				plugins = {
					spelling = { enabled = true }
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
			
			vim.keymap.set("n", "<S-l>", ":BufferLineCycleNext<cr>", { silent = true })
			vim.keymap.set("n", "<S-h>", ":BufferLineCyclePrev<cr>", { silent = true })
		end
	}

	use {
		'nvim-tree/nvim-tree.lua',
		requires = {
			'nvim-tree/nvim-web-devicons', -- optional, for file icons
		},
		tag = 'nightly', -- optional, updated every week. (see issue #1193)
		config = function()
			require("nvim-tree").setup()
			vim.keymap.set('n', '<leader>e', ":NvimTreeToggle<cr>", { silent = true })
		end
	}

	use({
		"folke/noice.nvim",
		event = "VimEnter",
		config = function()
			require("noice").setup()
		end,
		requires = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		}
	})

	use "rafamadriz/friendly-snippets"

	use({
		"L3MON4D3/LuaSnip",
		tag = "v<CurrentMajor>.*",
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end
	})

	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'saadparwaiz1/cmp_luasnip'
	use 'dmitmel/cmp-digraphs'
	use 'uga-rosa/cmp-dictionary'
	use 'kdheepak/cmp-latex-symbols'

	use {
		'hrsh7th/nvim-cmp',
		config = function ()
			local has_words_before = function()
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			local luasnip = require("luasnip")
			local cmp = require("cmp")

			cmp.setup({
				snippet = {
					expand = function(args)
						require'luasnip'.lsp_expand(args.body)
					end
				},
				
				sources = {
					{ name = 'luasnip' },
					{ name = 'buffer' },
					{ name = 'path' },
					{ name = 'nvim_lsp' },
					-- { name = 'digraphs' },
					{ name = "latex_symbols" },
					{ name = 'dictionary', keyword_length = 2 },
				},

				mapping = {
					['<CR>'] = cmp.mapping.confirm {
						behavior = cmp.ConfirmBehavior.Replace,
						select = false,
					},

					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}
			})
		end
	}

	use {
		'neovim/nvim-lspconfig',
		config = function()
			-- require'lspconfig'.eslint.setup{}
			require'lspconfig'.tsserver.setup{}
		end
	}

	use {
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end
	}

	use {
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup({
				-- toggler = {
				-- 	line = '<leader>cc',
				-- 	block = '<leader>cb',
				-- }
			})
		end
	}

	use {
		'JoosepAlviste/nvim-ts-context-commentstring',
		config = function()
			require'nvim-treesitter.configs'.setup({
				context_commentstring = {
					enable = true
				}
			})
		end
	}

	use 'nvim-tree/nvim-web-devicons'

	use {
		'goolord/alpha-nvim',
		requires = { 'kyazdani42/nvim-web-devicons' },
		config = function()
			require'alpha'.setup(require'alpha.themes.startify'.config)
			vim.keymap.set('n', '<leader>;', ":Alpha<cr>", { silent = true })
		end
	}

	use {
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup {}
		end
	}

	use 'LnL7/vim-nix'

	use {
		'alexghergh/nvim-tmux-navigation', config = function()
			require'nvim-tmux-navigation'.setup {
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

	use "lukas-reineke/indent-blankline.nvim"

	use {
		"akinsho/toggleterm.nvim", tag = '*', config = function()
			require("toggleterm").setup({
				open_mapping = [[<c-t>]],
				direction = 'float',
				float_opts = {
					border = "curved"
				}
			})
		end
	}

	use 'mfussenegger/nvim-dap'

	use {
		'ggandor/leap.nvim',
		config = function()
			require('leap').add_default_mappings()
		end
	}

	use 'tpope/vim-surround'
	use 'tpope/vim-repeat'
	use 'felipec/vim-sanegx'

	use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

	use {
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({
				vim.keymap.set('n', '<leader>t', ":TroubleToggle<cr>", { silent = true })
			})
		end
	}

	use {
		'dhruvasagar/vim-table-mode',
		config = function()
			vim.keymap.set('n', '<leader>TT', ":Tableize<cr>", { silent = true })
		end
	}
end)
