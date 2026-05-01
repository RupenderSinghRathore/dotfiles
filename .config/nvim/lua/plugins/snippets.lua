return {
  {
    "L3MON4D3/LuaSnip",
    -- event = "InsertEnter", -- load LuaSnip when you start inserting text
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local ls = require("luasnip")
      -- some shorthands...
      local s = ls.snippet
      -- local sn = ls.snippet_node
      local t = ls.text_node
      local i = ls.insert_node
      local f = ls.function_node
      -- local c = ls.choice_node
      -- local d = ls.dynamic_node
      -- local r = ls.restore_node
      -- local l = require("luasnip.extras").lambda
      -- local rep = require("luasnip.extras").rep
      -- local p = require("luasnip.extras").partial
      -- local m = require("luasnip.extras").match
      -- local n = require("luasnip.extras").nonempty
      -- local dl = require("luasnip.extras").dynamic_lambda
      -- local fmt = require("luasnip.extras.fmt").fmt
      -- local fmta = require("luasnip.extras.fmt").fmta
      -- local types = require("luasnip.util.types")
      -- local conds = require("luasnip.extras.conditions")
      -- local conds_expand = require("luasnip.extras.conditions.expand")

      -- vim.keymap.del("i", "<c-k>", { buffer = true })
      pcall(vim.keymap.del, "i", "<C-K>", { buffer = true })
      -- Rust
      vim.api.nvim_create_autocmd("FileType", {

        pattern = "rust",
        callback = function()
          -- vim.lsp.enable("rust_analyzer", false)

          -- vim.diagnostic.config({
          --   severity_sort = true,
          --   update_in_insert = false,
          --   -- underline = true,
          -- })

          -- buid commands
          -- vim.keymap.set("n", "<leader>r", "<cmd>!cargo run<CR>", { buffer = true, desc = "cargo run" })
          vim.keymap.set(
            "n",
            "<leader><F1>",
            ":!rustc % -o run && ./run && rm run<CR>",
            { buffer = true, desc = "rustc" }
          )
          vim.keymap.set(
            "n",
            "<leader><F2>",
            "<cmd>split | term<CR>icargo run",
            { buffer = true, desc = "cargo run(term)" }
          )
          vim.keymap.set("n", "<leader><F3>", ":!cargo check<CR>", { buffer = true, desc = "cargo check" })

          -- snippets
          vim.keymap.set("i", "<c-k>ep", function()
            ls.snip_expand(s("log", {
              t("#[derive(Debug"),
              i(1, ""),
              t(")]"),
            }))
          end, { buffer = true, desc = "debug macro" })
          vim.keymap.set("i", "<c-k>p", function()
            ls.snip_expand(s("log", {
              t('println!("'),
              i(1, ""),
              t('"'),
              i(2, ""),
              t(");"),
            }))
          end, { buffer = true, desc = "Insert println snippet" })
        end,
      })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "go",
        callback = function()
          vim.keymap.set("i", "<c-k>p", function()
            ls.snip_expand(s("log", {
              t('fmt.Printf("'),
              i(1, ""),
              t('\\n"'),
              i(2, ""),
              t(")"),
            }))
          end, { buffer = true, desc = "Insert println snippet" })

          local dirname = vim.fn.expand("%:p:h")
          -- vim.keymap.set("n", "<leader>r", "<cmd>!go run " .. dirname .. "<CR>", { buffer = true })
          -- vim.keymap.set("n", "<leader>r", "<cmd>!go run %<CR>", { buffer = true })
          vim.keymap.set("n", "<leader><F1>", "<cmd>!go run .<CR>", { buffer = true })
          vim.keymap.set("n", "<leader><F2>", "<cmd>split | term<CR>igo run ", { buffer = true })

          -- vim.keymap.del("i", "<C-s>")
          vim.keymap.set("i", "<c-k>h", function()
            ls.snip_expand(s("Handler func", {
              t({ "func (app *application) " }),
              i(1),
              t({ "(w http.ResponseWriter, r *http.Request) {", "\t" }),
              i(2),
              t({ "", "}" }),
            }))
          end, { buffer = true, desc = "http handlerfunc signature" })

          vim.keymap.set("i", "<c-k>ee", function()
            ls.snip_expand(s("Errorhandling", {
              t({ "if err != nil {", "\t" }),
              i(1),
              t({ "", "}" }),
            }))
          end, { buffer = true, desc = "Insert Go error handling block" })

          vim.keymap.set("i", "<c-k>ei", function()
            local fmt = require("luasnip.extras.fmt").fmt

            local line = vim.api.nvim_get_current_line()
            local indent = line:match("^%s*") -- Capture leading tabs/spaces
            local code = vim.trim(line) -- Capture the code (e.g., "os.Open(f)")

            vim.api.nvim_set_current_line(indent)
            vim.api.nvim_win_set_cursor(0, { vim.fn.line("."), #indent })
            ls.snip_expand(ls.snippet(
              "",
              fmt(
                [[
            if err := {}; err != nil {{
                {}
            }}
        ]],
                {
                  ls.text_node(code), -- Wraps your captured code
                  ls.insert_node(0), -- Places cursor inside the block, correctly indented
                }
              )
            ))
          end, { buffer = true, desc = "Insert Go inline error handling block" })
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "c",
        callback = function()
          -- vim.opt_local.makeprg = "clang -fsanitize=address -g -Iinclude -Wall % -o run"
          -- vim.keymap.set(
          --   "n",
          --   "<leader>r",
          --   "<cmd>!clang -fsanitize=address -g -Iinclude -Wall % -o run && ./run<CR>",
          --   { buffer = true }
          -- )
          vim.keymap.set("n", "<leader><F1>", "<cmd>split | term<CR>imakec", { buffer = true })

          vim.keymap.set("i", "<c-k>p", function()
            ls.snip_expand(s("log", {
              t('printf("'),
              i(1, ""),
              t('\\n"'),
              i(2, ""),
              t(");"),
            }))
          end, { buffer = true, desc = "Insert println snippet" })
          vim.keymap.set(
            "i",
            "<c-k>e",
            'if (ok == -1) {<CR>}<Esc>Oprintf("error: %s\\n", strerror(errno));<CR>return -1;'
          )
        end,
      })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "html",
        callback = function()
          vim.keymap.set("n", "<leader>r", "<cmd>!xdg-open %<CR>", { buffer = true })

          -- vim.keymap.set("n", "<leader><F1>", "{{% block  %}}{{% endblock %}}<Esc>Fk;la")
        end,
      })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "htmldjango",
        callback = function()
          vim.keymap.set("i", "<c-k>e", "{{% block  %}}{{% endblock %}}<Esc>Fk;la")
        end,
      })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        callback = function()
          -- vim.keymap.set("n", "<leader>r", "<cmd>!javac % && java %:t:r<CR>", { buffer = true })

          local classname = vim.fn.expand("%:t:r")
          local filename = classname .. ".java"
          vim.keymap.set(
            "n",
            "<leader><F1>",
            "<cmd>split | term<CR>ijavac " .. filename .. " && java " .. classname,
            { buffer = true }
          )
          vim.keymap.set("i", "<c-k>p", function()
            ls.snip_expand(s("log", {
              t('System.out.printf("'),
              i(1, ""),
              t('\\n"'),
              i(2, ""),
              t(");"),
            }))
          end, { buffer = true, desc = "Insert println snippet" })
        end,
      })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "javascript",
        callback = function()
          -- vim.keymap.set("n", "<leader>r", "<cmd>!node %<CR>", { buffer = true })

          vim.keymap.set("i", "<c-k>p", function()
            ls.snip_expand(s("log", {
              t("console.log(`"),
              i(1, ""),
              t("`);"),
            }))
          end, { buffer = true, desc = "Insert logging snippet" })
        end,
      })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          vim.keymap.set("n", "<leader>r", "<cmd>LivePreview start<CR>", { buffer = true })
          -- vim.keymap.set("n", "<leader>r", "<cmd>!zen %<CR>", { buffer = true })

          vim.keymap.set("i", "*", "**<Esc>i", { buffer = true })

          -- Markdown formatting keymaps
          vim.keymap.set(
            "n",
            "<leader>km",
            '"zyiwciw$<C-r>z$<ESC>',
            { noremap = true, silent = true, desc = "Wrap word in $$" }
          )
          vim.keymap.set(
            "n",
            "<leader>ki",
            '"zyiwciw*<C-r>z*<ESC>',
            { noremap = true, silent = true, desc = "Wrap word in *italic*" }
          )
          vim.keymap.set(
            "n",
            "<leader>kb",
            '"zyiwciw**<C-r>z**<ESC>',
            { noremap = true, silent = true, desc = "Wrap word in **bold**" }
          )
          vim.keymap.set(
            "n",
            "<leader>kc",
            '"zyiwciw`<C-r>z`<ESC>',
            { noremap = true, silent = true, desc = "Wrap word in `code`" }
          )

          vim.keymap.set(
            "v",
            "<leader>km",
            '"zygvc$<C-r>z$<ESC>',
            { noremap = true, silent = true, desc = "Wrap selection in $$" }
          )
          vim.keymap.set(
            "v",
            "<leader>ki",
            '"zygvc*<C-r>z*<ESC>',
            { noremap = true, silent = true, desc = "Wrap selection in *italic*" }
          )
          vim.keymap.set(
            "v",
            "<leader>kb",
            '"zygvc**<C-r>z**<ESC>',
            { noremap = true, silent = true, desc = "Wrap selection in **bold**" }
          )
          vim.keymap.set(
            "v",
            "<leader>kc",
            '"zygvc`<C-r>z`<ESC>',
            { noremap = true, silent = true, desc = "Wrap selection in `code`" }
          )

          vim.keymap.set("n", "<leader>kv", "i![]()<ESC>hp", { noremap = true, silent = true })
        end,
      })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "python",
        callback = function()
          -- vim.keymap.set("n", "<leader>r", "<cmd>!python %<CR>", { buffer = true })
          vim.keymap.set("i", "<c-k>p", function()
            ls.snip_expand(s("log", {
              t('print(f"'),
              i(1, ""),
              t('"'),
              i(2, ""),
              t(")"),
            }))
          end, { buffer = true, desc = "Insert println snippet" })
        end,
      })
      --       local html_snippet = {
      --         ls.parser.parse_snippet(
      --           "!",
      --           [[
      -- <!DOCTYPE html>
      -- <html lang="en">
      -- <head>
      --   <meta charset="UTF-8">
      --   <meta name="viewport" content="width=device-width, initial-scale=1.0">
      --   <title>${1:Document}</title>
      -- </head>
      -- <body>
      --   $0
      -- </body>
      -- </html>
      --         ]]
      --         ),
      --       }

      -- Add an HTML snippet that expands the "!" trigger to full HTML boilerplate.
      -- ls.add_snippets("html", html_snippet)
      -- ls.add_snippets("tmpl", html_snippet)

      -- Ensure .tmpl files are treated as HTML
      -- vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
      --   pattern = "*.tmpl",
      --   callback = function()
      --     vim.bo.filetype = "html"
      --   end,
      -- })
    end,
  },
}
