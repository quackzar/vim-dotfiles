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
    toggle = "t",
  },
  -- Expand lines larger than the window
  -- Requires >= 0.7
  expand_lines = vim.fn.has("nvim-0.7"),
  -- Layouts define sections of the screen to place windows.
  -- The position can be "left", "right", "top" or "bottom".
  -- The size specifies the height/width depending on position.
  -- Elements are the elements shown in the layout (in order).
  -- Layouts are opened in order so that earlier layouts take priority in window sizing.
  layouts = {
    {
      elements = {
      -- Elements can be strings or table with id and size keys.
        { id = "scopes", size = 0.25 },
        "breakpoints",
        "stacks",
        "watches",
      },
      size = 40,
      position = "left",
    },
    {
      elements = {
        "repl",
        "console",
      },
      size = 10,
      position = "bottom",
    },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil, -- Can be integer or nil.
  }
})


-- If you want to use this for rust and c, add something like this:
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
