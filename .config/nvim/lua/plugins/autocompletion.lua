return {
  { -- Autocompletion
    "hrsh7th/nvim-cmp",
    -- event = { "BufReadPre", "BufNewFile", "CmdlineEnter" },
    event = { "InsertEnter", "CmdlineEnter" },
    lazy = true,
    -- event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/jsregexp",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load() -- THIS LINE WAS MISSING
      local cmp = require("cmp") -- See `:help cmp`
      local luasnip = require("luasnip")
      luasnip.config.setup({})

      vim.keymap.set({ "i", "s" }, "<C-l>", function()
        if luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        end
      end, { silent = true })

      vim.keymap.set({ "i", "s" }, "<C-j>", function()
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        end
      end, { silent = true })

      -- local kind_icons = {
      --     Text = "󰉿",
      --     Method = "m",
      --     Function = "󰊕",
      --     Constructor = "",
      --     Field = "",
      --     Variable = "󰆧",
      --     Class = "󰌗",
      --     Interface = "",
      --     Module = "",
      --     Property = "",
      --     Unit = "",
      --     Value = "󰎠",
      --     Enum = "",
      --     Keyword = "󰌋",
      --     Snippet = "",
      --     Color = "󰏘",
      --     File = "󰈙",
      --     Reference = "",
      --     Folder = "󰉋",
      --     EnumMember = "",
      --     Constant = "󰇽",
      --     Struct = "",
      --     Event = "",
      --     Operator = "󰆕",
      --     TypeParameter = "󰊄",
      -- }
      cmp.setup({
        window = {
          completion = cmp.config.window.bordered(), -- ← rounded by default
          -- documentation = cmp.config.window.bordered(), -- ← rounded by default
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        preselect = cmp.PreselectMode.None,
        completion = { completeopt = "menu,menuone,noinsert,noselect" },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert({
          -- Select the [n]ext item
          ["<C-n>"] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          ["<C-p>"] = cmp.mapping.select_prev_item(),

          -- Scroll the documentation window [b]ack / [f]orward
          -- ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          --['<C-f>'] = cmp.mapping.scroll_docs(4),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),

          -- If you prefer more traditional completion keymaps,
          -- you can uncomment the following lines
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          -- ["<Tab>"] = cmp.mapping.select_next_item(),
          -- ["<S-Tab>"] = cmp.mapping.select_prev_item(),

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ["<C-Space>"] = cmp.mapping.complete({}),
          -- free ctrl + n
          -- ["<C-n>"] = cmp.config.disable,

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          ["<C-l>"] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { "i", "s" }),
          ["<C-j>"] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { "i", "s" }),

          -- Make 'p' write 'p' instead of pasting in select mode
          -- vim.keymap.set("s", "p", "<Nop>", { noremap = true, silent = true }),
          vim.keymap.set("s", "p", "p", { noremap = true, silent = true }),

          -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
          --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
          -- Select next/previous item with Tab / Shift + Tab
          --['<Tab>'] = cmp.mapping(function(fallback)
          --if cmp.visible() then
          --cmp.select_next_item()
          --elseif luasnip.expand_or_locally_jumpable() then
          --luasnip.expand_or_jump()
          --else
          --fallback()
          --end
          --end, { 'i', 's' }),
          --['<S-Tab>'] = cmp.mapping(function(fallback)
          --if cmp.visible() then
          --cmp.select_prev_item()
          --elseif luasnip.locally_jumpable(-1) then
          --luasnip.jump(-1)
          --else
          --fallback()
          --end
          --end, { 'i', 's' }),
        }),

        sources = {
          {
            name = "lazydev",
            -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
            group_index = 0,
          },
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            -- vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              luasnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
            })[entry.source.name]
            return vim_item
          end,
        },
      })
      -- `:` cmdline setup.
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          {
            name = "cmdline",
            option = {
              ignore_cmds = { "Man", "!" },
            },
          },
        }),
      })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "sql", "mysql", "plsql" },
        callback = function()
          cmp.setup.buffer({
            sources = cmp.config.sources({
              { name = "vim-dadbod-completion" },
              { name = "luasnip" },
              { name = "nvim_lsp" },
              { name = "buffer" },
            }),
          })
        end,
      })
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    build = (function()
      if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
        return
      end
      return "make install_jsregexp"
    end)(),
  },

  {
    "rafamadriz/friendly-snippets",
    lazy = true,
  },
}
