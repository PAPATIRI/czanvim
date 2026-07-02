return {
  "NStefan002/screenkey.nvim",
  lazy = false,
  version = "*",
  keys = {
    { "<leader>uk", "<cmd>Screenkey toggle<cr>", desc = "Toggle Screenkey" },
  },
  opts = {
    win_opts = {
      row = vim.o.lines - vim.o.cmdheight - 1,
      col = vim.o.columns - 1,
      relative = "editor",
      anchor = "SE",
      width = 40,
      height = 3,
      border = "single",
      title = "Screenkey",
    },
    compress_after = 3, -- kalau kamu tekan "jjjj" beruntun, ditampilin jadi "j..x4"
    clear_after = 3, -- hilang otomatis setelah 3 detik nganggur
    group_mappings = true, -- kalau nekan keymap gabungan (misal <leader>ff), ditampilin sebagai grup
  },
}
