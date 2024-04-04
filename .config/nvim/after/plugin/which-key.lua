local wk = require("which-key")

wk.register({
  ["<leader>"] = {
    b = { "<cmd>:Neotree toggle show buffers right<cr>", "Open buffers" },
  },
  --g = {
  --  p = { "<cmd>:silent %!prettier --stdin-filepath %<cr>", "Prettier" },
  --},
  ["|"] = { "<cmd>:Neotree toggle reveal<cr>", "Toggle Neotree" },
  ["<c-p>"] = { "<cmd>Telescope find_files<cr>", "Find files" },
});
