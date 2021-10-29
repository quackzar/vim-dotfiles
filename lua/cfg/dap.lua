local dap = require('dap')
-- require('dap-python').setup('~/.local/share/.virtualenvs/debugpy/bin/python')
-- require('dap-python').setup('/opt/homebrew/bin/python3')


vim.fn.sign_define('DapBreakpoint', {text=' ', texthl='Keyword', linehl='', numhl=''})
vim.fn.sign_define('DapLogPoint', {text=' ', texthl='Keyword', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='', texthl='Function', linehl='', numhl=''})

vim.g.dap_virtual_text = true

require("dapui").setup({
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
  },
  sidebar = {
    -- You can change the order of elements in the sidebar
    elements = {
      -- Provide as ID strings or tables with "id" and "size" keys
      {
        id = "scopes",
        size = 0.25, -- Can be float or integer > 1
      },
      { id = "breakpoints", size = 0.25 },
      { id = "stacks", size = 0.25 },
      { id = "watches", size = 00.25 },
    },
    size = 40,
    position = "left", -- Can be "left", "right", "top", "bottom"
  },
  tray = {
    elements = { "repl" },
    size = 10,
    position = "bottom", -- Can be "left", "right", "top", "bottom"
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
})

-- If you want to use this for rust and c, add something like this:

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
