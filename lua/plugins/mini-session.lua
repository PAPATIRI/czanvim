return {
  "nvim-mini/mini.sessions",
  version = "*",
  event = "BufReadPre",
  opts = {
    autoread = false,
    directory = vim.fn.stdpath("data") .. "/sessions",
  },
  keys = {
    {
      "<leader>qs",
      function()
        require("mini.sessions").select()
      end,
      desc = "Select a Session",
    },
    {
      "<leader>qS",
      function()
        local name = vim.fn.input("Session Name: ")
        if name ~= "" then
          require("mini.sessions").write(name)
        end
      end,
      desc = "Save Session",
    },
    {
      "<leader>qd",
      function()
        require("mini.sessions").select("delete", { force = true })
      end,
      desc = "Delete Sessions (Force)",
    },
  },
}
