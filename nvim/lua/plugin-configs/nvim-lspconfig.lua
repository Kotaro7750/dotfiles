-- diagnostic
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    signs = true,
  }
)

local signs = { Error = '✖ ', Warn = '⚠', Hint = '➤', Information = 'ℹ ' }
for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local function on_hover()
  if vim.lsp.buf.server_ready() then
    vim.diagnostic.open_float()
  end
end

vim.api.nvim_create_augroup("lspconfig-diagnostic",{clear=true})
vim.api.nvim_set_option('updatetime',500)
vim.api.nvim_create_autocmd({"CursorHold"},{group = "lspconfig-diagnostic",callback = on_hover})

-- servers setup
local on_attach = function(client, bufnr)
  local opt = { noremap=true, silent = true }

  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>lf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opt)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>lr', '<cmd>lua vim.lsp.buf.rename()<CR>', opt)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>lk', '<cmd>lua vim.lsp.buf.hover()<CR>', opt)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>ld', '<cmd>lua vim.lsp.buf.definition()<CR>', opt)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>lD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opt)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>li', '<cmd>lua vim.lsp.buf.implementation()<CR>', opt)
end

require('lspconfig').clangd.setup({
  cmd = {'clangd-9'},
  on_attach = on_attach,
})

require('lspconfig').rls.setup({
  on_attach = on_attach,
})

