local Hydra = require("hydra")

local hint = [[
 ^ ^             ^ ^   NEOGEN 󱡱
 _n_: annotate   _c_: class      _f_: function
 _t_: type       _d_: file
 ^ ^                  _<esc>_: exit
]]

local test_hydra = Hydra {
    hint = hint,
    config = {
        color = "teal",
        invoke_on_body = true,
        hint = {
            float_opts = {
                border = "rounded",
            },
            position = "bottom",
        },
    },
    name = "neogen",
    mode = { "n", "x" },
    body = "<leader>n",
    heads = {
        {
            "n",
            function()
                require("neogen").generate {}
            end,
            { desc = "document thing" },
        },
        {
            "f",
            function()
                require("neogen").generate { type = "func" }
            end,
            { desc = "document function" },
        },
        {
            "c",
            function()
                require("neogen").generate { type = "class" }
            end,
            { desc = "document class" },
        },
        {
            "d",
            function()
                require("neogen").generate { type = "file" }
            end,
            { desc = "document file" },
        },
        {
            "t",
            function()
                require("neogen").generate { type = "type" }
            end,
            { desc = "document type" },
        },
        { "<esc>", nil, { exit = true, nowait = true } },
    },
}
