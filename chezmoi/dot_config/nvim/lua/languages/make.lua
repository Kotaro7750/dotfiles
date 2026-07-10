vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("dotfiles-make", { clear = true }),
  pattern = "make",
  callback = function()
    vim.opt_local.expandtab = false
  end,
})
