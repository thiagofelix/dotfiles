local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "nvim-lua/plenary.nvim",
  "nvim-tree/nvim-web-devicons",
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      pickers = {
        find_files = {
          hidden = true
        }
      }
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  "folke/which-key.nvim",
  "folke/neoconf.nvim",
  "folke/tokyonight.nvim",
  { "folke/neodev.nvim", opts = {} },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = {
      filesystem = {
        filtered_items = {
          hide_dotfiles = false
        }
      },
      event_handlers = {
        {
          event = "neo_tree_buffer_enter",
          handler = function(_)
            vim.opt_local.foldenable = false
          end,
        },
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      'j-hui/fidget.nvim'
    }
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-git",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "roobert/tailwindcss-colorizer-cmp.nvim",
    },
    opts = function(_, opts)
      local cmp = require('cmp')

      return vim.tbl_deep_extend("force", opts, {
        formatting = {
          format = function(entry, item)
            return require('tailwindcss-colorizer-cmp').formatter(entry, item)
          end
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        snippet = {
          expand = function(args)
            require 'luasnip'.lsp_expand(args.body)
          end
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = 'vsnip' },
          { name = 'path' }
        }, {
          { name = 'buffer' }
        })
      })
    end,
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" }
  },
  {
    "zbirenbaum/copilot.lua",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<M-a>",
          accept_word = "<M-;>",
          accept_line = "<M-'>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      filetypes = {
        ["*"] = true
      }
    },
  },
  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      user_default_options = {
        tailwindcss = true
      }
    }
  },
  {
    'nvimtools/none-ls.nvim',
    config = function()
      local null_ls = require('null-ls')
      null_ls.setup({
        sources = {
--         null_ls.builtins.formatting.isort,
--         null_ls.builtins.formatting.black,
--          null_ls.builtins.formatting.djhtml,
          null_ls.builtins.diagnostics.djlint,
          null_ls.builtins.formatting.djlint,
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.rustywind.with({
            extra_filetypes = { 'htmldjango' }
          }),
        }
      })
    end
  }
})
