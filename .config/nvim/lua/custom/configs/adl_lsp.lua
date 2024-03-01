local lspconfig = require 'lspconfig'
local configs = require 'lspconfig.configs'

if not configs.adl_lsp then
  configs.adl_lsp = {
    default_config = {
      cmd = {'archie-lsp'},
      filetypes = {'adl'},
      root_dir = function(fname)
        return lspconfig.util.find_git_ancestor(fname)
      end,
      settings = {},
    },
  }
end
