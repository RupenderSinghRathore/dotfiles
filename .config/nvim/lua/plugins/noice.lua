return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    -- {
    --   filter = {
    --     event = "msg_show",
    --     any = {
    --       { find = "%d+L, %d+B" }, -- Catches the standard Neovim save output
    --     },
    --   },
    --   view = "notify", -- Forces it to be a bubble instead of hiding in the corner
    -- },
    routes = {
      {
        filter = {
          event = "msg_show",
          any = {
            { find = "yanked" },
            { find = "written" }, -- sometimes appears on write
            { find = "%d+ lines yanked" },
            -- { find = "%d+L, %d+B" }, -- save message
            { find = "%d+ lines pasted" },
            { find = "%d+ more lines" }, -- THIS is the one you need
            { find = "%d+ fewer lines" }, -- THIS is the one you need

            { find = "Query '.-' finished" },
            { find = "%[DBUI%]" },
          },
        },
        opts = { skip = true },
      },
      --   {
      --     view = "popup",
      --     filter = {
      --       event = "msg_show",
      --       any = {
      --         { find = "^:!" }, -- Catches standard external commands
      --         { find = "^!!" }, -- Catches line-filtered external commands
      --       },
      --     },
      --   },
    },
    lsp = {
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
      },
    },
    -- you can enable a preset for easier configuration
    presets = {
      bottom_search = false, -- use a classic bottom cmdline for search
      command_palette = false, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = true, -- add a border to hover docs and signature help
    },
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify",
  },
}
