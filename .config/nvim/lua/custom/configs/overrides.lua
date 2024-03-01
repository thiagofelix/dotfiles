local M = {}

M.treesitter = {
	ensure_installed = {
		"vim",
		"lua",
		"html",
		"css",
		"javascript",
		"typescript",
		"tsx",
		"c",
		"markdown",
		"markdown_inline",
		"svelte",
		"vimdoc",
	},
	indent = {
		enable = true,
		-- disable = {
		--   "python"
		-- },
	},
}

M.mason = {
	ensure_installed = {
		-- lua stuff
		"lua-language-server",
		"stylua",

		-- web dev stuff
		"css-lsp",
		"html-lsp",
		"typescript-language-server",
		"deno",
		"prettier",

		-- c/cpp stuff
		"clangd",
		"clang-format",
	},
}

M.nvimtree = {
	git = {
		enable = false,
	},

	view = {
		width = 40,
	},
}

M.copilot = {
	suggestion = { enabled = false },
	panel = { enabled = true },
	filetypes = {
		yaml = true,
		markdown = true,
	},
}

M.cmp = function(_, opts)
  local format_kinds = opts.formatting.format
  local format_tailwind = require("tailwindcss-colorizer-cmp").formatter

	opts.sources = {
		{ name = "nvim_lsp" },
		{ name = "copilot" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "nvim_lua" },
		{ name = "path" },
	}

	opts.formatting.format = function(entry, item)
    format_kinds(entry, item)
    return format_tailwind(entry, item)
  end

end

M.telescope = {
	pickers = {
		find_files = {
			hidden = false,
		},
		live_grep = {
			additional_args = {
				"--hidden",
			},
		},
	},
}

return M
