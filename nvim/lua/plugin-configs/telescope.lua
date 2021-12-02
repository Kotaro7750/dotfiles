require('telescope').setup({
  defaults = {
    initial_mode = "normal",
    borderchars = {'-','|','-','|','*','*','*','*'},
    mappings = {
      n = {
        -- Close telescope window by 'q' not '<ESC>'
        ["<esc>"] = false,
        ["q"] = require('telescope.actions').close,
      }
    },
  },
})

-- ----------
-- Keymap
-- ----------
vim.api.nvim_set_keymap('n','<Leader>db',':Telescope buffers<CR>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n','<Leader>df',':Telescope find_files<CR>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n','<Leader>dg',':Telescope live_grep<CR>', {silent = true, noremap = true})
