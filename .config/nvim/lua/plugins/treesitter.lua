-- return { -- Highlight, edit, and navigate code
--   "nvim-treesitter/nvim-treesitter",
--   commit = "90cd658",
--   event = { "BufReadPre", "BufNewFile" },
--   build = ":TSUpdate",
--   main = "nvim-treesitter.configs", -- Sets main module to use for opts
--   -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
--   opts = {
--     ensure_installed = {
--       "lua",
--       "markdown",
--       -- "markdown_inline",
--       "python",
--       "javascript",
--       "typescript",
--       -- "vimdoc",
--       "vim",
--       -- "regex",
--       -- "terraform",
--       "sql",
--       "dockerfile",
--       "toml",
--       "json",
--       "java",
--       "groovy",
--       "go",
--       "gitignore",
--       "graphql",
--       "yaml",
--       "make",
--       "cmake",
--       "markdown",
--       "markdown_inline",
--       "bash",
--       "tsx",
--       "css",
--       "html",
--       "c",
--       "cpp",
--       "rust",
--     },
--     -- Autoinstall languages that are not installed
--     -- auto_install = true,
--     highlight = {
--       enable = true,
--       -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
--       --  If you are experiencing weird indenting issues, add the language to
--       --  the list of additional_vim_regex_highlighting and disabled languages for indent.
--       -- disable = { "bash" }, -- Disable Treesitter highlighting for Bash
--       -- additional_vim_regex_highlighting = { "ruby" },
--     },
--     -- indent = { enable = true, disable = { "ruby" } },
--     indent = { enable = true },
--   },
--   -- There are additional nvim-treesitter modules that you can use to interact
--   -- with nvim-treesitter. You should go explore a few and see what interests you:
--   --
--   --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
--   --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
--   --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
-- }
-- return {
--   "nvim-treesitter/nvim-treesitter",
--   commit = "90cd658",
--   main = "nvim-treesitter",
--   -- build = ":TSUpdate",
--   event = { "BufReadPost", "BufNewFile" },
--   init = function()
--     local highlight = function(bufnr, lang)
--       -------------------[ treesitter highlights ]-------------------------------
--       if not vim.treesitter.language.add(lang) then
--         return vim.notify(
--           string.format("Treesitter cannot load parser for language: %s", lang),
--           vim.log.levels.INFO,
--           { title = "Treesitter" }
--         )
--       end
--       vim.treesitter.start(bufnr)
--     end
--
--     vim.api.nvim_create_autocmd("FileType", {
--       callback = function(args)
--         local ft = vim.bo.filetype
--         local bt = vim.bo.buftype
--         local buf = args.buf
--
--         if bt ~= "" then
--           return
--         end -- don't run further.
--
--         local ok, treesitter = pcall(require, "nvim-treesitter")
--         if not ok then
--           return
--         end
--
--         --------------------[ treesitter folds ]-------------------------------
--
--         if ft == "javascriptreact" or ft == "typescriptreact" then
--           vim.opt_local.foldmethod = "indent"
--         else
--           vim.opt_local.foldmethod = "expr"
--           vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
--         end
--
--         vim.schedule(function()
--           -- Only run normal if we're not in terminal mode
--           if vim.fn.mode() ~= "t" then
--             vim.cmd("silent! normal! zx")
--           end
--         end)
--
--         ---------------------[ treesitter indent ]-------------------------------
--
--         if not vim.tbl_contains({ "python", "html", "yaml", "markdown" }, ft) then
--           vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
--         end
--
--         --------------------[ treesitter parsers ]-------------------------------
--         if vim.fn.executable("tree-sitter") ~= 1 then
--           vim.api.nvim_echo({
--             {
--               "tree-sitter CLI not found. Parsers cannot be installed.",
--               "ErrorMsg",
--             },
--           }, true, {})
--           return false
--         end
--
--         if not vim.treesitter.language.get_lang(ft) then
--           return
--         end
--
--         if vim.list_contains(treesitter.get_installed(), ft) then
--           highlight(buf, ft)
--         elseif vim.list_contains(treesitter.get_available(), ft) then
--           treesitter.install(ft):await(function()
--             highlight(buf, ft)
--           end)
--         end
--       end,
--     })
--   end,
--   opts = {
--     install = {
--       "css",
--       "comment",
--       "markdown",
--       "markdown_inline",
--       "regex",
--       "lua",
--       "vimdoc",
--       "python",
--       "javascript",
--       --       "typescript",
--       --       -- "vimdoc",
--       --       "vim",
--       --       -- "regex",
--       --       -- "terraform",
--       "sql",
--       --       "dockerfile",
--       --       "toml",
--       --       "json",
--       --       "java",
--       --       "groovy",
--       "go",
--       --       "gitignore",
--       --       "graphql",
--       --       "yaml",
--       "make",
--       --       "cmake",
--       "bash",
--       --       "tsx",
--       "html",
--       "c",
--       -- "cpp",
--       "rust",
--     },
--   },
--   config = function(_, opts)
--     local treesitter = require("nvim-treesitter")
--     treesitter.setup(opts)
--     if vim.fn.executable("tree-sitter") ~= 1 then
--       vim.api.nvim_echo({
--         {
--           "tree-sitter CLI not found. Parsers cannot be installed.",
--           "ErrorMsg",
--         },
--       }, true, {})
--       return false
--     end
--     treesitter.install(opts.install)
--   end,
-- }
-- return {
--   {
--     "nvim-treesitter/nvim-treesitter",
--     build = ":TSUpdate",
--   },
--   {
--     "romus204/tree-sitter-manager.nvim",
--     dependencies = {}, -- tree-sitter CLI must be installed system-wide
--     config = function()
--       require("tree-sitter-manager").setup({
--         -- Default Options
--         -- ensure_installed = {}, -- list of parsers to install at the start of a neovim session
--         ensure_installed = {
--           "lua",
--           "markdown",
--           "markdown_inline",
--           "python",
--           "javascript",
--           "typescript",
--           "vimdoc",
--           "vim",
--           "regex",
--           -- "terraform",
--           "sql",
--           "dockerfile",
--           "toml",
--           "json",
--           "java",
--           "groovy",
--           "go",
--           "gitignore",
--           "graphql",
--           "yaml",
--           "make",
--           "cmake",
--           "markdown",
--           "markdown_inline",
--           "bash",
--           "tsx",
--           "css",
--           "html",
--           "c",
--           "cpp",
--           "rust",
--         },
--
--         -- border = nil, -- border style for the window (e.g. "rounded", "single"), if nil, use the default border style defined by 'vim.o.winborder'. See :h 'winborder' for more info.
--         -- auto_install = false, -- if enabled, install missing parsers when editing a new file
--         -- highlight = true, -- treesitter highlighting is enabled by default
--         -- languages = {}, -- override or add new parser sources
--         -- parser_dir = vim.fn.stdpath("data") .. "/site/parser",
--         -- query_dir = vim.fn.stdpath("data") .. "/site/queries",
--       })
--     end,
--   },
-- }
return {
    -- NOTE: treesitter CLI installation needed
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            local treesitter = require("nvim-treesitter")

            -- ensure these languages parsers are installed
            local ensure_installed = {
                "json", "javascript", "typescript", "tsx", "go", "yaml", "html", "css", "python",
                "http", "prisma", "markdown", "markdown_inline", "svelte", "graphql", "bash", "lua", "vim", "dockerfile",
                "gitignore", "query", "vimdoc", "c", "java", "rust", "ron",
            }

            treesitter.install(ensure_installed)

            -- Safe FileType autocmd for highlighting + indentation
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "*",
                callback = function(args)
                    local buf = args.buf
                    local ft = vim.bo[buf].filetype
                    local lang = vim.treesitter.language.get_lang(ft)

                    if not lang then
                        return
                    end

                    -- load parser and start treesitter safely
                    pcall(vim.treesitter.language.add, lang)
                    pcall(vim.treesitter.start, buf, lang)

                    -- enable indentation (skip yaml/markdown)
                    if ft ~= "yaml" and ft ~= "markdown" then
                        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                        vim.bo[buf].smartindent = false
                        vim.bo[buf].cindent = false
                    end
                end,
            })

        end,
    },
    -- NOTE: js,ts,jsx,tsx Auto Close Tags
    {
        "windwp/nvim-ts-autotag",
        enabled = true,
        ft = { "html", "xml", "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte" },
        config = function()
            -- Independent nvim-ts-autotag setup
            require("nvim-ts-autotag").setup({
                opts = {
                    enable_close = true,           -- Auto-close tags
                    enable_rename = true,          -- Auto-rename pairs
                    enable_close_on_slash = false, -- Disable auto-close on trailing `</`
                },
                per_filetype = {
                    ["html"] = {
                        enable_close = true,
                    },
                    ["typescriptreact"] = {
                        enable_close = true,
                    },
                },
            })
        end,
    },
}
