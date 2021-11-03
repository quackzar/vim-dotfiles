local dap = require('dap')


vim.fn.sign_define('DapBreakpoint', {text=' ', texthl='Keyword', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointRejected', {text=' ', texthl='Keyword', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointCondition', {text=' ', texthl='Identifier', linehl='', numhl=''})
vim.fn.sign_define('DapLogPoint', {text=' ', texthl='Keyword', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text=' ', texthl='Function', linehl='', numhl=''})

require("nvim-dap-virtual-text").setup({
    highlight_changed_variables = true,
    show_stop_reason = true, -- show stop reason when stopped for exceptions
    virt_text_pos = 'eol', -- position of virtual text, see :h nvim_buf_set_extmark()
})


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
      { id = "watches", size = 0.25 },
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
