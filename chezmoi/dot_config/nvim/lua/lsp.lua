local capabilities = vim.lsp.protocol.make_client_capabilities()
if capabilities.workspace then
  capabilities.workspace.didChangeWatchedFiles = nil
end

local has_blink, blink = pcall(require, "blink.cmp")
if has_blink then
  capabilities = blink.get_lsp_capabilities(capabilities)
end

vim.lsp.config("*", {
  capabilities = capabilities,
  root_markers = { ".git" },
})

local function open_telescope_quickfix(what)
  vim.fn.setqflist({}, " ", what)
  vim.cmd("Telescope quickfix")
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("dotfiles-lsp", { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    local opts = { buffer = event.buf, silent = true }

    vim.keymap.set("n", "<leader>lf", function()
      vim.lsp.buf.format({ async = true })
    end, vim.tbl_extend("force", opts, { desc = "Format buffer" }))
    vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
    vim.keymap.set("n", "<leader>lR", function()
      vim.lsp.buf.references(nil, { on_list = open_telescope_quickfix })
    end, vim.tbl_extend("force", opts, { desc = "References" }))
    vim.keymap.set("n", "<leader>lk", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover" }))
    vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Definition" }))
    vim.keymap.set("n", "<leader>lD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Declaration" }))
    vim.keymap.set("n", "<leader>li", vim.lsp.buf.implementation,
      vim.tbl_extend("force", opts, { desc = "Implementation" }))

    if client and client:supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
    end

    if client and client:supports_method("textDocument/linkedEditingRange") then
      vim.lsp.linked_editing_range.enable(true, { bufnr = event.buf })
    end

    if client and client:supports_method("textDocument/codeLens") then
      vim.lsp.codelens.enable(true, { bufnr = event.buf, client_id = client.id })
      vim.keymap.set("n", "<leader>lc", vim.lsp.codelens.run, vim.tbl_extend("force", opts, { desc = "CodeLens" }))
    end
  end,
})
