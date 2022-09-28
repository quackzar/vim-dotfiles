local Hydra = require("hydra")
local splits = require("smart-splits")

local function cmd(command)
    return table.concat { "<Cmd>", command, "<CR>" }
end

local buffer_hydra = Hydra {
    name = "Buffer",
    config = {
        timeout = 2000,
        position = "middle",
    },
    heads = {
        { "h", cmd("BufferLinePrev"), { desc = "previous"}},
        { "l", cmd("BufferLineNext"), { desc = "next" } },

        -- Execute an async functions synchronously to preserve the animation.
        {
            "H",
            function()
                vim.cmd("BufferLineMovePrev")
                vim.wait(200, function()
                    vim.cmd("redraw")
                end, 30, false)
            end,
        },
        {
            "L",
            function()
                vim.cmd("BufferLineMoveNext")
                vim.wait(200, function()
                    vim.cmd("redraw")
                end, 30, false)
            end,
            { desc = "move" },
        },
        {
            "c",
            function()
                vim.cmd("BufferLinePickClose")
                vim.wait(150, function()
                    vim.cmd("redraw")
                end, 30, false)
            end,
            { desc = "close" },
        },

        { "b", cmd("BufferLinePick"), { exit = true, desc = "pick" } },
        { "od", cmd("BufferLineSortByDirectory"), { desc = "by directory" } },
        { "ol", cmd("BufferLineSortByExtension"), { desc = "by language" } },
        { "<Esc>", nil, { exit = true } },
    },
}

local function choose_buffer()
    if #vim.fn.getbufinfo { buflisted = true } > 1 then
        buffer_hydra:activate()
    end
end

vim.keymap.set("n", "<space>b", choose_buffer)

Hydra {
    name = "WINDOWS",
    hint = [[
 ^^^^^^     Move     ^^^^^^   ^^    Size   ^^   ^^     Split
 ^^^^^^--------------^^^^^^   ^^-----------^^   ^^---------------
 ^ ^ _k_ ^ ^   ^ ^ _K_ ^ ^    ^   _<C-k>_   ^   _s_: horizontally
 _h_ ^ ^ _l_   _H_ ^ ^ _L_    _<C-h>_ _<C-l>_   _v_: vertically
 ^ ^ _j_ ^ ^   ^ ^ _J_ ^ ^    ^   _<C-j>_   ^   _q_: close
 focus^^^^^^   window^^^^^^   ^ _=_ equalize^   _b_: choose buffer
      ^^^^^^         ^^^^^^   ^ _z_ maxmimize^  ^^
]],
    config = {
        timeout = 4000,
        hint = {
            border = "rounded",
            position = "middle",
        },
    },
    mode = "n",
    body = "<C-w>",
    heads = {
        { "h", "<C-w>h" },
        { "j", "<C-w>j" },
        { "k", cmd([[try | wincmd k | catch /^Vim\%((\a\+)\)\=:E11:/ | close | endtry]]) },
        { "l", "<C-w>l" },

        { "H", cmd("WinShift left") },
        { "J", cmd("WinShift down") },
        { "K", cmd("WinShift up") },
        { "L", cmd("WinShift right") },

        {
            "<C-h>",
            function()
                splits.resize_left(2)
            end,
        },
        {
            "<C-j>",
            function()
                splits.resize_down(2)
            end,
        },
        {
            "<C-k>",
            function()
                splits.resize_up(2)
            end,
        },
        {
            "<C-l>",
            function()
                splits.resize_right(2)
            end,
        },
        { "=", "<C-w>=", { desc = "equalize" } },
        { "z", "<cmd>WindowsMaximize<cr>", { exit = true, desc = "maximize" } },
        { "s", "<C-w>s" },
        { "v", "<C-w>v" },
        { "b", choose_buffer, { exit = true, desc = "choose buffer" } },
        { "q", cmd([[try | close | catch /^Vim\%((\a\+)\)\=:E444:/ | endtry]]) },
        { "<Esc>", nil, { exit = true, desc = false } },
    },
}
