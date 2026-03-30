return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- Memastikan kita menambahkan (extend) ke list bawaan LazyVim, bukan menimpanya
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          -- 1. Neovim & Konfigurasi Core
          "lua",
          "vim",
          "vimdoc",

          -- 2. .NET (Backend & Cross-platform Desktop/Mobile)
          "c_sharp",
          "xml",
          "json",

          -- 3. Web Backend
          "php",
          "php_only",
          "go",
          "gomod",
          "gowork",
          "gosum",

          -- 4. Web Frontend
          "html",
          "css",
          "scss",
          "vue",
          "javascript",
          "typescript",
          "tsx",

          -- 5. Mobile
          "dart",

          -- 6. Infrastructure & Environment
          "dockerfile",
          "bash",
        })
      end
    end,
  },
}
