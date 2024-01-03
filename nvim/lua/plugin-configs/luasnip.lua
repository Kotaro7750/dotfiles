local luasnip = require('luasnip')

vim.keymap.set({ "i" }, "<C-k>",
  function()
    if luasnip.expand_or_jumpable() then
      luasnip.expand_or_jump()
    end
  end,
  { silent = true }
)

vim.keymap.set({ "i", "s" }, "<C-n>",
  function()
    if luasnip.jumpable(1) then
      luasnip.jump(1)
    end
  end,
  { silent = true }
)

vim.keymap.set({ "i", "s" }, "<C-p>",
  function()
    if luasnip.jumpable(-1) then
      luasnip.jump(-1)
    end
  end,
  { silent = true }
)

require("luasnip.loaders.from_vscode").load()
