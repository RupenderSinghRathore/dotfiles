return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local function short_mode()
            local mode_map = {
                n = "NOR",
                i = "INS",
                v = "VIS",
                V = "VIS-L",
                [""] = "VIS-B", -- Visual block mode (CTRL+V)
                R = "R",
                c = "CMD",
            }
            local mode = vim.api.nvim_get_mode().mode
            return mode_map[mode] or mode:upper()
        end

        require("lualine").setup({
            options = {
                icons_enabled = true,
                theme = "auto",
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
                -- component_separators = { left = "", right = "" },
                -- section_separators = { left = "", right = "" },

                -- section_separators = { left = "", right = "" },
                -- component_separators = { left = "", right = "" },

                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                always_show_tabline = true,
                globalstatus = false,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                    refresh_time = 16, -- ~60fps
                    events = {
                        "WinEnter",
                        "BufEnter",
                        "BufWritePost",
                        "SessionLoadPost",
                        "FileChangedShellPost",
                        "VimResized",
                        "Filetype",
                        "CursorMoved",
                        "CursorMovedI",
                        "ModeChanged",
                    },
                },
            },
            sections = {
                -- lualine_a = { "mode" },
                lualine_a = { short_mode },
                -- lualine_b = { "branch", "diff", "diagnostics" },
                lualine_b = {},
                lualine_c = {
                    {
                        "diagnostics",

                        -- Table of diagnostic sources, available sources are:
                        --   'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
                        -- or a function that returns a table as such:
                        --   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
                        sources = { "nvim_diagnostic", "coc" },

                        -- Displays diagnostics for the defined severity types
                        sections = { "error", "warn", "info", "hint" },

                        diagnostics_color = {
                            -- Same values as the general color option can be used here.
                            error = "DiagnosticError", -- Changes diagnostics' error color.
                            warn = "DiagnosticWarn", -- Changes diagnostics' warn color.
                            info = "DiagnosticInfo", -- Changes diagnostics' info color.
                            hint = "DiagnosticHint", -- Changes diagnostics' hint color.
                        },
                        -- symbols = { error = "E", warn = "W", info = "I", hint = "H" },
                        symbols = { error = "•", warn = "•", info = "•", hint = "•" },
                        colored = true, -- Displays diagnostics status in color if set to true.
                        update_in_insert = false, -- Update diagnostics in insert mode.
                        always_visible = false, -- Show diagnostics even if there are none.
                    },
                },
                -- lualine_c = { "filename" },
                -- lualine_x = { "encoding", "fileformat", "filetype" },
                lualine_x = { "location" },
                -- lualine_y = { "progress" },
                lualine_y = {},
                lualine_z = {
                    {
                        "filename",
                        path = 0, -- Just the file name
                        symbols = {
                            modified = "", -- Remove [+]
                            readonly = "", -- Remove lock symbol
                            unnamed = "Buff",
                            newfile = "",
                        },
                        fmt = function(str)
                            -- remove trailing whitespace caused by symbols
                            return vim.trim(str)
                        end,
                    },
                },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "filename" },
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {},
        })
    end,
}
