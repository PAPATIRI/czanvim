return {
  -- 1. Tambahkan custom registry ke Mason
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry", -- Registry yang menyediakan roslyn
      }
    end,
  },

  -- 2. Setup roslyn.nvim
  {
    "seblyng/roslyn.nvim",
    ft = { "cs", "razor", "cshtml" },
    opts = {
      -- Kamu bisa menambahkan konfigurasi spesifik roslyn di sini nanti
    },
  },
}
