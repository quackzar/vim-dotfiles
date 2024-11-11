local opts = {
    options = {
        numbers = "ordinal",
        close_command = "lua Snacks.bufdelete()",
        -- right_mouse_command = "bdelete! %d",
        left_mouse_command = "buffer %d",
        middle_mouse_command = nil,
        -- NOTE: this plugin is designed with this icon in mind,
        -- and so changing this is NOT recommended, this is intended
        -- as an escape hatch for people who cannot bear it for whatever reason
        indicator = {
            icon = "▎",
        },
        buffer_close_icon = "󰅖",
        modified_icon = "●",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        --- name_formatter can be used to change the buffer's label in the bufferline.
        --- Please note some names can/will break the
        --- bufferline so use this at your discretion knowing that it has
        --- some limitations that will *NOT* be fixed.
        name_formatter = function(buf) -- buf contains a "name", "path" and "bufnr"
            -- remove extension from markdown files for example
            if buf.name:match("%.md") then
                return vim.fn.fnamemodify(buf.name, ":t:r")
            end
        end,
        max_name_length = 18,
        max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
        tab_size = 18,
        diagnostics = false, --"nvim_lsp",
        diagnostics_update_in_insert = false,
        -- NOTE: this will be called a lot so don't do any heavy processing here
        offsets = {
            { filetype = "neo-tree", text = "Explorer 󱁕 ", text_align = "center" },
            { filetype = "DiffviewFiles", text = "Source Control  ", text_align = "center" },
            { filetype = "aerial", text = "Aerial  ", text_align = "center" },
            { filetype = "Outline", text = "Symbols  ", text_align = "center" },
            { filetype = "OverseerList", text = "Overseer  ", text_align = "center" },
            { filetype = "Table of contents (VimTeX)", text = "Table of Contents", text_align = "center" },
        },
        custom_filter = function(buf_num, buf_numbers)
            return not (
                    vim.bo[buf_num].filetype == "NvimTree"
                    or vim.bo[buf_num].filetype == "qf"
                    or vim.bo[buf_num].filetype == "dap-repl"
                    or vim.bo[buf_num].filetype == "dapui_watches"
                    or vim.bo[buf_num].filetype == "dapui_stacks"
                    or vim.bo[buf_num].filetype == "dapui_scopes"
                    or vim.bo[buf_num].filetype == "dapui_breakpoints"
                    or vim.bo[buf_num].filetype == "dapui_hover"
                )
        end,
        hover = {
            enabled = true,
            delay = 200,
            reveal = { "close" },
        },
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
        -- can also be a table containing 2 custom separators
        -- [focused and unfocused]. eg: { '|', '|' }
        separator_style = "slant",
        enforce_regular_tabs = false,
        always_show_bufferline = false,
        sort_by = "id",
    },
    -- Else the bufferline looks weird, however should probably only be loaded if catppuccin is the active colorscheme.
    -- highlights = require("catppuccin.groups.integrations.bufferline").get(),
}

return {
    {
        "akinsho/bufferline.nvim",
        enabled = true,
        version = "v4.*",
        dependencies = "nvim-tree/nvim-web-devicons",
        priority = 1002,
        opts = function()
            local Offset = require("bufferline.offset")
            if not Offset.edgy then
                local get = Offset.get
                Offset.get = function()
                    if package.loaded.edgy then
                        local layout = require("edgy.config").layout
                        local ret = { left = "", left_size = 0, right = "", right_size = 0 }
                        for _, pos in ipairs { "left", "right" } do
                            local sb = layout[pos]
                            if sb and #sb.wins > 0 then
                                local title = " Sidebar" .. string.rep(" ", sb.bounds.width - 8)
                                ret[pos] = "%#EdgyTitle#" .. title .. "%*" .. "%#WinSeparator#│%*"
                                ret[pos .. "_size"] = sb.bounds.width
                            end
                        end
                        ret.total_size = ret.left_size + ret.right_size
                        if ret.total_size > 0 then
                            return ret
                        end
                    end
                    return get()
                end
                Offset.edgy = true
            end
            return opts
        end,
        event = "BufEnter",
        keys = {
            { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "next buffer" },
            { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "prev buffer" },
        },
    },
}
