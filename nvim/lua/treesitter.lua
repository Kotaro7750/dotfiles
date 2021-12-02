require('nvim-treesitter.configs').setup({
  -- Install only parsers which are maintained by someone automatically
  ensure_installed = "maintained",
  highlight = {
    enable = true,

    -- Disable vim built-in highlighting
    additional_vim_regex_highlighting = false
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },

  indent = {
    enable = false,
  },
})
