return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      'nvim-lua/plenary.nvim',
      { "nvim-tree/nvim-web-devicons", opts = {} },
      "nvim-telescope/telescope-file-browser.nvim",
    },
    config = function()
      local telescope = require('telescope')
      local actions = require('telescope.actions')

      telescope.setup({
        defaults = {
          initial_mode = "normal",
          borderchars = { '━', '┃', '━', '┃', '┏', '┓', '┛', '┗' },
          prompt_prefix = ' ',
          selection_caret = '',
          mappings = {
            n = {
              -- Close telescope window by 'q' not '<ESC>'
              ["<esc>"] = false,
              ["q"] = actions.close,
            }
          },
        },
        pickers = {
          buffers = {
            mappings = {
              n = {
                ["d"] = actions.delete_buffer,
              },
            },
          },
        },
        extensions = {
          file_browser = {
            grouped = true,
            respect_gitignore = true,
            hidden = true,
          },
        },
      })

      telescope.load_extension('file_browser')

      -- ----------
      -- Keymap
      -- ----------
      vim.api.nvim_set_keymap('n', '<Leader>db', ':Telescope buffers<CR>', { silent = true, noremap = true })
      vim.keymap.set('n', '<Leader>df', function()
        telescope.extensions.file_browser.file_browser({
          path = vim.fn.expand('%:p:h'),
          select_buffer = true,
        })
      end, { silent = true, noremap = true, desc = 'Telescope file browser' })
      vim.api.nvim_set_keymap('n', '<Leader>dg', ':Telescope live_grep<CR>', { silent = true, noremap = true })
    end
  }
}
