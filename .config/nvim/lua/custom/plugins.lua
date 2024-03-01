local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

	-- Override plugin definition options
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- format & linting
			{
				"jose-elias-alvarez/null-ls.nvim",
				config = function()
					require("custom.configs.null-ls")
				end,
			},
		},
		config = function()
			require("custom.configs.adl_lsp")
			require("plugins.configs.lspconfig")
			require("custom.configs.lspconfig")
		end, -- Override to setup mason-lspconfig
	},

	-- override plugin configs
	{
		"williamboman/mason.nvim",
		opts = overrides.mason,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		opts = overrides.treesitter,
	},

	{
		"nvim-tree/nvim-tree.lua",
		opts = overrides.nvimtree,
	},

	-- Install a plugin
	{
		"max397574/better-escape.nvim",
		event = "InsertEnter",
		config = function()
			require("better_escape").setup()
		end,
	},

	{
		"zbirenbaum/copilot.lua",
		lazy = false,
		opts = overrides.copilot,
	},

	{
		"zbirenbaum/copilot-cmp",
		lazy = false,
		config = function()
			require("copilot_cmp").setup()
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		opts = overrides.cmp,
		dependencies = {
			{
				"roobert/tailwindcss-colorizer-cmp.nvim",
				config = true,
			},
		},
	},

	{
		"nvim-telescope/telescope.nvim",
		opts = overrides.telescope,
	},

	{
		"windwp/nvim-autopairs",
		enabled = false,
	},

	{
		"NvChad/nvim-colorizer.lua",
		opts = {
			user_default_options = {
				tailwind = true,
			},
		},
	},
}

return plugins
