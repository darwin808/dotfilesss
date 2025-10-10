return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
      },
      formatters = {
        prettier = {
          prepend_args = function()
            -- Don't pass any args, let Prettier find its own config
            return {}
          end,
        },
      },
    },
  },
}
