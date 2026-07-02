return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
      "jay-babu/mason-nvim-dap.nvim",
    },
    keys = {
      {
        "<F5>",
        function()
          require("dap").continue()
        end,
        desc = "Debug: Start/Continue",
      },
      {
        "<S-F5>",
        function()
          require("dap").terminate()
        end,
        desc = "Debug: Stop",
      },
      {
        "<F9>",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Debug: Toggle Breakpoint",
      },
      {
        "<F10>",
        function()
          require("dap").step_over()
        end,
        desc = "Debug: Step Over",
      },
      {
        "<F11>",
        function()
          require("dap").step_into()
        end,
        desc = "Debug: Step Into",
      },
      {
        "<S-F11>",
        function()
          require("dap").step_out()
        end,
        desc = "Debug: Step Out",
      },
      {
        "<C-F5>",
        function()
          vim.cmd("write")
          vim.cmd("!dotnet run")
        end,
        desc = "Run without debugging (dotnet run)",
      },
      {
        "<leader>db",
        function()
          vim.cmd("write")
          vim.cmd("!dotnet build")
        end,
        desc = "Dotnet Build",
      },
      {
        "<leader>du",
        function()
          require("dapui").toggle()
        end,
        desc = "Dap UI",
      },
    },
    config = function()
      local dap = require("dap")
      require("dapui").setup()
      require("nvim-dap-virtual-text").setup({})

      -- auto buka/tutup dap-ui saat sesi debug mulai/selesai
      dap.listeners.after.event_initialized["dapui_config"] = function()
        require("dapui").open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        require("dapui").close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        require("dapui").close()
      end

      dap.adapters.coreclr = {
        type = "executable",
        -- JANGAN pakai shim netcoredbg.CMD di mason/bin (spawn-nya sering exit code 1 di Windows,
        -- ada bug normalisasi slash di dalam script batch-nya). Tunjuk langsung ke .exe aslinya
        -- di dalam folder packages -- ini native PE binary, tidak perlu wrapper cmd.exe sama sekali.
        command = vim.fn.stdpath("data") .. "/mason/packages/netcoredbg/netcoredbg/netcoredbg.exe",
        args = { "--interpreter=vscode" },
      }

      -- helper: cari .dll hasil build, cross-platform (tanpa shell `find`, aman di Windows)
      local function get_dll_path()
        local cwd = vim.fn.getcwd()
        local dlls = vim.fn.globpath(cwd, "**/bin/Debug/**/*.dll", false, true)
        if #dlls == 1 then
          return dlls[1]
        elseif #dlls > 1 then
          -- lebih dari satu .csproj di solution -> biar user pilih
          local choice = vim.fn.confirm("Pilih dll:\n" .. table.concat(dlls, "\n"), "&1\n&Manual", 1)
          if choice == 1 then
            return dlls[1]
          end
        end
        return vim.fn.input("Path ke .dll: ", cwd .. "/bin/Debug/", "file")
      end

      dap.configurations.cs = {
        {
          type = "coreclr",
          name = "Build lalu Launch",
          request = "launch",
          program = function()
            vim.fn.system("dotnet build -c Debug")
            return get_dll_path()
          end,
          cwd = "${workspaceFolder}",
          -- jalankan di terminal betulan supaya output kelihatan & Console.ReadLine() bisa input
          console = "integratedTerminal",
        },
        {
          type = "coreclr",
          name = "Launch tanpa build ulang",
          request = "launch",
          program = get_dll_path,
          cwd = "${workspaceFolder}",
          console = "integratedTerminal",
        },
        {
          type = "coreclr",
          name = "Attach ke proses",
          request = "attach",
          processId = require("dap.utils").pick_process,
        },
      }
    end,
  },

  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
      ensure_installed = { "netcoredbg" },
      automatic_installation = true,
    },
  },
}
