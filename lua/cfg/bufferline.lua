require("bufferline").setup {
    options = {
        numbers = "ordinal",
        close_command = "Bdelete! %d",
        -- right_mouse_command = "bdelete! %d",
        left_mouse_command = "buffer %d",
        middle_mouse_command = nil,
        -- NOTE: this plugin is designed with this icon in mind,
        -- and so changing this is NOT recommended, this is intended
        -- as an escape hatch for people who cannot bear it for whatever reason
        indicator = {
            icon = "▎",
        },
        buffer_close_icon = "",
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
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,
        -- NOTE: this will be called a lot so don't do any heavy processing here
        offsets = {
            { filetype = "NvimTree", text = "File Explorer", text_align = "left" },
            {
                filetype = "neo-tree",
                text = function()
                    return "File Explorer (" .. vim.fn.getcwd() .. ")"
                end,
                highlight = "Directory",
                text_align = "left",
            },
            { filetype = "SidebarNvim", text = "Sidebar NVIM", text_align = "left" },
            { filetype = "Outline", text = "Symbols", text_align = "right" },
            { filetype = "OverseerList", text = "Overseer", text_align = "right" },
        },
        custom_filter = function(buf_num, buf_numbers)
            if vim.bo[buf_num].filetype ~= "NvimTree" then
                return true
            end
        end,
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
}

require("which-key").register({
    name = "Bufferline",
    ["]"] = { "<cmd>BufferLineMoveNext<cr>", "Move next" },
    ["["] = { "<cmd>BufferLineMovePrev<cr>", "Move previous" },
    ["e"] = { "<cmd>BufferLineSortByExtension<cr>", "Sort by extension" },
    ["d"] = { "<cmd>BufferLineSortByDirectory<cr>", "Sort by directory" },
    ["b"] = { "<cmd>BufferLinePick<cr>", "Pick..." },
    ["c"] = { "<cmd>BufferLinePickClose<cr>", "Close..." },
}, { prefix = "<leader>b" })
