local windline = require("windline")
local helper = require("windline.helpers")
local hydra = require("hydra.statusline")
local sep = helper.separators
local vim_components = require("windline.components.vim")
local cache_utils = require("windline.cache_utils")

local b_components = require("windline.components.basic")
local state = _G.WindLine.state

local lsp_comps = require("windline.components.lsp")
local git_comps = require("windline.components.git")
local git_rev = require("windline.components.git_rev")

local noicy, noice = pcall(require, "noice")

-- local lightbulb = require('lightbulb')

local hl_list = {
    Black = { "white", "black" },
    White = { "black", "white" },
    Inactive = { "InactiveFg", "InactiveBg" },
    Active = { "ActiveFg", "ActiveBg" },
}
local basic = {}

basic.divider = { b_components.divider, "" }
basic.space = { " ", "" }
basic.bg = { " ", "StatusLine" }
basic.file_name_inactive = { b_components.full_file_name, hl_list.Inactive }
basic.line_col_inactive = { b_components.line_col, hl_list.Inactive }
basic.progress_inactive = { b_components.progress, hl_list.Inactive }

basic.vi_mode = {
    hl_colors = {
        Normal = { "white", "red", "bold" },
        Insert = { "black", "green", "bold" },
        Visual = { "white", "yellow", "bold" },
        Replace = { "white", "blue_light", "bold" },
        Command = { "white", "magenta", "bold" },
        Terminal = { "black", "green", "bold" },
        NormalBefore = { "red", "black" },
        InsertBefore = { "green", "black" },
        VisualBefore = { "yellow", "black" },
        ReplaceBefore = { "blue_light", "black" },
        CommandBefore = { "magenta", "black" },
        TerminalBefore = { "green", "black" },
        NormalAfter = { "white", "red" },
        InsertAfter = { "white", "green" },
        VisualAfter = { "white", "yellow" },
        ReplaceAfter = { "white", "blue_light" },
        CommandAfter = { "white", "magenta" },
        TerminalAfter = { "white", "green" },
        teal = { "white", "cyan", "bold" },
        pink = { "white", "magenta", "bold" },
        red = { "white", "red", "bold" },
        blue = { "white", "blue_light", "bold" },
        amaranth = { "white", "red_light", "bold" },
        tealBefore = { "cyan", "black" },
        pinkBefore = { "magenta", "black" },
        redBefore = { "red", "black" },
        blueBefore = { "blue_light", "black" },
        amaranthBefore = { "red_light", "black" },
    },
    text = function()
        if hydra.is_active() and hydra.get_name() then
            return {
                { sep.left_rounded, hydra.get_color() .. "Before" },
                ---@diagnostic disable-next-line: param-type-mismatch
                { string.upper(hydra.get_name()) .. " ", hydra.get_color() },
            }
        end
        return {
            { sep.left_rounded, state.mode[2] .. "Before" },
            { state.mode[1] .. " ", state.mode[2] },
        }
    end,
}

basic.lsp_diagnos = {
    width = 90,
    hl_colors = {
        red = { "red", "black" },
        yellow = { "yellow", "black" },
        blue = { "blue", "black" },
    },
    text = function(bufnr)
        if lsp_comps.check_lsp(bufnr) then
            return {
                { lsp_comps.lsp_error { format = "  %s" }, "red" },
                { lsp_comps.lsp_warning { format = "  %s" }, "yellow" },
                { lsp_comps.lsp_hint { format = "  %s" }, "blue" },
            }
        end
        return ""
    end,
}

basic.lsp = {
    width = 20,
    hl_colors = {
        green = { "green", "black", "bold" },
    },
    text = cache_utils.cache_on_buffer({ "LspAttach", "LspDetach" }, "wl_lsp_connection", function(bufnr)
        if not lsp_comps.check_lsp(bufnr) then
            return ""
        end
        local names = {}
        for _, server in pairs(vim.lsp.get_active_clients { bufnr = bufnr }) do
            table.insert(names, server.name)
        end
        -- return {{'friend', 'default'}}
        return { { "  [" .. table.concat(names, "|") .. "]", "green" } }
    end),
}

basic.hydra = {
    hl_colors = {
        magenta = { "magenta", "black" },
    },
    text = function(_)
        local hint = require("hydra.statusline").get_hint()
        if hint then
            return " " .. hint
        end
        return ""
    end,
}

local icon_comp = b_components.cache_file_icon { default = "", hl_colors = { "white", "black_light" } }

basic.file = {
    hl_colors = {
        default = { "white", "black_light" },
    },
    text = function(bufnr)
        return {
            { " ", "default" },
            icon_comp(bufnr),
            { " ", "default" },
            { b_components.cache_file_name("[No Name]", ""), "" },
            { b_components.file_modified(" "), "" },
            { b_components.cache_file_size(), "" },
        }
    end,
}

basic.right = {
    hl_colors = {
        sep_before = { "black_light", "white_light" },
        sep_after = { "white_light", "black" },
        text = { "black", "white_light" },
    },
    text = function()
        return {
            { b_components.line_col_lua, "text" },
            { sep.right_rounded, "sep_after" },
        }
    end,
}

basic.git_diff = {
    width = 90,
    hl_colors = {
        green = { "green_light", "black" },
        red = { "red", "black" },
        blue = { "blue_light", "black" },
    },
    text = function(bufnr)
        if git_comps.is_git(bufnr) then
            return {
                { " ", "" },
                { git_comps.diff_added { format = " %s" }, "green" },
                { git_comps.diff_removed { format = "  %s" }, "red" },
                { git_comps.diff_changed { format = "  %s" }, "blue" },
            }
        end
        return ""
    end,
}

