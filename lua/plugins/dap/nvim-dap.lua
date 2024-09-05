return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")

      -- Keymaps
      vim.keymap.set("n", "<leader>dc", function()
        dap.continue()
      end, { desc = "Continue" })

      vim.keymap.set("n", "<F6>", function()
        dap.step_over()
      end, { desc = "Step over" })

      vim.keymap.set("n", "<F5>", function()
        dap.step_into()
      end, { desc = "Step into" })

      vim.keymap.set("n", "<F7>", function()
        dap.step_out()
      end, { desc = "Step out" })

      vim.keymap.set("n", "<Leader>db", function()
        dap.toggle_breakpoint()
      end, { desc = "Toggle breakpoint" })

      vim.keymap.set("n", "<Leader>dB", function()
        dap.set_breakpoint()
      end, { desc = "Set breakpoint" })

      vim.keymap.set("n", "<Leader>dl", function()
        dap.run_last()
      end, { desc = "Run last" })

      vim.keymap.set("n", "<Leader>dr", function()
        vim.b.dap_last_run = nil
        if vim.b.dap_last_run == nil then
          print("Successfully reset debugging configurations")
        end
      end, { desc = "Reset debugger configs" })

      vim.keymap.set("n", "<Leader>dt", function()
        dap.terminate()
        require("dapui").close()
      end, { desc = "Terminate" })

      vim.keymap.set("n", "<Leader>dd", function()
        dap.disconnect()
        require("dapui").close()
      end, { desc = "Disconnect" })

      -- Breakpoint style
      vim.fn.sign_define("DapBreakpoint", {
        text = " ", -- Custom symbol for breakpoints
        -- texthl = "DapBreakpoint", -- Highlight group for the breakpoint symbol
        -- linehl = "", -- Line highlight (empty for no line highlight)
        -- numhl = "", -- Number highlight (empty for no number highlight)
      })

      vim.fn.sign_define("DapBreakpointCondition", {
        text = "󰟃 ", -- Custom symbol for conditional breakpoints
      })

      vim.fn.sign_define("DapBreakpointRejected", {
        text = " ", -- Custom symbol for rejected breakpoints
      })

      -- Setting up debuggers

      -- starting codelldb (c/c++/rust)
      local codelldb_path = os.getenv("HOME")
        .. "/.local/share/"
        .. (os.getenv("NVIM_APPNAME") or "nvim")
        .. "/mason/packages/codelldb/extension/adapter/codelldb"
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          -- command = "/home/moyenmedium/.local/share/vimCru/mason/packages/codelldb/extension/adapter/codelldb",
          command = codelldb_path,
          args = { "--port", "${port}" },
        },
      }
      -- cpp
      dap.configurations.cpp = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            vim.b.dap_last_run = vim.b.dap_last_run
              or vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            return vim.b.dap_last_run
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }
      -- java -> look up jdtls setup in ../lsp/jdtls.lua instead
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "mfussenegger/nvim-dap",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup({})
      -- UI components
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },
}
