return {
  {
    "L3MON4D3/LuaSnip",
    ft = { "html", "tmpl" },
    event = "InsertEnter", -- load LuaSnip when you start inserting text
    -- event = { "BufReadPre", "BufNewFile" },
    config = function()
      local ls = require("luasnip")

      -- (Optional) Set up LuaSnip's configuration.
      ls.config.set_config({
        history = true,
        updateevents = "TextChanged,TextChangedI",
      })
      -- Define the HTML snippet

      local html_snippet = {
        ls.parser.parse_snippet(
          "!",
          [[
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>${1:Document}</title>
</head>
<body>
  $0
</body>
</html>
        ]]
        ),
      }

      -- Add an HTML snippet that expands the "!" trigger to full HTML boilerplate.
      ls.add_snippets("html", html_snippet)
      ls.add_snippets("tmpl", html_snippet)

      -- Ensure .tmpl files are treated as HTML
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = "*.tmpl",
        callback = function()
          vim.bo.filetype = "html"
        end,
      })
    end,
  },
}
