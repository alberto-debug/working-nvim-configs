
--lspconfig
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")

      -- List of servers to setup
      local servers = {
        "pyright",
        "ts_ls",       -- updated from 'tsserver'
        "jdtls",
        "gopls",
        "rust_analyzer",
      }

      for _, server in ipairs(servers) do
        lspconfig[server].setup({})
      end

      -- Configure diagnostics (virtual text, underline, signs)
      vim.diagnostic.config({
        virtual_text = true,
        underline = true,
        update_in_insert = false,
        signs = {
          { name = "DiagnosticSignError", text = "" },
          { name = "DiagnosticSignWarn",  text = "" },
          { name = "DiagnosticSignInfo",  text = "" },
          { name = "DiagnosticSignHint",  text = "" },
        },
      })
    end,
  },
}

