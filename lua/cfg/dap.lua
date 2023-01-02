vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "Keyword", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = " ", texthl = "Keyword", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = " ", texthl = "Identifier", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = " ", texthl = "Keyword", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = " ", texthl = "Function", linehl = "", numhl = "" })

require("nvim-dap-virtual-text").setup {
    highlight_changed_variables = true,
    show_stop_reason = true, -- show stop reason when stopped for exceptions
    virt_text_pos = "eol", -- position of virtual text, see :h nvim_buf_set_extmark()
}

require("dapui").setup {}
vim.keymap.set("n", "<leader>du", require("dapui").toggle, { desc = "Toggle DAP UI" })


local dap = require("dap")
dap.adapters.netcoredb = {

}

require("mason-nvim-dap").setup({
    automatic_setup = true,
})
require 'mason-nvim-dap'.setup_handlers()
