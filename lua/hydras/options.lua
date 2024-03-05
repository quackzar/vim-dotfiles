local Hydra = require("hydra")

-- TODO: Make submenu instead?

local function diagnostic()
    if not vim.g.virtual_lines then
        return "[-]"
    elseif vim.g.virtual_lines then
        return "[x]"
    else
        return "[ ]"
    end
end

local function cycle_diagnostics()
    if vim.g.virtual_lines then
        vim.g.virtual_lines = false
        vim.g.virtual_text = true
        vim.g.diagflow = false
    elseif vim.g.virtual_text then
        vim.g.virtual_lines = false
        vim.g.virtual_text = false
        vim.g.diagflow = true
    else
        vim.g.virtual_lines = true
        vim.g.virtual_text = false
        vim.g.diagflow = false
    end

    require("diagflow").config.enable = vim.g.diagflow
    vim.diagnostic.config {
        virtual_lines = vim.g.virtual_lines,
        virtual_text = vim.g.virtual_text,
        -- virtual_lines = { only_current_line = true },
        signs = vim.g.diagnostic_signs,
    }
end

local function cursorlineopt()
    if not vim.o.cursorline then
        return "[?]"
    end
    if vim.o.cursorlineopt == "both" or vim.o.cursorlineopt == "line" then
        return "[x]"
    else
        -- "num"
        return "[ ]"
    end
end

local function typehintopt()
    if not vim.fn.has("nvim-0.10") then
        return "[?]"
    end
    if vim.g.inlay_hints then
        return "[x]"
    else
        return "[ ]"
    end
end

local hint = [[
  ^ ^        Options
  ^
  _v_ %{ve} virtual edit
  _i_ %{list} invisible characters
  _s_ %{spell} spell
  _w_ %{wrap} wrap
  _c_ %{culopt} cursor line
  _n_ %{nu} number
  _r_ %{rnu} relative number
  _l_ %{diag} diagnostics
  _b_ [?] block
  _t_ %{hint} inlay hints
  ^
       ^^^^                _<Esc>_
]]

Hydra {
    name = "Options",
    hint = hint,
    config = {
        color = "amaranth",
        invoke_on_body = true,
        hint = {
            float_opts = {
                border = "rounded",
            },
            position = "middle",
            funcs = {
                ["diag"] = diagnostic,
                ["culopt"] = cursorlineopt,
                ["hint"] = typehintopt,
            },
        },
    },
    mode = { "n", "x" },
    body = "<leader>o",
    heads = {
        {
            "n",
            function()
                if vim.o.number == true then
                    vim.o.number = false
                else
                    vim.o.number = true
                end
            end,
            { desc = "number" },
        },
        {
            "r",
            function()
                if vim.o.relativenumber == true then
                    vim.o.relativenumber = false
                else
                    vim.o.number = true
                    vim.o.relativenumber = true
                end
            end,
            { desc = "relativenumber" },
        },
        {
            "v",
            function()
                if vim.o.virtualedit == "all" then
                    vim.o.virtualedit = "block"
                else
                    vim.o.virtualedit = "all"
                end
            end,
            { desc = "virtualedit" },
        },
        {
            "i",
            function()
                if vim.o.list == true then
                    vim.o.list = false
                else
                    vim.o.list = true
                end
            end,
            { desc = "show invisible" },
        },
        {
            "s",
            function()
                if vim.o.spell == true then
                    vim.o.spell = false
                else
                    vim.o.spell = true
                end
            end,
            { exit = true, desc = "spell" },
        },
        {
            "w",
            function()
                if vim.o.wrap ~= true then
                    vim.o.wrap = true
                    -- Dealing with word wrap:
                    -- If cursor is inside very long line in the file than wraps
                    -- around several rows on the screen, then 'j' key moves you to
                    -- the next line in the file, but not to the next row on the
                    -- screen under your previous position as in other editors. These
                    -- bindings fixes this.
                    vim.keymap.set("n", "k", function()
                        return vim.v.count > 0 and "k" or "gk"
                    end, { expr = true, desc = "k or gk" })
                    vim.keymap.set("n", "j", function()
                        return vim.v.count > 0 and "j" or "gj"
                    end, { expr = true, desc = "j or gj" })
                else
                    vim.o.wrap = false
                    vim.keymap.del("n", "k")
                    vim.keymap.del("n", "j")
                end
            end,
            { desc = "wrap" },
        },
        {
            "c",
            function()
                -- TODO: change this to cursorline opt
                if vim.o.cursorlineopt == "number" then
                    vim.o.cursorlineopt = "both"
                else
                    vim.o.cursorlineopt = "number"
                end
            end,
            { desc = "cursor line" },
        },
        {
            "l",
            function()
                cycle_diagnostics()
            end,
            { desc = "virtual line diagnostics" },
        },
        {
            "b",
            function() -- TODO: Find a way to check if it's active
                require("block").toggle()
            end,
            { desc = "block highlighting" },
        },
        {
            "t",
            function() -- TODO: Find a way to check if it's active
                if not vim.fn.has("nvim-0.10") then
                    return
                end
                if vim.g.inlay_hints == true then
                    vim.g.inlay_hints = false
                else
                    vim.g.inlay_hints = true
                end
                vim.lsp.inlay_hint.enable(0, vim.g.inlay_hints)
            end,
            { desc = "inlay hints" },
        },
        { "<Esc>", nil, { exit = true } },
    },
}
