vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("dotfiles-qf", { clear = true }),
  pattern = "qf",
  callback = function(event)
    vim.keymap.set("n", "p", "<CR>zz<C-w>p", { buffer = event.buf, silent = true })
  end,
})
