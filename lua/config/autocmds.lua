-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- agar tidak auto comment
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove({ "o", "r" })
  end,
  desc = "Matikan auto-comment pada baris baru",
})

-- Windows: Neovim kadang membuka file dengan '/' (mis. lewat picker/explorer),
-- sedangkan PDB .NET menyimpan path sumber dengan '\'. netcoredbg mencocokkan
-- path secara literal, jadi breakpoint tidak akan ter-bind kalau separatornya beda.
-- Paksa nama buffer memakai backslash supaya breakpoint DAP nyangkut.
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function(ev)
    local name = vim.api.nvim_buf_get_name(ev.buf)
    if name:match("^%a:/") then
      vim.api.nvim_buf_set_name(ev.buf, (name:gsub("/", "\\")))
      vim.api.nvim_buf_call(ev.buf, function()
        pcall(vim.cmd, "silent! edit")
      end)
    end
  end,
  desc = "Normalkan separator path buffer ke '\\' (fix breakpoint netcoredbg)",
})

-- Memaksa background LspInlayHint menjadi transparan
vim.api.nvim_create_autocmd({ "ColorScheme", "LspAttach" }, {
  callback = function()
    local hl = vim.api.nvim_get_hl(0, { name = "LspInlayHint" })

    vim.api.nvim_set_hl(0, "LspInlayHint", { fg = hl.fg, bg = "NONE", default = false })
  end,
})
