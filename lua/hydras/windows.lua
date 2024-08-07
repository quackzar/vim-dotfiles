local Hydra = require("hydra")

local cmd = require("hydra.keymap-util").cmd
local pcmd = require("hydra.keymap-util").pcmd

local buffer_hydra = Hydra {
    name = "Bufferline",
    config = {
        -- position = "middle",
        on_key = function()
            -- preserve animation
            vim.wait(200, function()
                vim.cmd("redraw")
            end, 30, false)
        end,
        hint = {
            type = "window",
        },
    },
    heads = {
        { "h", cmd("BufferLinePrev"), { desc = "previous" } },
        { "l", cmd("BufferLineNext"), { desc = "next" } },

        -- Execute an async functions synchronously to preserve the animation.
        { "H", cmd("BufferLineMovePrev") },
        { "L", cmd("BufferLineMoveNext"), { desc = "move" } },
        -- { "c", cmd("Bdelete"), { desc = "close" } },

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

vim.keymap.set("n", "<space>b", choose_buffer, { desc = "choose buffer" })
local window_hint = [[
 ^^^^^^^^^^^^     Move      ^^    Size   ^^   ^^     Split
 ^^^^^^^^^^^^-------------  ^^-----------^^   ^^---------------
 ^ ^ _k_ ^ ^  ^ ^ _K_ ^ ^   ^   _<C-k>_   ^   _s_: horizontally
 _h_ ^ ^ _l_  _H_ ^ ^ _L_   _<C-h>_ _<C-l>_   _v_: vertically
 ^ ^ _j_ ^ ^  ^ ^ _J_ ^ ^   ^   _<C-j>_   ^   _q_, _c_: close
 focus^^^^^^  window^^^^^^  ^_=_: equalize^   _z_: maximize
 ^ ^ ^ ^ ^ ^  ^ ^ ^ ^ ^ ^   ^^ ^          ^   _o_: remain only
 _b_: choose buffer
]]

Hydra {
    name = "Windows",
    hint = window_hint,
    config = {
        -- invoke_on_body = true,
        hint = {
            float_opts = {
                border = "rounded",
            },
            position = "middle",
            offset = -1,
        },
    },
    mode = "n",
    body = "<C-w>",
    heads = {
        { "h", "<C-w>h" },
        { "j", "<C-w>j" },
        { "k", pcmd("wincmd k", "E11", "close") },
        { "l", "<C-w>l" },

        { "H", cmd("WinShift left") },
        { "J", cmd("WinShift down") },
        { "K", cmd("WinShift up") },
        { "L", cmd("WinShift right") },

        {
            "<C-h>",
            function()
                require("smart-splits").resize_left(2)
            end,
        },
        {
            "<C-j>",
            function()
                require("smart-splits").resize_down(2)
            end,
        },
        {
            "<C-k>",
            function()
                require("smart-splits").resize_up(2)
            end,
        },
        {
            "<C-l>",
            function()
                require("smart-splits").resize_right(2)
            end,
        },
        { "=", "<C-w>=", { desc = "equalize" } },

        { "s", pcmd("split", "E36") },
        { "<C-s>", pcmd("split", "E36"), { desc = false } },
        { "v", pcmd("vsplit", "E36") },
        { "<C-v>", pcmd("vsplit", "E36"), { desc = false } },

        { "w", "<C-w>w", { exit = true, desc = false } },
        { "<C-w>", "<C-w>w", { exit = true, desc = false } },

        { "z", cmd("WindowsMaximize"), { exit = true, desc = "maximize" } },
        { "<C-z>", cmd("WindowsMaximize"), { exit = true, desc = false } },

        { "o", "<C-w>o", { exit = true, desc = "remain only" } },
        { "<C-o>", "<C-w>o", { exit = true, desc = false } },

        { "b", choose_buffer, { exit = true, desc = "choose buffer" } },

        { "c", pcmd("close", "E444") },
        { "q", pcmd("close", "E444"), { desc = "close window" } },
        { "<C-c>", pcmd("close", "E444"), { desc = false } },
        { "<C-q>", pcmd("close", "E444"), { desc = false } },

        { "<Esc>", nil, { exit = true, desc = false } },
    },
}
