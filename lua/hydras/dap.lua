local Hydra = require("hydra")
local dap = require("dap")

local hint = [[
 _n_: step over   _s_: Continue/Start   _b_: Breakpoint     _K_: Eval
 _i_: step into   _x_: Quit             ^ ^                 ^ ^
 _o_: step out    _X_: Stop             _u_: Toggle UI
 _c_: to cursor   ^ ^                   _C_: Close UI
 ^
 ^ ^              _q_/_<esc>_: exit
]]

local dap_hydra = Hydra {
    hint = hint,
    config = {
        color = "pink",
        invoke_on_body = true,
        hint = {
            position = "bottom",
            border = "rounded",
        },
    },
    name = "dap",
    mode = { "n", "x" },
    body = "<leader>d",
    heads = {
        { "n", dap.step_over, { silent = true } },
        { "i", dap.step_into, { silent = true } },
        { "o", dap.step_out, { silent = true } },
        { "c", dap.run_to_cursor, { silent = true } },
        { "s", dap.continue, { silent = true } },
        { "u", require('dapui').toggle, { desc = "Toggle DAP UI" } },
        { "x", ":lua require'dap'.disconnect({ terminateDebuggee = false })<CR>", { exit = true, silent = true } },
        { "X", dap.close, { silent = true } },
        { "C", ":lua require('dapui').close()<cr>:DapVirtualTextForceRefresh<CR>", { silent = true } },
        { "b", dap.toggle_breakpoint, { silent = true } },
        { "K", ":lua require('dap.ui.widgets').hover()<CR>", { silent = true } },
        { "q", nil, { exit = true, nowait = true } },
        { "<esc>", nil, { exit = true, nowait = true } },
    },
}

Hydra.spawn = function(head)
    if head == "dap-hydra" then
        dap_hydra:activate()
    end
end
