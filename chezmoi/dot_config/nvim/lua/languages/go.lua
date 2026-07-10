vim.lsp.config("gopls", {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_markers = { "go.work", "go.mod", ".git" },
  init_options = {
    usePlaceholders = true,
  },
  settings = {
    gopls = {
      codelenses = {
        test = true,
        generate = true,
        regenerate_cgo = true,
        run_govulncheck = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
      },
    },
  },
})

vim.lsp.enable("gopls")
