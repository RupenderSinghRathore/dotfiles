return {
  {
    "L3MON4D3/LuaSnip",
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

      local go_error_return = {
        ls.parser.parse_snippet(
          "@r",
          [[
if err != nil {
    return err
}
          ]]
        ),
      }
      local go_error_log = {
        ls.parser.parse_snippet(
          "@l",
          [[
if err != nil {
    log.Fatal(err)
}
          ]]
        ),
      }

      -- Add an HTML snippet that expands the "!" trigger to full HTML boilerplate.
      ls.add_snippets("html", html_snippet)
      ls.add_snippets("tmpl", html_snippet)
      ls.add_snippets("go", go_error_return)
      ls.add_snippets("go", go_error_log)

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
