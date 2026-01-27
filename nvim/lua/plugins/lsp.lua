return {
  {
    "williamboman/mason.nvim",
    lazy = false
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
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

      local diagnostic_hover_augroup_name = "lspconfig-diagnostic"

      local function enable_diagnostics_hover()
        vim.api.nvim_create_augroup(diagnostic_hover_augroup_name, { clear = true })
        vim.api.nvim_create_autocmd({ "CursorHold" }, {
          group = diagnostic_hover_augroup_name,
          callback = function()
            vim.diagnostic.open_float()
          end
        })
      end

      local function disable_diagnostics_hover()
        vim.api.nvim_clear_autocmds({ group = diagnostic_hover_augroup_name })
      end

      -- diagnosticがある行でホバーをするとすぐにdiagnosticのfloating windowで上書きされてしまうのを阻止する
      -- ホバーをしたら一時的にdiagnosticを開くautocmdを無効化する
      -- これだけだとそれ以降diagnosticが自動表示されなくなってしまうので有効化するautocmdを一回だけ発行して削除する
      local function on_lsp_hover()
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

      local function set_lsp_keymap(bufnr)
        local opt = { noremap = true, silent = true, buffer = bufnr }
        local telescope = require('telescope.builtin')

        vim.keymap.set('n', '<Leader>lf', vim.lsp.buf.format, opt)
        vim.keymap.set('n', '<Leader>lr', vim.lsp.buf.rename, opt)
        vim.keymap.set('n', '<Leader>lR', telescope.lsp_references, opt)
        vim.keymap.set('n', '<Leader>lk', on_lsp_hover, opt)
        vim.keymap.set('n', '<Leader>ld', telescope.lsp_definitions, opt)
        vim.keymap.set('n', '<Leader>lD', vim.lsp.buf.declaration, opt)
        vim.keymap.set('n', '<Leader>li', telescope.lsp_implementations, opt)
      end

      local function unset_lsp_keymap(bufnr)
        local opt = { buffer = bufnr }

        pcall(vim.keymap.del, 'n', '<Leader>lf', opt)
        pcall(vim.keymap.del, 'n', '<Leader>lr', opt)
        pcall(vim.keymap.del, 'n', '<Leader>lR', opt)
        pcall(vim.keymap.del, 'n', '<Leader>lk', opt)
        pcall(vim.keymap.del, 'n', '<Leader>ld', opt)
        pcall(vim.keymap.del, 'n', '<Leader>lD', opt)
        pcall(vim.keymap.del, 'n', '<Leader>li', opt)
      end

      vim.api.nvim_create_autocmd({ "LspAttach" }, {
        callback = function(args)
          enable_diagnostics_hover()
          set_lsp_keymap(args.buf)
        end
      })

      vim.api.nvim_create_autocmd({ "LspDetach" }, {
        callback = function(args)
          disable_diagnostics_hover()
          unset_lsp_keymap(args.buf)
        end
      })

      vim.api.nvim_set_option('updatetime', 500)

      -- servers setup
      vim.lsp.config('*', {
        capabilities = require('cmp_nvim_lsp').default_capabilities()
      })

      local servers = {
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
        "ts_ls",
        "yamlls",
      }

      require("mason").setup {}
      require("mason-lspconfig").setup {
        ensure_installed = servers,
      }

      for _, server_name in ipairs(servers) do
        vim.lsp.enable(server_name)
      end
    end
  }
}
