vim.lsp.config("awk_ls", {
  cmd = { "awk-language-server" },
  filetypes = { "awk" },
  root_markers = { ".git" },
})

vim.lsp.enable("awk_ls")
