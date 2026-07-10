return {
  -- Cool status line
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "auto",
        section_separators = { left = "", right = "" },
        component_separators = { left = "/", right = "/" },
        disabled_filetypes = {
          statusline = {
            "TelescopePrompt",
            "Outline",
          },
        },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          "branch",
          "diff",
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            symbols = { error = " ", warn = " ", hint = " ", info = " " },
            update_in_insert = false,
          },
        },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = {
          {
            "lsp_status",
            icon = " ",
          },
          "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },
}
