-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.lazyvim_php_lsp = "intelephense"

vim.filetype.add({
  extension = {
    axaml = "axaml",
    xaml = "xaml",
  },
})

-- 2. Beritahu Treesitter untuk meminjam parser XML pada file tersebut
vim.treesitter.language.register("xml", "axaml")
vim.treesitter.language.register("xml", "xaml")
