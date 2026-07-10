vim.loader.enable()

-- Core editor setup
require("options")
require("plugin_manager")
require("keymaps")

-- LSP core
require("lsp")

-- Language-specific LSP setup
require("languages.astro")
require("languages.awk")
require("languages.bash")
require("languages.c")
require("languages.go")
require("languages.json")
require("languages.lua")
require("languages.make")
require("languages.python")
require("languages.qf")
require("languages.rust")
require("languages.terraform")
require("languages.typescript")
require("languages.yaml")
require("languages.copilot")

-- Randomly select a colorscheme from the list each time Neovim starts
local colorscheme = {
  "kanagawa-wave",
  "duskfox", "nightfox", "tokyonight",
  "nord",
  "iceberg",
  "catppuccin-frappe", "catppuccin-macchiato", "catppuccin-mocha"
}
-- math.random is not used here because it would require seeding
vim.cmd.colorscheme(colorscheme[os.time() % #colorscheme + 1])
