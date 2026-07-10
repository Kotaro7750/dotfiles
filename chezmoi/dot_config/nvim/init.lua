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
