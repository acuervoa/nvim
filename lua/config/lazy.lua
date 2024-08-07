-- Define the path to lazy.nvim based on the standard data directory
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- Check if the lazy.nvim directory exists
if not vim.loop.fs_stat(lazypath) then
  -- Clone the lazy.nvim repository from GitHub if it doesn't exist
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end

-- Prepend the lazy.nvim path to the runtime path
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim with configuration
require("lazy").setup {
  spec = {
    { import = "plugins" }, -- Import plugins from the plugins module
  },
  default = {
    lazy = true, -- Set default loading behavior to lazy
  },
  checker = { enabled = true, notify = false }, -- Enable plugin update checker without notifications
  ui = {
    border = "rounded", -- Use rounded borders for the UI
  },
  performance = {
    rtp = {
      disabled_plugins = { -- Disable certain built-in plugins for performance
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
}

