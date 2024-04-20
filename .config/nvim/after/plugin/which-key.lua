local wk = require("which-key")

wk.register({
  ["<leader>"] = {
    b = { "<cmd>:Neotree toggle show buffers right<cr>", "Open buffers" },
    f = { "<cmd>Telescope live_grep<cr>", "Find in files" },
    o = { "<cmd>Telescope oldfiles<cr>", "Open recent files" },
    x = {
      x = { "<cmd>:TroubleToggle<cr>", "Trouble" },
      d = { "<cmd>:TroubleToggle document_diagnostics<cr>", "Document diagnostics" },
      w = { "<cmd>:TroubleToggle workspace_diagnostics<cr>", "Workspace diagnostics" },
      q = { "<cmd>:TroubleToggle quickfix<cr>", "Quickfix" },
      l = { "<cmd>:TroubleToggle loclist<cr>", "Loclist" },
      ["gR"] = { "<cmd>:TroubleToggle lsp_references<cr>", "LSP references" },
    }
  },
  ["|"] = { "<cmd>:Neotree toggle reveal<cr>", "Toggle Neotree" },
  ["<c-p>"] = { "<cmd>Telescope find_files<cr>", "Find files" },
});
