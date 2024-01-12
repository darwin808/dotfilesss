-- return {
--   { "rose-pine/neovim" },
--   {
--     "LazyVim/LazyVim",
--     opts = {
--       colorscheme = "rose-pine",
--       bold = false,
--       italics = false,
--     },
--   },
-- }

-- return {
--   { "blazkowolf/gruber-darker.nvim" },
--
--   {
--     "LazyVim/LazyVim",
--     opts = {
--       colorscheme = "gruber-darker",
--       bold = false,
--       italic = {
--         strings = false,
--       },
--     },
--   },
-- }

-- return {
--
--   { "olimorris/onedarkpro.nvim" },
--   {
--     "LazyVim/LazyVim",
--     opts = {
--       colorscheme = "onedark",
--       colors = {
--         cursorline = "#FF0000", -- This is optional. The default cursorline color is based on the background
--       },
--       options = {
--         cursorline = true,
--         transparency = true,
--       },
--       highlights = {
--
--         Comment = { italic = false, underline = false },
--         Directory = { bold = false },
--         ErrorMsg = { italic = false, bold = false },
--       },
--     },
--   },
-- }
--
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

return {

  { "darwin808/doom-one-v1" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "doom-one",
    },
  },
}

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
