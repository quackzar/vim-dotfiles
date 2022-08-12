local Hydra = require("hydra")
local neotest = require("neotest")

local hint = [[
 _t_: test nearest    _a_: attach nearest    _o_: summary
 _f_: test file       _x_: stop nearest      _d_: debug nearest
 ^
 ^ ^                  _q_: exit
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
    body = "<leader>t",
    heads = {
        {
            "t",
            function()
                neotest.run.run()
            end,
            { silent = true },
        },
        {
            "f",
            function()
                neotest.run.run(vim.fn.expand("%"))
            end,
            { silent = true },
        },
        {
            "d",
            function()
                neotest.run.run { strategy = "dap" }
            end,
            { silent = true },
        },
        {
            "a",
            function()
                neotest.run.attach()
            end,
            { silent = true },
        },
        {
            "o",
            function()
                neotest.summary.toggle()
            end,
            { silent = true },
        },
        { "q", nil, { exit = true, nowait = true } },
    },
}

Hydra.spawn = function(head)
    if head == "dap-hydra" then
        dap_hydra:activate()
    end
end
