-- nvim-lsp-installerのsetupはnvim-lspconfigの設定よりも前に行わないといけない
-- deinではロード順の制御はできなさそうだったのでnvim-lsp-installerの設定はここから手動で読み込む
-- cf. https://github.com/williamboman/nvim-lsp-installer#setup
require("plugin-configs/nvim-lsp-installer")

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
  local opt = { noremap = true, silent = true, buffer = bufnr }

  local telescope = require('telescope.builtin')

  vim.keymap.set('n', '<Leader>lf', vim.lsp.buf.format, opt)
  vim.keymap.set('n', '<Leader>lr', vim.lsp.buf.rename, opt)
  vim.keymap.set('n', '<Leader>lR', telescope.lsp_references, opt)
  vim.keymap.set('n', '<Leader>lk', vim.lsp.buf.hover, opt)
  vim.keymap.set('n', '<Leader>ld', telescope.lsp_definitions, opt)
  vim.keymap.set('n', '<Leader>lD', vim.lsp.buf.declaration, opt)
  vim.keymap.set('n', '<Leader>li', telescope.lsp_implementations, opt)
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local common_setup_option = {
  on_attach = on_attach,
  capabilities = capabilities,
}

local servers = {
  clangd = {},
  rls = {},
  jsonls = {},
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
