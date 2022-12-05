local Hydra = require("hydra")
local neotest = require("neotest")

local hint = [[
 _t_: test nearest    _a_: attach nearest    _o_: summary
 _f_: test file       _x_: stop nearest      _d_: debug nearest
 ^ ^
 ^ ^                  _q_: exit
]]

local test_hydra = Hydra {
    hint = hint,
    config = {
        color = "blue",
        invoke_on_body = true,
        hint = {
            position = "bottom",
            border = "rounded",
        },
    },
    name = "test",
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
            "x",
            function()
                neotest.run.stop()
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
    if head == "test-hydra" then
        test_hydra:activate()
    end
end
