local dap = require('dap')
-- require('dap-python').setup('~/.local/share/.virtualenvs/debugpy/bin/python')
require('dap-python').setup('/opt/homebrew/bin/python3')

vim.fn.sign_define('DapBreakpoint', {text='', texthl='Keyword', linehl='', numhl=''})
vim.fn.sign_define('DapLogPoint', {text='', texthl='Keyword', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='', texthl='Function', linehl='', numhl=''})

vim.g.dap_virtual_text = true

require("dapui").setup({
  icons = {
    expanded = "⯆",
    collapsed = "⯈"
  },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = {"<space>", "<2-LeftMouse>"},
    open = "o",
    remove = "d",
    edit = "e",
  },
  sidebar = {
    elements = {
      -- You can change the order of elements in the sidebar
      "scopes",
      "breakpoints",
      "stacks",
      "watches"
    },
    size = 40,
    position = "left" -- Can be "left" or "right"
  },
  tray = {
    elements = {
      "repl"
    },
    size = 10,
    position = "bottom" -- Can be "bottom" or "top"
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil   -- Floats will be treated as percentage of your screen.
  }
})

dap.adapters.lldb = {
  type = 'executable',
  command = '/opt/homebrew/opt/llvm/bin/lldb-vscode', -- adjust as needed
  name = "lldb"
}

dap.configurations.cpp = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    -- program = function()
    --   return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    -- end,
    program = function()
        return vim.fn.getcwd() .. "/a.out"
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = function()
        return vim.fn.input('Args: ')
    end,
    runInTerminal = true,
  },
}


-- If you want to use this for rust and c, add something like this:

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
