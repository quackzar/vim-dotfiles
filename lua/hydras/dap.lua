local Hydra = require("hydra")

-- local hint = [[
--  _n_: step over   _s_: Continue/Start   _b_: Breakpoint     _K_: Eval
--  _i_: step into   _x_: Quit             ^ ^                 ^ ^
--  _o_: step out    _X_: Stop             _u_: Toggle UI
--  _c_: to cursor   ^ ^                   _C_: Close UI
--  ^
--  ^ ^              _q_/_<esc>_: exit
-- ]]

local hint = [[
 _s_: continue/start
 _p_: pause
 _r_: restart
 ^ ^
 _n_: step over
 _i_: step into
 _o_: step out
 _c_: to cursor
 ^ ^
 _b_: breakpoint
 _a_: logpoint
 _e_: exception
 ^ ^
 _>_: up stack
 _<_: down stack
 _._: focus frame
 ^ ^
 _u_: toggle UI
 _x_: stop
 _q_: stop and exit
 _<esc>_: exit mode
]]

local dap_hydra = Hydra {
    name = "dap",
    hint = hint,
    config = {
        color = "pink",
        invoke_on_body = true,
        hint = {
            position = "middle-right",
            border = "rounded",
        },
        on_enter = function()
            require("dapui").open()
            require("nvim-dap-virtual-text").enable()
        end,
    },
    mode = { "n", "x" },
    body = "<leader>d",
    heads = {
        -- Start and restart
        {
            "s",
            function()
                require("dap").continue()
            end,
            { silent = true },
        },
        {
            "r",
            function()
                require("dap").restart()
            end,
            { silent = true },
        },
        {
            "p",
            function()
                require("dap").pause()
            end,
            { silent = true },
        },
        -- { "R", function() require("dap").reverse_continue() end, { silent = true } },

        -- Stepping
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

        -- Breakpoints and Exceptions
        {
            "b",
            function()
                require("dap").toggle_breakpoint()
            end,
            { silent = true },
        },
        {
            "a",
            function()
                require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
            end,
        },
        {
            "e",
            function()
                require("dap").set_exception_breakpoints()
            end,
            { silent = true },
        },

        -- Movement
        {
            ">",
            function()
                require("dap").up()
            end,
            { silent = true },
        },
        {
            "<",
            function()
                require("dap").down()
            end,
            { silent = true },
        },
        {
            ".",
            function()
                require("dap").focus_frame()
            end,
            { silent = true },
        },

        -- Stopping, quitting and just exiting
        {
            "u",
            function()
                require("dapui").toggle()
            end,
            { desc = "Toggle DAP UI" },
        },
        {
            "x",
            function()
                require("dap").terminate()
            end,
            { silent = true },
        },
        {
            "q",
            function()
                require("dap").disconnect { terminateDebuggee = true }
                require("nvim-dap-virtual-text").refresh()
                require("dapui").close()
            end,
            { silent = true, exit = true },
        },
        { "<esc>", nil, { exit = true, nowait = true } },

        -- OLD and UNUSED
        -- { "q", nil, { exit = true, nowait = true } },
        -- { "K", ":lua require('dap.ui.widgets').hover()<CR>", { silent = true } },
        -- { "C", ":lua require('dapui').close()<cr>:DapVirtualTextForceRefresh<CR>", { silent = true } },
    },
}

Hydra.spawn = function(head)
    if head == "dap-hydra" then
        dap_hydra:activate()
    end
end
