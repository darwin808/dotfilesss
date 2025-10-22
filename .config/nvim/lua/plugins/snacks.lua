return {
  {
    "folke/snacks.nvim",
    opts = {
      indent = { enabled = false },
      dashboard = {
        width = 60,
        row = nil, -- dashboard position. nil for center
        col = nil, -- dashboard position. nil for center
        pane_gap = 4, -- empty columns between vertical panes
        autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", -- autokey sequence
        -- These settings are used by some built-in sections
        preset = {
          -- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
          ---@type fun(cmd:string, opts:table)|nil
          pick = nil,
          -- Used by the `keys` section to show keymaps.
          -- Set your custom keymaps here.
          -- When using a function, the `items` argument are the default keymaps.
          ---@type snacks.dashboard.Item[]
          keys = {},
          -- Used by the `header` section
          header = [[
                                                                           
     ██████╗  █████╗ ██████╗ ██╗    ██╗██╗███╗   ██╗                        
     ██╔══██╗██╔══██╗██╔══██╗██║    ██║██║████╗  ██║                        
     ██║  ██║███████║██████╔╝██║ █╗ ██║██║██╔██╗ ██║                        
     ██║  ██║██╔══██║██╔══██╗██║███╗██║██║██║╚██╗██║                        
     ██████╔╝██║  ██║██║  ██║╚███╔███╔╝██║██║ ╚████║                        
     ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝ ╚══╝╚══╝ ╚═╝╚═╝  ╚═══╝                        
                                                                             
     ██████╗  █████╗ ██████╗ ██╗    ██╗██╗███╗   ██╗                        
     ██╔══██╗██╔══██╗██╔══██╗██║    ██║██║████╗  ██║                        
     ██║  ██║███████║██████╔╝██║ █╗ ██║██║██╔██╗ ██║                        
     ██║  ██║██╔══██║██╔══██╗██║███╗██║██║██║╚██╗██║                        
     ██████╔╝██║  ██║██║  ██║╚███╔███╔╝██║██║ ╚████║                        
     ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝ ╚══╝╚══╝ ╚═╝╚═╝  ╚═══╝                        
                                                                             
     ██████╗  █████╗ ██████╗ ██╗    ██╗██╗███╗   ██╗                        
     ██╔══██╗██╔══██╗██╔══██╗██║    ██║██║████╗  ██║                        
     ██║  ██║███████║██████╔╝██║ █╗ ██║██║██╔██╗ ██║                        
     ██║  ██║██╔══██║██╔══██╗██║███╗██║██║██║╚██╗██║                        
     ██████╔╝██║  ██║██║  ██║╚███╔███╔╝██║██║ ╚████║                        
     ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝ ╚══╝╚══╝ ╚═╝╚═╝  ╚═══╝                        

]],
        },
        -- item field formatters
        formats = {
          icon = function(item)
            if item.file and item.icon == "file" or item.icon == "directory" then
              return M.icon(item.file, item.icon)
            end
            return { item.icon, width = 2, hl = "icon" }
          end,
          footer = { "%s", align = "center" },
          header = { "%s", align = "center" },
          file = function(item, ctx)
            local fname = vim.fn.fnamemodify(item.file, ":~")
            fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
            if #fname > ctx.width then
              local dir = vim.fn.fnamemodify(fname, ":h")
              local file = vim.fn.fnamemodify(fname, ":t")
              if dir and file then
                file = file:sub(-(ctx.width - #dir - 2))
                fname = dir .. "/…" .. file
              end
            end
            local dir, file = fname:match("^(.*)/(.+)$")
            return dir and { { dir .. "/", hl = "dir" }, { file, hl = "file" } } or { { fname, hl = "file" } }
          end,
        },
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          -- { section = "startup" },
        },
      },
      explorer = {},
      picker = {
        icons = {
          -- remove tree icons
          tree = {
            vertical = " ",
            middle = "  ",
            last = "  ",
          },
        },
        sources = {
          explorer = {
            hidden = true,
            ignored = true,
            layout = {
              layout = {
                box = "vertical",
                position = "right",
                width = 0.3,
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
