-- lua/plugins/dev.lua OR your main plugins file
return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- Only load on Lua files
    opts = {
      library = {
        -- See "Usage" at https://github.com/folke/lazydev.nvim/blob/main/README.md for more options
        -- You can add paths to custom libraries here if needed
      },
    },
  },
  -- Potentially, your nvim-lspconfig and lua-language-server (configured via mason.nvim)
  -- {
  --   "neovim/nvim-lspconfig",
  --   dependencies = {
  --     "williamboman/mason.nvim", -- To manage LSP server installations
  --     "williamboman/mason-lspconfig.nvim", -- To bridge mason and lspconfig
  --     -- Other LSP-related plugins like nvim-cmp, etc.
  --   },
  --   -- Your nvim-lspconfig setup function will be called from here or your main lsp config file
  --   config = function()
  --     -- Place your LSP setup logic here or call a function that does.
  --     -- Ensure lazydev is setup implicitly by being loaded, or explicitly if needed before lua_ls.
  --     require("core.lsp").setup() -- Example: if your LSP setup is in lua/core/lsp.lua
  --   end,
  -- },
}