local pr_status_active, pr_status = pcall(require, "pr_status")
basic.git_pr_status = {
    width = 10,
    hl_colors = {
        green = { "green", "black" },
        red = { "red", "black" },
        blue = { "blue", "black" },
    },
    text = function(bufnr)
        if git_comps.is_git(bufnr) and pr_status_active then
            local result = pr_status.get_last_result()
            if result and result.summary then
                return { { " " .. pr_status.get_last_result_string(), "blue" } }
            end
        end
        return ""
    end,
}

basic.logo = {
    hl_colors = {
        Normal = { "white", "red" },
        Insert = { "black", "green" },
        Visual = { "white", "yellow" },
        Replace = { "white", "blue_light" },
        Command = { "white", "magenta" },
        NormalBefore = { "red", "black" },
        InsertBefore = { "green", "black" },
        VisualBefore = { "yellow", "black" },
        ReplaceBefore = { "blue_light", "black" },
        CommandBefore = { "magenta", "black" },
        teal = { "white", "cyan", "bold" },
        pink = { "white", "magenta", "bold" },
        red = { "white", "red", "bold" },
        blue = { "white", "blue_light", "bold" },
        amaranth = { "white", "red_light", "bold" },
        tealBefore = { "cyan", "black" },
        pinkBefore = { "magenta", "black" },
        redBefore = { "red", "black" },
        blueBefore = { "blue_light", "black" },
        amaranthBefore = { "red_light", "black" },
    },
    text = function()
        if hydra.is_active() and hydra.get_name() then
            return {
                { sep.left_rounded, hydra.get_color() .. "Before" },
                { "󰫤 ", hydra.get_color() },
            }
        else
            return {
                { sep.left_rounded, state.mode[2] .. "Before" },
                { "󰫤 ", state.mode[2] },
            }
        end
    end,
}

basic.noice = {
    hl_colors = {
        green = { "green", "black" },
        red = { "red", "black" },
        blue = { "blue", "black" },
    },
    text = function()
        if not noicy then
            return
        end

        local api_status = noice.api.status
        if api_status.command.has() then
            return { api_status.command.get(), "green" }
        elseif api_status.message.has() then
            return { api_status.message.get(), "red" }
        elseif api_status.search.has() then
            return { api_status.search.get(), "blue" }
        elseif api_status.mode.has() then
            return { api_status.mode.get(), "red" }
        end
        return ""
    end,
}

basic.macros = {
    hl_colors = {
        default = { "red", "black" },
        sep_before = { "black_light", "black" },
        sep_after = { "black_light", "black" },
    },
    text = function()
        if not noicy then
            return
        end

        local mode = noice.api.statusline.mode
        if mode.has() then
            return {
                { " ", "default" },
                { mode.get(), "default" },
                { " ", "default" },
            }
        end
    end,
}

local default = {
    filetypes = { "default" },
    active = {
        { " ", hl_list.Black },
        basic.logo,
        basic.file,
        { vim_components.search_count(), { "red", "black_light" } },
        { sep.right_rounded, { "black_light", "black" } },
        basic.macros,
        -- basic.macros,
        basic.lsp,
        basic.lsp_diagnos,
        basic.hydra,
        basic.divider,
        basic.git_diff,
        basic.git_pr_status,
        -- TODO: This doesn't work?
        { git_rev.git_rev { format = "⇡%s⇣%s", interval = 10000 }, { "yellow", "black" }, 90 },
        { git_comps.git_branch { icon = " 󰊢 " }, { "green", "black" }, 90 },
        { " ", hl_list.Black },
        basic.vi_mode,
        basic.right,
        { " ", hl_list.Black },
    },
    inactive = {
        basic.file_name_inactive,
        basic.divider,
        basic.divider,
        basic.line_col_inactive,
        { "", { "white", "InactiveBg" } },
        basic.progress_inactive,
    },
}

local quickfix = {
    filetypes = { "qf", "Trouble" },
    active = {
        { "🚦 Quickfix ", { "white", "black" } },
        { helper.separators.slant_right, { "black", "black_light" } },
        {
            function()
                return vim.fn.getqflist({ title = 0 }).title
            end,
            { "cyan", "black_light" },
        },
        { " Total : %L ", { "cyan", "black_light" } },
        { helper.separators.slant_right, { "black_light", "InactiveBg" } },
        { " ", { "InactiveFg", "InactiveBg" } },
        basic.divider,
        { helper.separators.slant_right, { "InactiveBg", "black" } },
        { "🧛 ", { "white", "black" } },
    },
    always_active = true,
    show_last_status = true,
}

local explorer = {
    filetypes = { "fern", "NvimTree", "lir", "neo-tree" },
    active = {
        { " 󰉓 ", { "white", "black" } },
        { helper.separators.slant_right, { "black", "black_light" } },
        { b_components.divider, "" },
        { b_components.file_name(" "), { "white", "black_light" } },
    },
    always_active = true,
    show_last_status = true,
}

-- Special statusline for alpha.nvim? Don't bother, it's just disabled anyway.

windline.setup {
    colors_name = function(colors)
        -- ADD MORE COLOR HERE ----
        return colors
    end,
    statuslines = {
        default,
        quickfix,
        explorer,
    },
    global_skip_filetypes = {
        "neo-tree",
        "NvimTree",
        "fern",
        "lir",
        "OverseerList",
        "NeogitStatus",
        "edgy",
    },
}
