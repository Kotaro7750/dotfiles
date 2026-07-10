local map = vim.keymap.set

map("n", "j", "gj", { silent = true })
map("n", "k", "gk", { silent = true })
map("n", "<Down>", "gj", { silent = true })
map("n", "<Up>", "gk", { silent = true })

map("n", "<Esc>", "<Cmd>nohlsearch<CR>", { silent = true })

map("n", "]d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next diagnostic" })

map("n", "[d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Previous diagnostic" })

map("n", "<leader>e", function()
  vim.diagnostic.open_float(nil, { scope = "line" })
end, { desc = "Line diagnostics" })

map("n", "<leader>q", function()
  vim.diagnostic.setqflist({ open = true })
end, { desc = "Diagnostics to quickfix" })
