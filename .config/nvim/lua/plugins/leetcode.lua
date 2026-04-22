return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
  cmd = "Leet",
  dependencies = {
    -- include a picker of your choice, see picker section for more details
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  -- local lc = require("leetcode"),
  opts = {
    ---@type string
    arg = "leetcode.nvim",

    ---@type lc.lang
    lang = "golang",

    ---@type lc.storage
    storage = {
      home = vim.fn.stdpath("data") .. "/leetcode",
      cache = vim.fn.stdpath("cache") .. "/leetcode",
    },

    ---@type table<string, boolean>
    plugins = {
      non_standalone = false,
    },

    ---@type boolean
    logging = true,

    injector = {
      ["rust"] = {
        before = { "#[allow(dead_code)]", "fn main(){}", "#[allow(dead_code)]", "struct Solution;" },
      }, ---@type table<lc.lang, lc.inject>
      ["golang"] = {
        before = { "package leetcode" },
      }, ---@type table<lc.lang, lc.inject>
    },

    cache = {
      update_interval = 60 * 60 * 24 * 7, ---@type integer 7 days
    },

    editor = {
      reset_previous_code = false, ---@type boolean
      fold_imports = false, ---@type boolean
    },

    console = {
      open_on_runcode = true, ---@type boolean

      dir = "row", ---@type lc.direction

      size = { ---@type lc.size
        width = "90%",
        height = "75%",
      },

      result = {
        size = "60%", ---@type lc.size
      },

      testcase = {
        virt_text = true, ---@type boolean

        size = "40%", ---@type lc.size
      },
    },

    description = {
      position = "left", ---@type lc.position

      width = "70%", ---@type lc.size

      show_stats = true, ---@type boolean
    },

    ---@type lc.picker
    picker = { provider = nil },

    -- hooks = {
    --   ---@type fun()[]
    --   ["enter"] = {},
    --
    --   ---@type fun(question: lc.ui.Question)[]
    --   ["question_enter"] = {},
    --
    --   ---@type fun()[]
    --   ["leave"] = {},
    -- },
    hooks = {
      ---@type fun(question: lc.ui.Question)[]
      ["question_enter"] = {
        function(question)
          if question.lang ~= "rust" then
            return
          end
          local problem_dir = vim.fn.stdpath("data") .. "/leetcode/Cargo.toml"
          local content = [[
              [package]
              name = "leetcode"
              edition = "2024"
                                                                                                     
              [lib]
              name = "%s"
              path = "%s"
                                                                                                     
              [dependencies]
              rand = "0.8"
              regex = "1"
              itertools = "0.14.0"
            ]]
          local file = io.open(problem_dir, "w")
          if file then
            local formatted = (content:gsub(" +", "")):format(question.q.frontend_id, question:path())
            file:write(formatted)
            file:close()
          else
            print("Failed to open file: " .. problem_dir)
          end
        end,
      },
    },

    keys = {
      toggle = { "q" }, ---@type string|string[]
      confirm = { "<CR>" }, ---@type string|string[]

      reset_testcases = "r", ---@type string
      use_testcase = "U", ---@type string
      focus_testcases = "H", ---@type string
      focus_result = "L", ---@type string
    },

    ---@type lc.highlights
    theme = {},

    ---@type boolean
    -- image_support = true,

    vim.keymap.set("n", "<leader>lo", "<cmd>Leet open<CR>", { desc = "open in browser" }),
    vim.keymap.set("n", "<leader>lr", "<cmd>Leet run<CR>", { desc = "run test" }),
    vim.keymap.set("n", "<leader>li", "<cmd>Leet info<CR>", { desc = "question info" }),
    vim.keymap.set("n", "<leader>lq", "<cmd>Leet exit<CR>", { desc = "exit leetcode" }),
    vim.keymap.set("n", "<leader>ly", "<cmd>Leet yank<CR>", { desc = "yank code" }),
    vim.keymap.set("n", "<leader>lt", "<cmd>Leet tabs<CR>", { desc = "choose tabs" }),
    vim.keymap.set("n", "<leader>lS", "<cmd>Leet submit<CR>", { desc = "submit question" }),
    vim.keymap.set("n", "<leader>ld", "<cmd>Leet desc<CR>", { desc = "toggle desc" }),
    vim.keymap.set("n", "<leader>ll", "<cmd>Leet list<CR>", { desc = "questions list" }),
    vim.keymap.set("n", "<leader>lc", "<cmd>Leet console<CR>", { desc = "console" }),
  },
  -- configuration goes here
}
