return {
  {
    "nvim-telescope/telescope.nvim", -- Required ripgrep and fd are managed by brew
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "nvim-telescope/telescope-file-browser.nvim",
    },
    keys = {
      { "<leader>db", "<Cmd>Telescope buffers<CR>",   silent = true, desc = "Buffers" },
      { "<leader>dg", "<Cmd>Telescope live_grep<CR>", silent = true, desc = "Live grep" },
      {
        "<leader>df",
        function()
          require("telescope").extensions.file_browser.file_browser({
            path = vim.fn.expand("%:p:h"),
            select_buffer = true,
          })
        end,
        silent = true,
        desc = "File browser",
      },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          initial_mode = "normal",
          borderchars = { "━", "┃", "━", "┃", "┏", "┓", "┛", "┗" },
          mappings = {
            n = {
              ["<esc>"] = false,
              ["q"] = actions.close,
            },
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

      telescope.load_extension("file_browser")
    end,
  },
  {
    "hedyhli/outline.nvim",
    cmd = { "Outline", "OutlineOpen" },
    lazy = true,
    keys = {
      { "<leader>so", "<cmd>Outline<CR>", silent = true, desc = "Toggle outline" },
    },
    opts = {
      position = 'left'
    }
  },
}
