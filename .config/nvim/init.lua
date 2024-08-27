-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

if vim.g.neovide then
  -- Put anything you want to happen only in Neovide here
  vim.opt["guicursor"] = ""
  vim.g.neovide_cursor_animation_length = 0
  vim.o.guifont = "jetBrainsMono Nerd Font:h20"
end
