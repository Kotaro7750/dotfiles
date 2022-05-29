-- diagnostic
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = false,
  -- signのデフォルト優先度は10なので呼ばれる順番によっては他のsignで上書きされてしまう
  -- cf. :help sign-priority
  signs = { priority = 11 },
})

local signs = { Error = '✖ ', Warn = '⚠', Hint = '➤', Information = 'ℹ ' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- TODO diagnosticがある行でホバーをすると500msでdiagnosticで上書きされてしまう
local function on_hover()
  if vim.lsp.buf.server_ready() then
    vim.diagnostic.open_float()
  end
end

vim.api.nvim_create_augroup("lspconfig-diagnostic", { clear = true })
vim.api.nvim_set_option('updatetime', 500)
vim.api.nvim_create_autocmd({ "CursorHold" }, { group = "lspconfig-diagnostic", callback = on_hover })

-- servers setup
local on_attach = function(_, bufnr)
  local opt = { noremap = true, silent = true }

  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>lf', '<cmd>lua vim.lsp.buf.format()<CR>', opt)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>lr', '<cmd>lua vim.lsp.buf.rename()<CR>', opt)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>lk', '<cmd>lua vim.lsp.buf.hover()<CR>', opt)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>ld', '<cmd>lua vim.lsp.buf.definition()<CR>', opt)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>lD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opt)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>li', '<cmd>lua vim.lsp.buf.implementation()<CR>', opt)
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local common_setup_option = {
  on_attach = on_attach,
  capabilities = capabilities,
}

local servers = {
  clangd = {},
  rust_analyzer = {},
  sumneko_lua = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' }
        }
      }
    }
  },
}

for server_name, option in pairs(servers) do
  local setup_option = {}

  for property, value in pairs(common_setup_option) do
    setup_option[property] = value
  end

  for property, value in pairs(option) do
    setup_option[property] = value
  end

  require('lspconfig')[server_name].setup(setup_option)
end
