-- TODO: Move to ./lua/plugins/
local commands = require("cfg.commands")

local indexOf = function(array, value)
    for i, v in ipairs(array) do
        if v == value then
            return i
        end
    end
    return nil
end

require("neo-tree").setup {
    sources = {
        "filesystem",
        "netman.ui.neo-tree",
        "buffers",
        "git_status", -- NOTE: Sort of redundant?
        "document_symbols",
        -- "neotest",
    },
    default_component_configs = {
        diagnostics = {
            symbols = {
                hint = " ",
                info = " ",
                warn = " ",
                error = " ",
            },
        },
    },
    source_selector = {
        winbar = false,
        truncation_character = "…",
    },
    auto_clean_after_session_restore = false,
    close_if_last_window = true,
    filesystem = {
        follow_current_file = { enabled = true },
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
            ["zo"] = { commands.open_fold, desc = "open fold" },
            ["zO"] = { commands.open_folds_rec, desc = "open fold rec." },
            ["zc"] = { commands.close_fold, desc = "close fold" },
            ["zC"] = { commands.close_folds_rec, desc = "close fold rec." },
            ["za"] = { commands.toggle_fold, desc = "toggle fold" },
            ["zA"] = { commands.toggle_folds_rec, desc = "toggle fold rec." },
            ["zv"] = { commands.fold_view_cursor, desc = "view cursor" },
            ["zM"] = { commands.close_all_folds, desc = "close all folds" },
            ["zR"] = { commands.expand_all_folds, desc = "expand all" },
            ["[z"] = { commands.focus_fold_start, desc = "prev fold" },
            ["]z"] = { commands.focus_fold_end, desc = "next fold" },
            ["zj"] = { commands.focus_next_fold_start, desc = "next sibling" },
            ["zk"] = { commands.focus_prev_fold_end, desc = "prev sibling" },
            ["h"] = {
                function(state)
                    local node = state.tree:get_node()
                    -- if node.type == "directory" and node:is_expanded() then
                    --     require("neo-tree.sources.filesystem").toggle_directory(state, node)
                    -- else
                    --     require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
                    -- end
                    require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
                end,
                desc = "ascent",
            },
            ["l"] = {
                function(state)
                    local node = state.tree:get_node()
                    if node.type == "directory" and not node:is_expanded() then
                        require("neo-tree.sources.filesystem").toggle_directory(state, node)
                    elseif node:has_children() then
                        require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
                    else
                        -- Either next sibling or open file?
                        local parent = state.tree:get_node(node:get_parent_id())
                        local siblings = parent:get_child_ids()
                        if not node.is_last_child then
                            local currentIndex = indexOf(siblings, node.id)
                            local nextIndex = siblings[currentIndex + 1]
                            require("neo-tree.ui.renderer").focus_node(state, nextIndex)
                        end
                    end
                end,
                desc = "descent",
            },
        },
    },
    buffers = {
        follow_current_file = { enabled = true },
        show_unloaded = true,
        group_empty_dirs = true, -- when true, empty folders will be grouped together
    },
    open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "edgy" },
    document_symbols = {
        follow_cursor = true,
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
            Struct = { icon = "", hl = "Type" },
            Operator = { icon = "", hl = "Operator" },
            TypeParameter = { icon = "󰊄", hl = "Type" },
            StaticMethod = { icon = "󰠄 ", hl = "Function" },
        },
    },
}
