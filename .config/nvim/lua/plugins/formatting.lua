return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")
        conform.setup({
            formatters = {
                -- ktlint = {
                --     command = "ktlint",
                --     args = { "--format", "$FILENAME" },
                --     stdin = false, -- ktlint typically works with files, not stdin
                -- },
                ["markdown-toc"] = {
                    condition = function(_, ctx)
                        for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
                            if line:find("<!%-%- toc %-%->") then
                                return true
                            end
                        end
                    end,
                },
                ["markdownlint-cli2"] = {
                    condition = function(_, ctx)
                        local diag = vim.tbl_filter(function(d)
                            return d.source == "markdownlint"
                        end, vim.diagnostic.get(ctx.buf))
                        return #diag > 0
                    end,
                },
            },
            formatters_by_ft = {
                -- go = { "gopls", "golines", "goimports" },
                go = { "goimports", "gofmt" },
                -- c = { "clang_format" },
                cpp = { "clang_format" },
                sh = { "shfmt" },
                java = { "astyle" },
                kt = { "ktlint" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
                css = { "prettier" },
                html = { "prettier" },

                svelte = { "prettier" },
                json = { "prettier" },
                yaml = { "prettier" },
                graphql = { "prettier" },
                liquid = { "prettier" },
                lua = { "stylua" },
                python = { "black" },
                markdown = { "prettier", "markdown-toc" },
                -- ["markdown.mdx"] = { "prettier", "markdownlint", "markdown-toc" },
            },
            format_on_save = {
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
            },
        })

        -- Configure individual formatters
        -- conform.formatters.prettier = {
        --     args = {
        --         "--stdin-filepath",
        --         "$FILENAME",
        --         "--tab-width",
        --         "4",
        --         "--use-tabs",
        --         "false",
        --     },
        -- }
        conform.formatters.prettier = {
            args = function(_, ctx)
                local filename = ctx.filename
                local parser = nil

                if filename:match("%.rasi$") then
                    parser = "css"
                    -- Pretend file is CSS so Prettier doesn't complain
                    filename = filename:gsub("%.rasi$", ".css")
                end

                return vim.tbl_filter(function(x)
                    return x ~= nil
                end, {
                    "--stdin-filepath",
                    filename,
                    "--tab-width",
                    "4",
                    "--use-tabs",
                    "false",
                    parser and ("--parser=" .. parser) or nil,
                })
            end,
        }
        conform.formatters.shfmt = {
            prepend_args = { "-i", "4" },
        }

        vim.keymap.set({ "n", "v" }, "<leader>nf", function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
            })
        end, { desc = "Format whole file or range (in visual mode) with" })
    end,
}
