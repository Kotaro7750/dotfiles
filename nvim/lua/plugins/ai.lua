return {
  {
    "github/copilot.vim",
    config = function(opts)
      vim.g.copilot_proxy_strict_ssl = false

      vim.keymap.set('i', '<C-J>', 'copilot#Accept("")', {
        expr = true,
        replace_keycodes = false
      })
      vim.g.copilot_no_tab_map = true

      require("copilot").setup(opts)
    end
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim" },
    },
    config = true,
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    opts = {
      provider = 'copilot',
      behaviour = {
        enable_cursor_planning_mode = true, -- enable cursor planning mode!
      },
      providers = {
        copilot = {
          model = "claude-sonnet-4",
        },
      },
      windows = {
        width = 40,
        sidebar_header = {
          enabled = true,   -- true, false to enable/disable the header
          align = "center", -- left, center, right for title
          rounded = false,
        }
      },
      file_selector = {
        provider = "telescope",
      },
      -- -- Below are for MCPHub see. https://github.com/ravitemer/mcphub.nvim?tab=readme-ov-file#avantenvim
      -- -- The system_prompt type supports both a string and a function that returns a string. Using a function here allows dynamically updating the prompt with mcphub
      system_prompt = function()
        local hub = require("mcphub").get_hub_instance()
        return hub and hub:get_active_servers_prompt() or ""
      end,
      -- -- The custom_tools type supports both a list and a function that returns a list. Using a function here prevents requiring mcphub before it's loaded
      custom_tools = function()
        return {
          require("mcphub.extensions.avante").mcp_tool(),
        }
      end,
    },
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      -- "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp",              -- autocompletion for avante commands and mentions
      "nvim-tree/nvim-web-devicons",   -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua",        -- for providers='copilot'
      "MeanderingProgrammer/render-markdown.nvim",
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
    },
  },
  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = "MCPHub",
    build = "bundled_build.lua",
    config = function()
      require("mcphub").setup({
        config = vim.fn.expand("~/dotfiles/nvim/mcphub_config.json"),
        shutdown_delay = 5000,
        extensions = {
          avante = {}
        },
        use_bundled_binary = true,

        global_env = function(context)
          local env = {
            MCPHUB_PROJECT_ROOT = require("lspconfig.util").root_pattern(".git")(vim.fn.getcwd()) or vim.fn.getcwd()
          }

          -- Add context-aware variables
          if context.is_workspace_mode then
            env.MCPHUB_PROJECT_ROOT = context.workspace_root
          end
          return env
        end,

        workspace = {
          enabled = true,
          look_for = { ".mcphub/servers.json", ".vscode/mcp.json", ".cursor/mcp.json" },
          reload_on_dir_changed = true,
        }
      })
    end,
  }
}
