local Hydra = require("hydra")
local gitsigns = require("gitsigns")
-- try not to map p, y, w, b, i, a,
local hint = [[
 _J_: next hunk   _s_: stage hunk        _r_: reset hunk    _d_: show deleted   _b_: blame line
 _K_: prev hunk   _u_: undo stage hunk   _D_: diff this     _p_: preview hunk   _B_: blame show full
 ^ ^              _S_: stage buffer      _R_: reset buffer  _Y_: yank link      _/_: show base file
 ^
 ^ ^              _<Enter>_: Neogit                         _q_: exit
]]

Hydra {
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
        { "s", ":Gitsigns stage_hunk<CR>", { silent = true } },
        { "u", gitsigns.undo_stage_hunk },
        { "S", gitsigns.stage_buffer },
        { "r", gitsigns.reset_hunk },
        { "D", gitsigns.diffthis },
        { "R", gitsigns.reset_buffer },
        { "Y", '<cmd>lua require"gitlinker".get_buf_range_url("n")<cr>' },
        { "p", gitsigns.preview_hunk },
        { "d", gitsigns.toggle_deleted, { nowait = true } },
        { "b", gitsigns.blame_line },
        {
            "B",
            function()
                gitsigns.blame_line { full = true }
            end,
        },
        { "/", gitsigns.show, { exit = true } }, -- show the base of the file
        { "<Enter>", "<cmd>Neogit<CR>", { exit = true } },
        { "q", nil, { exit = true, nowait = true } },
    },
}
