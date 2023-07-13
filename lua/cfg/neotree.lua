-- TODO: Move to ./lua/plugins/
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

local commands = require("cfg.commands")

require("neo-tree").setup {
    sources = {
        "filesystem",
        "buffers",
        "git_status",
        "document_symbols",
        -- "diagnostics",
    },
    source_selector = {
        winbar = false,
        truncation_character = "…",
    },
    close_if_last_window = true,
    filesystem = {
        follow_current_file = true,
        use_libuv_file_watcher = true,
        group_empty_dirs = true,
        window = {
            mappings = {
                ["o"] = "system_open",
            },
        },
        commands = {
            system_open = function(state)
                local node = state.tree:get_node()
                local path = node:get_id()
                -- macOs: open file in default application in the background.
                -- Probably you need to adapt the Linux recipe for manage path with spaces. I don't have a mac to try.
                vim.api.nvim_command("silent !open -g " .. path)
                -- Linux: open file in default application
                vim.api.nvim_command(string.format("silent !xdg-open '%s'", path))
            end,
        },
    },
    window = {
        mappings = {
            ["z"] = "none",
            ["zo"] = commands.open_fold,
            ["zO"] = commands.open_folds_rec,
            ["zc"] = commands.close_fold,
            ["zC"] = commands.close_folds_rec,
            ["za"] = commands.toggle_fold,
            ["zA"] = commands.toggle_folds_rec,
            ["zv"] = commands.fold_view_cursor,
            ["zM"] = commands.close_all_folds,
            ["zR"] = commands.expand_all_folds,
            ["[z"] = commands.focus_fold_start,
            ["]z"] = commands.focus_fold_end,
            ["zj"] = commands.focus_next_fold_start,
            ["zk"] = commands.focus_prev_fold_end,
            ["h"] = function(state)
                local node = state.tree:get_node()
                if node.type == "directory" and node:is_expanded() then
                    require("neo-tree.sources.filesystem").toggle_directory(state, node)
                else
                    require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
                end
            end,
            ["l"] = function(state)
                local node = state.tree:get_node()
                if node.type == "directory" then
                    if not node:is_expanded() then
                        require("neo-tree.sources.filesystem").toggle_directory(state, node)
                    elseif node:has_children() then
                        require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
                    end
                end
            end,
        },
    },
    buffers = {
        follow_current_file = true,
        show_unloaded = true,
        group_empty_dirs = true, -- when true, empty folders will be grouped together
    },
    open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "edgy" },
    document_symbols = {
        follow_cursor = false,
        kinds = {
            File = { icon = "󰈙", hl = "Tag" },
            Namespace = { icon = "󰌗", hl = "Include" },
            Package = { icon = "󰏖", hl = "Label" },
            Class = { icon = "󰌗", hl = "Include" },
            Property = { icon = "󰆧", hl = "@property" },
            Enum = { icon = "󰒻", hl = "@number" },
            Function = { icon = "󰊕", hl = "Function" },
            String = { icon = "󰀬", hl = "String" },
            Number = { icon = "󰎠", hl = "Number" },
            Array = { icon = "󰅪", hl = "Type" },
            Object = { icon = "󰅩", hl = "Type" },
            Key = { icon = "󰌋", hl = "" },
            Struct = { icon = "󰌗", hl = "Type" },
            Operator = { icon = "󰆕", hl = "Operator" },
            TypeParameter = { icon = "󰊄", hl = "Type" },
            StaticMethod = { icon = "󰠄 ", hl = "Function" },
        },
    },
}

vim.keymap.set("n", "<leader>z", "<cmd>Neotree toggle<cr>", { desc = "Toggle file tree" })
vim.keymap.set("n", "<leader>Z", "<cmd>Neotree focus<cr>", { desc = "Focus file tree" })
vim.keymap.set("n", "<leader>v", "<cmd>Neotree toggle document_symbols position=right<cr>", { desc = "Toggle symbols" })
vim.keymap.set("n", "<leader>V", "<cmd>Neotree focus document_symbols position=right<cr>", { desc = "Focus symbols" })

-- doesn't work
-- vim.api.nvim_create_autocmd('FileType', {
--     group = vim.api.nvim_create_augroup("neo-tree-settings", { clear = true}),
--     pattern = 'neo-tree',
--     command = 'setlocal cursorlineopt=line',
-- })

-- vim foldmethod=marker
