local Hydra = require("hydra")

-- local hint = [[
--  _n_: step over   _s_: Continue/Start   _b_: Breakpoint     _K_: Eval
--  _i_: step into   _x_: Quit             ^ ^                 ^ ^
--  _o_: step out    _X_: Stop             _u_: Toggle UI
--  _c_: to cursor   ^ ^                   _C_: Close UI
--  ^
--  ^ ^              _q_/_<esc>_: exit
-- ]]

local function dap_start()
    if require("dap").session() ~= nil then
        return "continue"
    else
        return "start"
    end
end

local hint = [[
 ^ ^    DAP 
 _s_: %{dap_start}
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
 _e_: exceptions
 ^ ^
 _<_: up stack
 _>_: down stack
 _._: focus frame
 ^ ^
 _u_: toggle UI
 _q_: stop

     _<esc>_
   exit mode

 ^ ^  Watches 
 ^e^: edit
 ^r^: repl
 ^o^: open
 ^d^: remove
 ^t^: toggle
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
            funcs = {
                ["dap_start"] = dap_start,
            },
        },
        on_enter = function()
            require("neo-tree.sources.manager").close_all()
            require("dapui").open()
            require("nvim-dap-virtual-text").enable()
            vim.bo.modifiable = false
        end,
    },
    mode = { "n", "x" },
    body = "<leader>d",
    heads = {
        -- Start and restart
        {
            "s",
            function()
                if require("dap").session() ~= nil then
                    require("dap").continue()
                    return
                end
                vim.ui.input({
                    prompt = "Debug: ",
                    completion = "shellcmd", -- TODO: Better completion
                    nargs = "*",
                }, function(input)
                    if input == nil then
                        return
                    end
                    local args = vim.split(vim.fn.expand(input), " ")
                    local file = table.remove(args, 1)
                    local approval = vim.fn.confirm(
                        "Will try to run:\n    " .. input .. "\n\n" .. "Do you approve? ",
                        "&Yes\n&No",
                        1
                    )
                    local filetype
                    if vim.bo.filetype == "rust" or vim.bo.filetype == "cpp" or vim.bo.filetype == "c" then
                        filetype = "codelldb"
                    else
                        filetype = vim.bo.filetype
                    end

                    if approval == 1 then
                        require("dap").run {
                            type = filetype, -- TODO: Detect which adapter to use
                            request = "launch",
                            name = "Launch file with custom arguments (adhoc)",
                            program = file,
                            args = args,
                        }
                    end
                end)
            end,
            { silent = true, exit = false },
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
            "<",
            function()
                require("dap").up()
            end,
            { silent = true },
        },
        {
            ">",
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
            "q",
            function()
                require("dap").terminate()
            end,
            { silent = true },
        },
        {
            "<esc>",
            function()
                -- if there is no active session, we can just close
                if require("dap").session() == nil then
                    require("nvim-dap-virtual-text").refresh()
                    require("dapui").close()
                end
            end,
            { silent = true, exit = true },
        },
        -- {
        --     "q",
        --     function()
        --         -- quit everything
        --         require("dap").disconnect { terminateDebuggee = true }
        --         require("nvim-dap-virtual-text").refresh()
        --         require("dapui").close()
        --     end,
        --     { exit = true, nowait = true },
        -- },

        -- OLD and UNUSED
        -- { "q", nil, { exit = true, nowait = true } },
        -- { "K", ":lua require('dap.ui.widgets').hover()<CR>", { silent = true } },
        -- { "C", ":lua require('dapui').close()<cr>:DapVirtualTextForceRefresh<CR>", { silent = true } },
    },
}

-- local init_hint = [[
--  ^ ^    DAP 
--  _s_: start
--                ^
--                ^
--                ^
--                ^
--                ^
--                ^
--                ^
--                ^
--                ^
--                ^
--                ^
--                ^
--                ^
--                ^
--                ^
--                ^
--                ^
--                ^
--                ^
--                ^
--                ^
--                ^
--                ^
--                ^
--                ^
--                ^
-- ]]

-- local dap_init_hydra = Hydra {
--     name = "dap",
--     hint = init_hint,
--     config =  {
--         color = 'red',
--         hint = {
--             position = "middle-right",
--             border = "rounded",
--         },
--         on_exit = function ()
--             if require("dap").session() ~= nil then
--                 dap_hydra:activate()
--             end
--         end
--     },
--     heads = {
--         { 's', function()
--             require('dap').continue()
--         end, {exit = true}
--         },

--         {'<esc>', nil, {exit = true}}

--     }
-- }

-- vim.keymap.set({'n', 'v'}, '<leader>d', function ()
--     if require("dap").session() ~= nil then
--         dap_hydra:activate()
--     else
--         dap_init_hydra:activate()
--     end
-- end)
