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


require("dapui").setup({})
vim.keymap.set('n', '<leader>du', require("dapui").toggle, {desc='Toggle DAP UI'})


-- If you want to use this for rust and c, add something like this:
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

dap.adapters.chrome = {
    type = "executable",
    command = "node",
    args = '~/.local/share/nvim/mason/bin/chrome-debug-adapter'
    -- args = {vim.fn.path.concat { vim.fn.stdpath "data", "mason", "bin", "chrome-debug-adapter" }}
}

dap.configurations.typescript = { -- change to typescript if needed
    {
        type = "chrome",
        request = "attach",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        port = 9222,
        webRoot = "${workspaceFolder}"
    }
}

-- dap.adapters.python = {
--     type = 'executable';
--     command = 'path/to/virtualenvs/debugpy/bin/python';
--     args = {'-m', vim.fn.path.concat { vim.fn.stdpath "data", "mason", "bin", "chrome-debug-adapter" }} -- TODO adjust
-- }

dap.configurations.python = {
  {
    -- The first three options are required by nvim-dap
    type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = 'launch';
    name = "Launch file";

    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

    program = "${file}"; -- This configuration will launch the current file if used.
    pythonPath = function()
      -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
      -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
      -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
        return cwd .. '/venv/bin/python'
      elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
        return cwd .. '/.venv/bin/python'
      else
        return '/usr/bin/python'
      end
    end;
  },
}
