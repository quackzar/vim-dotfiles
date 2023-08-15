local Hydra = require("hydra")
local gitsigns = require("gitsigns")

-- try not to map p, y, w, b, i, a,
local hint = [[
 _J_: next hunk   _s_: stage hunk        _r_: reset hunk    _d_: show deleted   _b_: blame line
 _K_: prev hunk   _u_: undo stage hunk   _R_: reset buffer  _p_: preview hunk   _B_: blame buffer
 ^ ^              _S_: stage buffer      _D_: diff this     _Y_: yank link      _/_: show base file
 ^ ^              _c_: commit            _H_: history       _L_: log
 ^ ^              _g_/_<Enter>_: Neogit                     _q_: exit
]]

local git_hydra = Hydra {
    hint = hint,
    config = {
        color = "pink",
        invoke_on_body = true,
        hint = {
            position = "bottom",
            border = "rounded",
        },
        on_enter = function()
            -- gitsigns.toggle_signs(true)
            vim.cmd("mkview")
            vim.cmd("silent! %foldopen!")
            gitsigns.toggle_linehl(true)
            gitsigns.toggle_word_diff(true)
            gitsigns.toggle_current_line_blame(true)
        end,
        on_exit = function()
            -- gitsigns.toggle_signs(false)
            local cursor_pos = vim.api.nvim_win_get_cursor(0)
            vim.cmd("loadview")
            vim.api.nvim_win_set_cursor(0, cursor_pos)
            vim.cmd("normal zv")
            gitsigns.toggle_linehl(false)
            gitsigns.toggle_deleted(false)
            gitsigns.toggle_word_diff(false)
            gitsigns.toggle_current_line_blame(false)
            vim.cmd("echo") -- clear the echo area
        end,
    },
    mode = { "n", "x" },
    body = "<leader>g",
    heads = {
        {
            "J",
            function()
                if vim.wo.diff then
                    return "]c"
                end
                vim.schedule(function()
                    gitsigns.next_hunk()
                end)
                return "<Ignore>"
            end,
            { expr = true },
        },
        {
            "K",
            function()
                if vim.wo.diff then
                    return "[c"
                end
                vim.schedule(function()
                    gitsigns.prev_hunk()
                end)
                return "<Ignore>"
            end,
            { expr = true },
        },
        { "s", gitsigns.stage_hunk },
        { "u", gitsigns.undo_stage_hunk },
        { "S", gitsigns.stage_buffer },
        { "r", gitsigns.reset_hunk },
        { "D", "<cmd>DiffviewOpen -- % <cr>", { exit = true } },
        { "L", "<cmd>DiffviewFileHistory<cr>", { exit = true } },
        { "H", "<cmd>DiffviewFileHistory %<cr>", { exit = true } },
        { "R", gitsigns.reset_buffer },
        { "Y", '<cmd>lua require"gitlinker".get_buf_range_url("n")<cr>' },
        { "p", gitsigns.preview_hunk },
        { "d", gitsigns.toggle_deleted, { nowait = true } },
        { "b", gitsigns.blame_line },
        {
            "B",
            function()
                vim.cmd("ToggleBlame virtual")
                vim.cmd("Gitsigns toggle_current_line_blame")
            end,
        },
        { "/", gitsigns.show, { exit = true } }, -- show the base of the file
        { "c", "<cmd>Neogit commit<cr>", { exit = true } },
        { "<Enter>", "<cmd>Neogit<cr>", { exit = true } },
        { "g", "<cmd>Neogit<cr>", { exit = true } },
        { "q", nil, { exit = true, nowait = true } },
    },
}

-- This hydra triggers if we are not in a git repo, since nothing will work.
local git_init_hydra = Hydra {
    hint = [[
                     Git has not been intilizalied in this directory                       ^
                                                                                           ^
                               Initlize git repo? _y_/_n_                                  ^
                                                                                           ^
    ]],
    config = {
        color = "amaranth",
        invoke_on_body = true,
        hint = {
            position = "bottom",
            border = "rounded",
        },
        on_exit = function()
            local err_code = os.execute("git rev-parse --show-toplevel 2> /dev/null")
            if err_code == 0 then
                git_hydra:activate()
            end
        end,
    },
    mode = { "n", "x" },
    body = "<leader>g",
    heads = {
        {
            "y",
            function()
                local output = vim.fn.system("git init")
                vim.notify(output)
            end,
            { exit = true },
        },
        {
            "n",
            function()
                vim.notify("Git not intilizalied")
            end,
            { exit = true },
        },
    },
}

local function activate_git_hydra()
    -- check whether we are in a git repo
    local err_code = os.execute("git rev-parse --show-toplevel 2> /dev/null")
    if err_code == 0 then
        git_hydra:activate()
    else
        git_init_hydra:activate()
    end
end
vim.keymap.set({ "n", "x" }, "<leader>g", activate_git_hydra)
