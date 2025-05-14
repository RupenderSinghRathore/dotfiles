return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
    "jayp0521/mason-null-ls.nvim",
  },
  config = function()
    local null_ls = require("null-ls")
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics

    require("mason-null-ls").setup({
      ensure_installed = {
        -- JavaScript/TypeScript
        "prettier",
        "eslint_d",

        -- Python
        "ruff",
        "black",

        -- Lua
        "stylua",

        -- Shell
        "shfmt",

        -- C/C++
        "clang_format",

        -- Rust
        -- "rustfmt",

        -- Go
        "gofmt",
        "goimports",

        -- CSS/SCSS
        "prettier",
        -- "stylelint",

        -- Other
        "checkmake",
      },
      automatic_installation = true,
    })

    local sources = {

      require("none-ls.formatting.rustfmt"),
      -- Diagnostics
      diagnostics.checkmake,
      -- diagnostics.eslint_d,
      -- diagnostics.stylelint,

      -- Formatting
      formatting.prettier.with({
        filetypes = {
          "javascript",
          "typescript",
          "javascriptreact",
          "typescriptreact",
          "css",
          "scss",
          "html",
          "json",
          "yaml",
          "markdown",
        },
        extra_args = { "--tab-width", "2" },
      }),

      -- Python
      require("none-ls.formatting.ruff").with({ extra_args = { "--extend-select", "I" } }),
      require("none-ls.formatting.ruff_format"),
      formatting.black,

      -- C/C++
      formatting.clang_format,

      -- Rust
      -- formatting.rustfmt,

      -- Go
      formatting.gofmt,
      formatting.goimports,

      -- Other
      formatting.stylua,
      formatting.shfmt.with({ args = { "-i", "4" } }),
      formatting.terraform_fmt,
    }

    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    null_ls.setup({
      -- debug = true,
      sources = sources,
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ async = false })
            end,
          })
        end
      end,
    })
  end,
}
