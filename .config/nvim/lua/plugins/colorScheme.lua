return {

  { "olimorris/onedarkpro.nvim" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onedark",
      highlights = {
        Comment = { italic = false, underline = false },
        Directory = { bold = false },
        ErrorMsg = { italic = false, bold = false },
      },
    },
  },
}

-- return {
--
--   { "romgrk/doom-one.vim" },
--   {
--     "LazyVim/LazyVim",
--     opts = {
--       colorscheme = "doom-one",
--     },
--   },
-- }

-- return {
--   "navarasu/onedark.nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     require("onedark").setup({
--       style = "cool",
--     })
--     require("onedark").load()
--   end,
-- }
