return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- optional icons
        "MunifTanjim/nui.nvim",
    },
    config = function()
        require("neo-tree").setup({
            close_if_last_window = true,
            enable_git_status = false, -- you said you don’t use git features
            enable_diagnostics = false, -- no need if you just want create/delete
            window = {
                position = "current",
                mappings = {
                    ["a"] = "add", -- create file/directory
                    ["l"] = "open",
                    ["A"] = "add_directory",
                    ["d"] = "delete", -- delete file/directory
                    ["r"] = "rename", -- (optional) rename
                    ["q"] = "close_window", -- quit Neo-tree
                    ["/"] = "fuzzy_finder_directory",
                },
            },
            filesystem = {
                filtered_items = {
                    hide_dotfiles = false,
                    hide_gitignored = false,
                },
                follow_current_file = { enabled = true },
            },
        })

        -- simple keymaps
        -- vim.keymap.set("n", "<leader>nv", ":Neotree toggle<CR>", { noremap = true, silent = true })
        vim.keymap.set("n", "\\", ":Neotree reveal<CR>", { noremap = true, silent = true })
    end,
}
