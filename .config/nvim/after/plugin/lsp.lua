local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({ buffer = bufnr })
end)

require("neodev").setup({})
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = { 'tsserver', 'eslint', "lua_ls", "jedi_language_server", "tailwindcss" },
  handlers = {
    lsp_zero.default_setup,
    lua_ls = function()
      require('lspconfig').lua_ls.setup({
        settings = {
          Lua = {
            workspace = {
              checkThirdParty = false
            }
          },
          completions = {
            callSnippet = "Replace"
          }
        }
      })
    end,
    tailwindcss = function()
      require('lspconfig').tailwindcss.setup({
        on_attach = function(client, bufnr)
          require("tailwindcss-colors").buf_attach(bufnr)
        end
      })
    end,
  }
})

local cmp = require('cmp')
local cmp_format = lsp_zero.cmp_format()
local format_kinds = cmp_format.format
local tailwind_colors = require('tailwindcss-colorizer-cmp')

cmp_format.format = function(entry, vim_item)
  format_kinds(entry, vim_item)
  return tailwind_colors.formatter(entry, vim_item)
end

---@diagnostic disable-next-line: missing-fields
cmp.setup({
  formatting = cmp_format,
  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
  })
})
