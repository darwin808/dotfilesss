return {
  {
    "folke/snacks.nvim",
    opts = {
      indent = { enabled = false },
      explorer = {},
      picker = {
        sources = {
          -- explorer = {
          --   layout = { layout = { position = "right" } },
          -- },
          explorer = {
            layout = {
              layout = {
                box = "vertical",
                position = "right",
                width = 0.2,
                {
                  win = "input",
                  max_height = 1,
                  height = 1,
                  border = { "", "", "", "", "", "", "", " " },
                  wo = {
                    winhighlight = "FloatBorder:Normal,NormalFloat:Normal,SnacksPickerPrompt:SnacksPickerPromptTransparent",
                  },
                },
                {
                  win = "list",
                  border = "none",
                  wo = {
                    winhighlight = "FloatBorder:Normal,NormalFloat:Normal",
                  },
                },
              },
            },
          },
        },
      },
    },
  },
}
