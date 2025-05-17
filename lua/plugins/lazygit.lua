-- lua/plugins/lazygit.lua
return {
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      -- Keymap to open lazygit
      vim.api.nvim_set_keymap("n", "<leader>lg", ":LazyGit<CR>", { noremap = true, silent = true })

      -- Keymap to open lazygit in a floating window
      vim.api.nvim_set_keymap("n", "<leader>lG", ":LazyGitFloat<CR>", { noremap = true, silent = true })
    end,
  },
}
