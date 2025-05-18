---@type vim.lsp.Config
return {
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace"
      },
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
}
