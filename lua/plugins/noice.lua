
-- init.lua (or your plugins spec file)
local plugins = {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",  -- enable format on save
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        javascript = { "prettierd" },
        -- add your formatters here
      },
      log_level = vim.log.levels.INFO,
      format_on_save = true,  -- conform supports this option
    },
    config = function(_, opts)
      require("conform").setup(opts)

      -- Optional: Notify on successful format on save
      vim.api.nvim_create_autocmd("BufWritePost", {
        callback = function()
          vim.notify("File formatted and saved!", vim.log.levels.INFO)
        end,
      })
    end,
  },

  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "pyright",
          "ts_ls",       -- updated tsserver to ts_ls
          "jdtls",
          "gopls",
          "rust_analyzer",
        },
        automatic_installation = true,
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")

      local servers = {
        "pyright",
        "ts_ls",
        "jdtls",
        "gopls",
        "rust_analyzer",
      }

      for _, server in ipairs(servers) do
        lspconfig[server].setup({})
      end

      -- Configure diagnostics with signs using vim.diagnostic.config()
      vim.diagnostic.config({
        virtual_text = true,
        underline = true,
        update_in_insert = false,
        signs = {
          severity = { min = vim.diagnostic.severity.HINT },
          -- You can customize signs like this:
          -- icons replaced with popular devicons style:
          signs = {
            Error = { text = "", texthl = "DiagnosticSignError" },
            Warn  = { text = "", texthl = "DiagnosticSignWarn" },
            Hint  = { text = "", texthl = "DiagnosticSignHint" },
            Info  = { text = "", texthl = "DiagnosticSignInfo" },
          }
        },
      })
    end,
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup {
        icons = {
          -- add your icons here if needed
        },
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        presets = {
          bottom_search = true,
          command_palette = {
            views = {
              cmdline_popup = {
                position = { row = "50%", col = "50%" },
                size = { min_width = 60, width = "auto", height = "auto" },
              },
              popupmenu = {
                relative = "editor",
                position = { row = 23, col = "50%" },
                size = { width = 60, height = "auto", max_height = 15 },
                border = { style = "rounded", padding = { 0, 1 } },
                win_options = {
                  winhighlight = {
                    Normal = "Normal",
                    FloatBorder = "NoiceCmdlinePopupBorder",
                  },
                },
              },
            },
          },
          long_message_to_split = true,
          inc_rename = false,
          lsp_doc_border = false,
        },
      }
    end,
  },
}

return plugins
