return {
  "nvim-telescope/telescope.nvim",
  event = "VimEnter",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      "nvim-telescope/telescope-fzf-native.nvim",

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = "make",

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
    { "nvim-telescope/telescope-ui-select.nvim" },

    -- Useful for getting pretty icons, but requires a Nerd Font.
    { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
  },
  config = function()
    -- Telescope is a fuzzy finder that comes with a lot of different things that
    -- it can fuzzy find! It's more than just a "file finder", it can search
    -- many different aspects of Neovim, your workspace, LSP, and more!
    --
    -- The easiest way to use Telescope, is to start by doing something like:
    --  :Telescope help_tags
    --
    -- After running this command, a window will open up and you're able to
    -- type in the prompt window. You'll see a list of `help_tags` options and
    -- a corresponding preview of the help.
    --
    -- Two important keymaps to use while in Telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    --
    -- This opens a window that shows you all of the keymaps for the current
    -- Telescope picker. This is really useful to discover what Telescope can
    -- do as well as how to actually do it!

    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    local file_ignore_patterns = {
      "node_modules",
      ".git/",
      "target/",
      "Cargo.lock",
      "env/",
      ".venv",
      ".gradle/",
      ".db",
      ".class",
      "META-INF",
      ".module",
      ".png",
      ".jpg",
      "vgcore*",
      -- "run",
      "bin",
      ".cache",
      "Hakurei_Shrine",
      "Session.vim",
      "package",
    }
    require("telescope").setup({
      -- You can put your default mappings / updates / etc. in here
      --  All the info you're looking for is in `:help telescope.setup()`
      defaults = {
        layout_config = {
          horizontal = {
            preview_width = 0.5,
          },
          preview_cutoff = 0, -- this is where it should be
        },
        mappings = {

          i = {
            ["<Esc>"] = require("telescope.actions").close,
            ["<C-p>"] = require("telescope.actions").move_selection_previous, -- move to prev result
            ["<C-j>"] = require("telescope.actions").move_selection_next, -- move to next result
          },
          n = {},
        },
      },
      pickers = {
        find_files = {
          file_ignore_patterns = file_ignore_patterns,
          theme = "ivy",
          layout_config = {
            height = 100, -- set the height in lines
            width = 100, -- set the width as a percentage (0.0 - 1.0)
            -- preview_cutoff = 0,
          },
          hidden = true,
          mappings = {
            i = {
              ["<C-Q>"] = function(prompt_bufnr)
                local entry = require("telescope.actions.state").get_selected_entry()
                local filepath = entry.path or entry.filename

                if filepath then
                  vim.fn.delete(filepath)
                  -- print("Deleted: " .. filepath)
                  -- require("telescope.actions").close(prompt_bufnr) -- close telescope after deleting
                  require("telescope.builtin").find_files()
                end
              end,
            },
          },
        },
        live_grep = {
          file_ignore_patterns = file_ignore_patterns,
          additional_args = function(_)
            return { "--hidden" }
          end,
        },
        buffers = {
          mappings = {
            i = { ["<C-w>"] = require("telescope.actions").delete_buffer },
            n = { ["<C-w>"] = require("telescope.actions").delete_buffer },
          },
        },
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
      },
    })

    -- Enable Telescope extensions if they are installed
    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "ui-select")

    -- See `:help telescope.builtin`
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>nh", builtin.help_tags, { desc = "Search Help" })
    vim.keymap.set("n", "<leader>nk", builtin.keymaps, { desc = "Search Keymaps" })

    vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Search Files" })
    vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "Git Status" })

    vim.keymap.set("n", "<leader>nn", builtin.builtin, { desc = "Search Select Telescope" })
    vim.keymap.set("n", "<leader>nw", builtin.live_grep, { desc = "Search by Grep" })
    vim.keymap.set("n", "<leader>nW", builtin.grep_string, { desc = "Search current Word" })
    vim.keymap.set("n", "<leader>n.", builtin.oldfiles, { desc = 'Search Recent Files ("." for repeat)' })
    vim.keymap.set("n", "<leader>nd", builtin.diagnostics, { desc = "Search Diagnostics" })
    vim.keymap.set("n", "<leader>nr", builtin.resume, { desc = "Search Resume" })
    vim.keymap.set("n", "<leader>e", builtin.buffers, { desc = "Find existing buffers" })

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set("n", "<leader>/", function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
      }))
    end, { desc = "[/] Fuzzily search in current buffer" })

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    -- vim.keymap.set("n", "<leader>s/", function()
    --   builtin.live_grep({
    --     grep_open_files = true,
    --     prompt_title = "Live Grep in Open Files",
    --   })
    -- end, { desc = "[S]earch [/] in Open Files" })
  end,
}
