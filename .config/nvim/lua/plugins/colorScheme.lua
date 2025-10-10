return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    opts = {
      transparent_mode = true,
      invert_selection = true,
      invert_signs = true,
      invert_tabline = true,
    },
    config = function(_, opts)
      require("gruvbox").setup(opts)
      vim.cmd([[colorscheme gruvbox]])
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
