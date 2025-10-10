return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Go
        gopls = {
          settings = {
            gopls = {
              analyses = {
                unusedparams = true,
              },
              staticcheck = true,
            },
          },
        },
        -- Rust
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
              },
            },
          },
        },
        -- TypeScript
        tsserver = {},
      },
    },
  },
}
