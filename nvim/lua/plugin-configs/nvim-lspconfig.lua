-- diagnostic
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    -- signのデフォルト優先度は10なので呼ばれる順番によっては他のsignで上書きされてしまう
    -- cf. :help sign-priority
    signs = { priority = 11 },
    severity_sort = true,
  })

local signs = { Error = '', Warn = '', Hint = '', Information = '' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local function on_cursor_hold()
  if vim.lsp.buf.server_ready() then
    vim.diagnostic.open_float()
  end
end

local diagnostic_hover_augroup_name = "lspconfig-diagnostic"

local function enable_diagnostics_hover()
  vim.api.nvim_create_augroup(diagnostic_hover_augroup_name, { clear = true })
  vim.api.nvim_create_autocmd({ "CursorHold" }, { group = diagnostic_hover_augroup_name, callback = on_cursor_hold })
end

local function disable_diagnostics_hover()
  vim.api.nvim_clear_autocmds({ group = diagnostic_hover_augroup_name })
end

vim.api.nvim_set_option('updatetime', 500)
enable_diagnostics_hover()

-- servers setup
local on_attach = function(_, bufnr)
  local opt = { noremap = true, silent = true, buffer = bufnr }

  local telescope = require('telescope.builtin')

  -- diagnosticがある行でホバーをするとすぐにdiagnosticのfloating windowで上書きされてしまうのを阻止する
  -- ホバーをしたら一時的にdiagnosticを開くautocmdを無効化する
  -- これだけだとそれ以降diagnosticが自動表示されなくなってしまうので有効化するautocmdを一回だけ発行して削除する
  local function on_hover()
    disable_diagnostics_hover()

    vim.lsp.buf.hover()

    vim.api.nvim_create_augroup("lspconfig-enable-diagnostics-hover", { clear = true })
    -- ウィンドウの切り替えなどのイベントが絡んでくるとおかしくなるかもしれない
    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" },
      {
        group = "lspconfig-enable-diagnostics-hover",
        callback = function()
          vim.api.nvim_clear_autocmds({ group = "lspconfig-enable-diagnostics-hover" })
          enable_diagnostics_hover()
        end
      })
  end

  vim.keymap.set('n', '<Leader>lf', vim.lsp.buf.format, opt)
  vim.keymap.set('n', '<Leader>lr', vim.lsp.buf.rename, opt)
  vim.keymap.set('n', '<Leader>lR', telescope.lsp_references, opt)
  vim.keymap.set('n', '<Leader>lk', on_hover, opt)
  vim.keymap.set('n', '<Leader>ld', telescope.lsp_definitions, opt)
  vim.keymap.set('n', '<Leader>lD', vim.lsp.buf.declaration, opt)
  vim.keymap.set('n', '<Leader>li', telescope.lsp_implementations, opt)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local common_setup_option = {
  on_attach = on_attach,
  capabilities = capabilities,
}

require("mason").setup {}
require("mason-lspconfig").setup {
  ensure_installed = {
    "astro",
    "awk_ls",
    "bashls",
    "clangd",
    "gopls",
    "jsonls",
    "lua_ls",
    "pylsp",
    "rust_analyzer",
    "terraformls",
    "tsserver",
    "yamlls",
  }
}

local servers = {
  astro = {},
  awk_ls = {},
  bashls = {},
  clangd = {},
  gopls = {
    init_options = {
      usePlaceholders = true,
    },
  },
  jsonls = {},
  lua_ls = {
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
  },
  pylsp = {},
  rust_analyzer = {},
  terraformls = {},
  tsserver = {},
  yamlls = {},
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
