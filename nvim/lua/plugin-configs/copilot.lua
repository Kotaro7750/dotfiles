vim.g.copilot_proxy_strict_ssl = false

vim.keymap.set('i', '<C-J>', 'copilot#Accept("")', {
  expr = true,
  replace_keycodes = false
})
vim.g.copilot_no_tab_map = true
