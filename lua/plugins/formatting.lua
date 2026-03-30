return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      -- Core
      lua = { "stylua" },

      -- Web Backend
      php = { "pint" },
      go = { "goimports", "gofumpt" },
      cs = { "csharpier" },

      -- Web Frontend & Configs (Ditangani oleh Prettier)
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" }, -- React (JSX)
      typescriptreact = { "prettier" }, -- React (TSX)
      vue = { "prettier" },
      html = { "prettier" },
      css = { "prettier" },
      scss = { "prettier" }, -- Customisasi Bootstrap 5
      json = { "prettier" },

      -- Desktop / Mobile Cross-Platform UI (.NET)
      xml = { "xmlformatter" },
      axaml = { "xstyler" },
      xaml = { "xstyler" },

      -- Mobile (Flutter)
      dart = { "dart_format" }, -- Menggunakan command bawaan SDK Flutter

      -- Infrastructure / Shell
      sh = { "shfmt" },
    },
    formatters = {
      xstyler = {
        command = vim.fn.expand("~/.dotnet/tools/xstyler"),
        args = { "-f", "$FILENAME" },
        stdin = false,
      },
    },
  },
}
