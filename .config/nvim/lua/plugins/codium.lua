return {
    {
        "Exafunction/codeium.nvim",
        cmd = "Ai",
        -- event = "InsertEnter", -- load LuaSnip when you start inserting text
        dependencies = {
            "nvim-lua/plenary.nvim",
            "hrsh7th/nvim-cmp",
        },
        config = function()
            require("codeium").setup({
                virtual_text = {
                    enabled = true, -- Enable virtual text for suggestions
                    key_bindings = {
                        accept = "<Tab>", -- Accept the current suggestion with Ctrl+Space
                        accept_word = "<C-f>", -- Accept the next word of the suggestion
                        accept_line = "<C-g>", -- Accept the next line of the suggestion
                        clear = "<C-x>", -- Clear the current virtual text suggestion
                        next = "<M-]>", -- Cycle to the next suggestion
                        prev = "<M-[>", -- Cycle to the previous suggestion
                    },
                },
            })

            -- vim.keymap.set("n", "<leader>c", "<cmd>Codeium Toggle<CR>", {noremap = true})

            vim.cmd("silent! Codeium Toggle") -- Toggles off by default
        end,
    },
}
