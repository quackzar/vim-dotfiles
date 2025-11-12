local Hydra = require("hydra")
local gitsigns = require("gitsigns")
local gitportal = require("gitportal")

-- try not to map p, y, w, b, i, a,
local hint = [[
^ _s_: stage hunk        _r_: reset hunk    _K_: preview hunk   _b_: blame line   ^
^ _u_: undo stage hunk   _R_: reset buffer  _Y_: yank link      _B_: blame buffer ^
^ _S_: stage buffer      _D_: diff mode     _P_: open link      _o_: options      ^
^ _c_: commit            _H_: history       _L_: log            _G_: graph        ^
^ ^ ^         _g_/_<enter>_: Neogit                    _<esc>_: exit
]]

local git_hydra = Hydra {
    hint = hint,
    config = {
        color = "pink",
        invoke_on_body = true,
        hint = {
            float_opts = {
                border = "rounded",
            },
            position = "bottom",
        },
        on_enter = function()
            vim.cmd("mkview!")
            vim.cmd("silent! %foldopen!")
            gitsigns.toggle_linehl(true)
            gitsigns.toggle_word_diff(true)
            vim.cmd("UfoDetach")
        end,
        on_exit = function()
            local cursor_pos = vim.api.nvim_win_get_cursor(0)
            gitsigns.toggle_linehl(false)
            gitsigns.toggle_deleted(false)
            gitsigns.toggle_word_diff(false)
            pcall(vim.cmd, "loadview")
            vim.api.nvim_win_set_cursor(0, cursor_pos)
            vim.cmd("normal zv")
            vim.cmd("UfoAttach")
            vim.cmd("echo") -- clear the echo area
        end,
    },
    name = "git",
    mode = { "n", "x" },
    body = "<leader>g",
    heads = {
        { "s", gitsigns.stage_hunk },
        { "u", gitsigns.undo_stage_hunk },
        { "S", gitsigns.stage_buffer },
        { "r", gitsigns.reset_hunk },
        { "D", "<cmd>DiffviewOpen -- % <cr>", { exit = true } },
        { "L", "<cmd>DiffviewFileHistory<cr>", { exit = true } },
        { "H", "<cmd>DiffviewFileHistory %<cr>", { exit = true } },
        {
            "G",
            function()
                require("gitgraph").draw({}, { all = true, max_count = 5000 })
            end,
            { exit = true },
        },
        { "R", gitsigns.reset_buffer },
        { "K", gitsigns.preview_hunk },
        { "Y", gitportal.copy_link_to_clipboard },
        { "P", gitportal.open_file_in_neovim, { exit = true } },
        -- { "O", gitportal.open_file_in_browser },
        -- { "d", gitsigns.toggle_deleted, { nowait = true } },
        { "b", gitsigns.blame_line },
        {
            "B",
            function()
                vim.cmd("ToggleBlame virtual")
            end,
        },
        -- TODO: This one vvv does not work that well
        { "o", "<cmd>Gitsigns<cr>", { exit = true } }, -- show the base of the file
        { "c", "<cmd>Neogit commit<cr>", { exit = true } },
        { "<enter>", "<cmd>Neogit<cr>", { exit = true, exit_before = true } },
        { "g", "<cmd>Neogit<cr>", { exit = true, exit_before = true, nowait = true } },
        { "<esc>", nil, { exit = true, nowait = true } },
    },
}

-- This hydra triggers if we are not in a git repo, since nothing will work.
local git_init_hydra = Hydra {
    hint = [[
                     Git has not been intilizalied in this directory                       ^
                                                                                           ^
                               Initalize git repo? _y_/_n_                                 ^
                                                                                           ^
    ]],
    config = {
        color = "amaranth",
        invoke_on_body = true,
        hint = {
            float_opts = {
                border = "rounded",
            },
            position = "bottom",
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
                if output == nil then
                    vim.notify("Could not Initlize repo", vim.log.levels.WARN)
                else
                    vim.notify(output)
                end
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
    -- check whether we are in a git repo, otherwise it's going to be awkward.
    -- If there is a more elegant way of checking it, let me know.
    local err_code = os.execute("git rev-parse --show-toplevel 2> /dev/null")
    if err_code == 0 then
        git_hydra:activate()
    else
        git_init_hydra:activate()
    end
end
vim.keymap.set({ "n", "x" }, "<leader>g", activate_git_hydra, { desc = "[Hydra] git" })
