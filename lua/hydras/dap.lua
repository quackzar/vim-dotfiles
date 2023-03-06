local Hydra = require("hydra")

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
            position = "top",
            border = "rounded",
        },
    },
    name = "dap",
    mode = { "n", "x" },
    body = "<leader>d",
    heads = {
        {
            "n",
            function()
                require("dap").step_over()
            end,
            { silent = true },
        },
        {
            "i",
            function()
                require("dap").step_into()
            end,
            { silent = true },
        },
        {
            "o",
            function()
                require("dap").step_out()
            end,
            { silent = true },
        },
        {
            "c",
            function()
                require("dap").run_to_cursor()
            end,
            { silent = true },
        },
        {
            "s",
            function()
                require("dap").continue()
            end,
            { silent = true },
        },
        {
            "u",
            function()
                require("dapui").toggle()
            end,
            { desc = "Toggle DAP UI" },
        },
        { "x", ":lua require'dap'.disconnect({ terminateDebuggee = false })<CR>", { exit = true, silent = true } },
        {
            "X",
            function()
                require("dap").close()
            end,
            { silent = true },
        },
        { "C", ":lua require('dapui').close()<cr>:DapVirtualTextForceRefresh<CR>", { silent = true } },
        {
            "b",
            function()
                require("dap").toggle_breakpoint()
            end,
            { silent = true },
        },
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
