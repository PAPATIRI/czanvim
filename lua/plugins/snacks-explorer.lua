return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          -- 1. Show dotfiles in the sidebar File Explorer
          explorer = {
            hidden = true,
            ignored = false, -- Change to true if you ALSO want to see files in .gitignore
          },
          -- 2. Show dotfiles when searching with <leader><space> or <leader>ff
          files = {
            hidden = true,
            ignored = false, -- Change to true if you want to find git-ignored files
          },
          -- 3. Show dotfiles when searching text across files with <leader>sg or <leader>/
          grep = {
            hidden = true,
            ignored = false,
          },
        },
      },
    },
  },
}
