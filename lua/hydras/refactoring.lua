local Hydra = require("hydra")

local function cmd(command)
    return table.concat { "<Cmd>", command, "<CR>" }
end

local function vcmd(command)
    return table.concat { [[<Esc><Cmd>]], command, [[<CR>]] }
end

-- For rereference:
--   ^ VARIABLES ^                  ^ EXPRESSIONS ^                  ^ DEBUG PRINT    ^
--   _n_: Rename      _b_: Extract block   ^e^: Extract function      _p_: Print var  ^
--   _i_: Inline      _B_:   ... to file   ^f^:   ... to file         _c_: Clear up   ^
--   ^v^: Extract
--   ^ ^                   _q_: Format     _r_: Select refactor           _<Esc>_
--
local hint_visual = [[
   ^ VARIABLES ^                  ^ EXPRESSIONS ^                  ^ DEBUG PRINT    ^
   _n_: rename      _b_: extract block   _e_: extract function      _p_: print var  ^
   _i_: inline      _B_: ...to file      _f_: ...to file                            ^
   _v_: extract                                                                     ^
   ^ ^              _s_: ssr             _r_: select refactor           _<esc>_     ^
]]
local hint_normal = [[
   ^ VARIABLES ^                  ^ EXPRESSIONS ^                  ^ DEBUG PRINT    ^
   _n_: rename      _b_: extract block                              _p_: orint var  ^
   _i_: inline      _B_: ...to file                                 _c_: clear up   ^
   ^                                                                                ^
   ^ ^   _s_: ssr        _q_: format     _r_: select refactor           _<esc>_     ^
]]

-- Normal Mode Version
Hydra {
    name = "Refactor",
    hint = hint_normal,
    config = {
        color = "blue",
        invoke_on_body = true,
        hint = {
            position = "bottom",
            border = "rounded",
        },
    },
    mode = { "n" },
    body = "<leader>r",
    heads = {
        { "<esc>", nil, { exit = true, nowait = true } },
        { "r", require("refactoring").select_refactor, { desc = "Select refactor" } },
        { "n", vim.lsp.buf.rename, { desc = "Rename" } },
        { "q", vim.lsp.buf.formatting, { desc = "Format buffer" } },
        { "q", vim.lsp.buf.formatting, { desc = "Format buffer" } },
        {
            "i",
            cmd([[lua require('refactoring').refactor('Inline Variable')]]),
            { desc = "Inline variable" },
        },
        {
            "b",
            cmd([[lua require('refactoring').refactor('Extract Block')]]),
            { desc = "Extract block" },
        },
        {
            "B",
            cmd([[lua require('refactoring').refactor('Extract Block To File')]]),
            { desc = "Extract block to file" },
        },
        {
            "p",
            cmd("lua require('refactoring').debug.print_var({ normal = true })"),
            { desc = "Debug print" },
        },
        {
            "c",
            cmd("lua require('refactoring').debug.cleanup({})"),
            { desc = "Debug print cleanup" },
        },
        {
            "s",
            cmd("lua require('ssr').open()"),
        },
    },
}

-- Visual Mode Version
Hydra {
    name = "Refactor",
    hint = hint_visual,
    config = {
        color = "teal",
        invoke_on_body = true,
        hint = {
            position = "bottom",
            border = "rounded",
        },
    },
    mode = { "v" },
    body = "<leader>r",
    heads = {
        { "<esc>", nil, { exit = true, nowait = true } },
        { "r", require("refactoring").select_refactor, { desc = "Select refactor" } },
        { "n", vim.lsp.buf.rename, { desc = "Rename" } },
        {
            "i",
            cmd([[ lua require('refactoring').refactor('Inline Variable') ]]),
            { desc = "Inline variable" },
        },
        {
            "b",
            cmd([[ lua require('refactoring').refactor('Extract Block')]]),
            { desc = "Extract block" },
        },
        {
            "B",
            cmd([[ lua require('refactoring').refactor('Extract Block To File')]]),
            { desc = "Extract block to file" },
        },
        {
            "v",
            cmd("lua require('refactoring').debug.print_var({ normal = true })"),
            { desc = "Debug print" },
        },
        {
            "s",
            cmd("lua require('ssr').open()"),
        },
        -- Visual Mode Only
        {
            "e",
            vcmd([[lua require('refactoring').refactor('Extract Function')]]),
            { desc = "Extract function" },
        },
        {
            "f",
            vcmd([[lua require('refactoring').refactor('Extract Function To File')]]),
            { desc = "Extract function to file" },
        },
        {
            "v",
            vcmd([[lua require('refactoring').refactor('Extract Variable')]]),
            { desc = "Extract variable" },
        },
        -- Debugging Prints
        {
            "p",
            cmd("lua require('refactoring').debug.print_var({})"),
            { desc = "Debug print cleanup" },
        },
    },
}
