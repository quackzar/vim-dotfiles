local commands = require("cfg.commands")

local indexOf = function(array, value)
    for i, v in ipairs(array) do
        if v == value then
            return i
        end
    end
    return nil
end

return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "TimCreasman/neo-tree-tests-source.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        {
            -- only needed if you want to use the commands with "_with_window_picker" suffix
            "s1n7ax/nvim-window-picker",
            version = "1.*",
            opts = {
                autoselect_one = true,
                include_current = false,
                filter_rules = {
                    -- filter using buffer options
                    bo = {
                        -- if the file type is one of following, the window will be ignored
                        filetype = { "neo-tree", "neo-tree-popup", "notify", "quickfix" },

                        -- if the buffer type is one of following, the window will be ignored
                        buftype = { "terminal", "nofile" },
                    },
                },
                other_win_hl_color = "#e35e4f",
            },
        },
    },
    lazy = true,
    cmd = "Neotree",
    opts = {
        sources = {
            "filesystem",
            "netman.ui.neo-tree",
            "buffers",
            "git_status", -- NOTE: Sort of redundant?
            "document_symbols",
            "tests",
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
            filtered_items = {
                hide_gitignored = false,
                hide_ignored = false,
            },
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

                ["]]"] = { commands.focus_next_fold_start, desc = "next sibling" },
                ["[["] = { commands.focus_prev_fold_end, desc = "prev sibling" },
                ["]["] = { commands.focus_fold_start, desc = "child" },
                ["[]"] = { commands.focus_fold_end, desc = "parent" },

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
    },
    init = function()
        local group = vim.api.nvim_create_augroup("refresh-neotree", { clear = true })
        -- This ensures neo-tree is updated after <C-z> or other things that could change things.
        -- This is mostly an issue with git commands that stage or unstage things, as file changes are detected.
        vim.api.nvim_create_autocmd({ "FocusGained", "VimResume", "TermLeave" }, {
            group = group,
            callback = function()
                require("neo-tree.sources.manager").refresh()
            end,
        })
        -- This ensures that neo-tree is updated whenever neo-git does 'something'.
        -- Usually this means staging/unstaging files will be reflected immediately.
        vim.api.nvim_create_autocmd({ "User" }, {
            pattern = "NeogitStatusRefreshed",
            group = group,
            callback = function()
                require("neo-tree.sources.manager").refresh()
            end,
        })
        vim.keymap.set("n", "<leader>z", "<cmd>Neotree focus last<cr>", { desc = "Focus neo tree" })
        vim.keymap.set("n", "<leader>Z", "<cmd>Neotree toggle last<cr>", { desc = "Toggle neo tree" })
        vim.keymap.set("n", "<leader>v", "<cmd>Neotree focus document_symbols<cr>", { desc = "Focus symbols" })
        vim.keymap.set("n", "<leader>V", "<cmd>Neotree toggle document_symbols<cr>", { desc = "Toggle symbols" })
    end,
}
