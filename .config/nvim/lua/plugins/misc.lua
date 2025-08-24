return {
    {
        -- Hints keybinds
        "folke/which-key.nvim",
        -- event = { "BufReadPre", "BufNewFile" },
    },
    -- {
    --     -- Autoclose parentheses, brackets, quotes, etc.
    --     "windwp/nvim-autopairs",
    --     event = "InsertEnter",
    --     config = true,
    --     opts = {},
    -- },
    -- {
    --
    --     "windwp/nvim-autopairs",
    --     event = "InsertEnter",
    --     config = function()
    --         local npairs = require("nvim-autopairs")
    --
    --         npairs.setup({
    --             disable_filetype = { "TelescopePrompt", "vim" },
    --             enable_check_bracket_line = false,
    --             ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
    --         })
    --
    --         -- Remove all default rules
    --         npairs.clear_rules()
    --
    --         -- Add only rules for '(' and '{'
    --         local Rule = require("nvim-autopairs.rule")
    --         npairs.add_rules({
    --             -- Rule("(", ")"),
    --             Rule("{", "}"),
    --         })
    --     end,
    -- },
    {
        -- Highlight todo, notes, etc in comments
        "folke/todo-comments.nvim",
        event = { "BufReadPre", "BufNewFile" },
        -- event = "VimEnter",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = { signs = false },
    },
    {
        -- High-performance color highlighter
        "norcalli/nvim-colorizer.lua",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("colorizer").setup()
        end,
    },
    -- {
    --   "mg979/vim-visual-multi",
    --   branch = "master",
    --   init = function()
    --     vim.g.VM_maps = {
    --       ["Find Under"] = "<C-d>", -- Select next occurrence
    --       ["Find Subword Under"] = "<C-d>",
    --     }
    --   end,
    -- },
}
