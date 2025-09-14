return {
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter", -- load when entering Insert mode
    config = function()
      require("nvim-ts-autotag").setup({
        -- Optional configuration:
        -- you can disable the plugin for specific filetypes by using:
        -- filetypes = { "xml", "jsx", "tsx", "html", "vue" },
      })
    end,
  },
}
