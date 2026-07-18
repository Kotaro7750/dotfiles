local map = vim.keymap.set

-- Basically, up/downward operation should be done for diplayed line.
-- But, it is intuitive for logical line when relative number is given.
local up = function()
  return vim.v.count == 0 and "gk" or "k"
end

local down = function()
  return vim.v.count == 0 and "gj" or "j"
end

map("n", "j", down, { silent = true, expr = true })
map("n", "k", up, { silent = true, expr = true })
map("n", "<Down>", down, { silent = true, expr = true })
map("n", "<Up>", up, { silent = true, expr = true })

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
