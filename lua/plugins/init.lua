
local plugins = {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment if you want format-on-save
    opts = require("configs.conform"),
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
          "ts_ls",       -- updated from 'tsserver'
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
    config = function()
      require("configs.lspconfig")
    end,
  },

  -- Plugin imports
  { import = "plugins.noice" },
  { import = "plugins.lazygit" },
}

-- Key mappings
vim.api.nvim_set_keymap("n", "<leader>cf", ":lua vim.lsp.buf.code_action()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>gg", ":LazyGit<CR>", { noremap = true, silent = true })

return plugins
