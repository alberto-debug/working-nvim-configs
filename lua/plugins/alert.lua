
return {
  "rcarriga/nvim-notify",
  config = function()
    require("notify").setup({
      -- your notify config here if any
    })
    vim.notify = require("notify")
  end,
}
