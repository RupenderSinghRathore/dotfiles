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
      -- local f = ls.function_node
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

      -- Rust
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "rust",
        callback = function()
          -- buid commands
          vim.keymap.set("n", "<leader>r", "<cmd>!cargo run<CR>", { buffer = true })
          vim.keymap.set("n", "<F2>", "<cmd>term<CR>icargo run<CR>", { buffer = true })
          vim.keymap.set("n", "<F1>", ":!rustc % -o run && ./run<CR>", { buffer = true })
          vim.keymap.set("n", "<F3>", ":!cargo check<CR>", { buffer = true })

          -- snippets
          vim.keymap.set("i", "<C-p>", function()
            ls.snip_expand(s("log", {
              t('println!("'),
              i(1, "message"),
              t('");'),
            }))
          end, { buffer = true, desc = "Insert println snippet" })
        end,
      })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "go",
        callback = function()
          vim.keymap.set("n", "<leader>r", "<cmd>!go run %<CR>", { buffer = true })
          vim.keymap.set("i", "<C-p>", function()
            ls.snip_expand(s("log", {
              t('fmt.Printf("'),
              i(1, "message"),
              t('\\n",'),
              i(2, ""),
              t(")"),
            }))
          end, { buffer = true, desc = "Insert println snippet" })
          vim.keymap.set("i", "<C-e>", function()
            ls.snip_expand(s("Errorhandling", {
              t({ "if err != nil {", "\t" }), -- line 1 + indent
              i(1, "// TODO: handle error"), -- insert node
              t({ "", "}" }), -- empty line + closing brace
            }))
          end, { buffer = true, desc = "Insert Go error handling block" })
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "c",
        callback = function()
          -- vim.opt_local.makeprg = "clang -fsanitize=address -g -Iinclude -Wall % -o run"
          vim.keymap.set(
            "n",
            "<leader>r",
            "<cmd>!clang -fsanitize=address -g -Iinclude -Wall % -o run && ./run<CR>",
            { buffer = true }
          )
          -- vim.opt_local.makeprg = "gcc % -o run"
          vim.keymap.set("n", "<F1>", ":!./run<CR>", { buffer = true })
          vim.keymap.set("i", "<C-p>", function()
            ls.snip_expand(s("log", {
              t('printf("'),
              i(1, "message"),
              t('\\n",'),
              i(2, ""),
              t(");"),
            }))
          end, { buffer = true, desc = "Insert println snippet" })
          vim.keymap.set(
            "i",
            "<C-e>",
            'if (ok == -1) {<CR>}<Esc>Oprintf("error: %s\\n", strerror(errno));<CR>return -1;'
          )
        end,
      })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "html",
        callback = function()
          vim.keymap.set("n", "<leader>r", "<cmd>!firefox %<CR>", { buffer = true })

          vim.keymap.set("i", "<F2>", "{{% block  %}}{{% endblock %}}<Esc>Fk;la")
        end,
      })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "htmldjango",
        callback = function()
          vim.keymap.set("i", "<C-p>", "{{% block  %}}{{% endblock %}}<Esc>Fk;la")
        end,
      })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        callback = function()
          local classname = vim.fn.expand("%:t:r")
          vim.keymap.set("n", "<leader>r", "<cmd>!javac % && java " .. classname .. "<CR>", { buffer = true })
        end,
      })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "javascript",
        callback = function()
          vim.keymap.set("n", "<leader>r", "<cmd>!node %<CR>", { buffer = true })

          vim.keymap.set("i", "<C-p>", function()
            ls.snip_expand(s("log", {
              t("console.log(`"),
              i(1, "message"),
              t("`);"),
            }))
          end, { buffer = true, desc = "Insert logging snippet" })
        end,
      })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          vim.keymap.set("n", "<leader>r", "<cmd>!firefox %<CR>", { buffer = true })
          -- vim.keymap.set("n", "<leader>r", "<cmd>RenderMarkdown toggle<CR>", { buffer = true })
        end,
      })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "python",
        callback = function()
          vim.keymap.set("n", "<leader>r", "<cmd>!python %<CR>", { buffer = true })
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
