require("core.options")
require("core.keymaps")
require("core.make-file")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    error("Error cloning lazy.nvim:\n" .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- plugin's go here
  require("plugins.colortheme"),
  require("plugins.treesitter"),
  require("plugins.telescope"),
  require("plugins.lsp"),
  require("plugins.autocompletion"),
  require("plugins.indent-blankline"),
  require("plugins.comment"),
  require("plugins.auto-tag"),
  require("plugins.misc"),
  require("plugins.formatting"),
  require("plugins.codium"),
  require("plugins.gitsigns"),
  require("plugins.git-fugitive"),
  require("plugins.lualine"),
  require("plugins.love"),
  require("plugins.neotree"),

  -- require("plugins.debugger"),
  -- require("plugins.copilot"),
  -- require("plugins.vim-be-good"),
  -- require("plugins.hardtime"),
  -- require("plugins.comfyline"),
})
