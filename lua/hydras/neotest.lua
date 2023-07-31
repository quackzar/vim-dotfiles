local Hydra = require("hydra")

-- TODO: Overhaul this in the same manner as the DAP hydra
-- i.e., auto overview when active, nicer menu, menu placement?

local hint = [[
 ^ ^                  ^ ^   TESTING 󰙨
 _t_: test nearest    _a_: attach nearest    _o_: summary
 _f_: test file       _x_: stop nearest      _d_: debug nearest
 ^ ^                  _<esc>_: exit
]]

local test_hydra = Hydra {
    hint = hint,
    config = {
        color = "pink",
        invoke_on_body = true,
        hint = {
            position = "bottom",
            border = "rounded",
        },
        on_enter = function()
            vim.bo.modifiable = false
            require("neotest").summary.open()
        end,
        on_exit = function()
            require("neotest").summary.close()
        end,
    },
    name = "test",
    mode = { "n", "x" },
    body = "<leader>t",
    heads = {
        {
            "t",
            function()
                require("neotest").run.run()
            end,
            { silent = true },
        },
        {
            "x",
            function()
                require("neotest").run.stop()
            end,
            { silent = true },
        },
        {
            "f",
            function()
                require("neotest").run.run(vim.fn.expand("%"))
            end,
            { silent = true },
        },
        {
            "d",
            function()
                require("neotest").run.run { strategy = "dap" }
            end,
            { silent = true, exit = true },
        },
        {
            "a",
            function()
                require("neotest").run.attach()
            end,
            { silent = true },
        },
        {
            "o",
            function()
                require("neotest").summary.toggle()
            end,
            { silent = true },
        },
        { "<esc>", nil, { exit = true, nowait = true } },
    },
}

Hydra.spawn = function(head)
    if head == "test-hydra" then
        test_hydra:activate()
    end
end
