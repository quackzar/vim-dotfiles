return {
    -- Telescope {{{
    --
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            {
                "nvim-telescope/telescope-live-grep-args.nvim",
                -- This will not install any breaking changes.
                -- For major updates, this must be adjusted manually.
                version = "^1.0.0",
            },
        },
        cmd = "Telescope",
        config = function()
            local actions = require("telescope.actions")
            local lga_actions = require("telescope-live-grep-args.actions")
            local action_layout = require("telescope.actions.layout")

            require("telescope").setup {
                defaults = {
                    prompt_prefix = "   ",
                    selection_caret = " ",
                    multi_icon = "󰓎 ",
                    color_devicons = true,
                    set_env = { ["COLORTERM"] = "truecolor" },
                    file_ignore_patterns = { "node_modules", ".git/", "bin", "target", "obj" },
                    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
                    mappings = {
                        i = {
                            ["<esc>"] = actions.close,
                            ["<C-u>"] = false,
                            -- map actions.which_key to <C-h> (default: <C-/>)
                            -- actions.which_key shows the mappings for your picker,
                            -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                            ["<C-h>"] = "which_key",
                            ["<C-a>"] = actions.cycle_previewers_next,
                            ["<C-s>"] = actions.cycle_previewers_prev,
                            ["<M-p>"] = action_layout.toggle_preview,
                        },
                        n = {
                            -- ["<c-t>"] = trouble.open_with_trouble,
                            ["<M-p>"] = action_layout.toggle_preview,
                        },
                    },
                    vimgrep_arguments = {
                        "rg",
                        "-L",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                        "--trim", -- add this value
                    },
                },
                pickers = {
                    -- Default configuration for builtin pickers goes here:
                    -- picker_name = {
                    --   picker_config_key = value,
                    --   ...
                    -- }
                    -- Now the picker_config_key will be applied every time you call this
                    -- builtin picker
                    buffers = {
                        mappings = {
                            i = {
                                ["<c-d>"] = actions.delete_buffer + actions.move_to_top,
                            },
                        },
                    },
                    lsp_document_symbols = {
                        theme = "dropdown",
                    },
                    lsp_workspace_symbols = {
                        theme = "dropdown",
                    },
                    tagstack = {
                        layout_strategy = "vertical",
                        layout_config = {
                            height = 0.9, --vim.o.lines, -- maximally available lines
                            width = 0.9, --vim.o.columns, -- maximally available columns
                            -- prompt_position = "top",
                            preview_height = 0.8, -- 60% of available lines
                            preview_cutoff = 1,
                        },
                    },
                    jumplist = {
                        layout_strategy = "vertical",
                        layout_config = {
                            height = 0.9, --vim.o.lines, -- maximally available lines
                            width = 0.9, --vim.o.columns, -- maximally available columns
                            -- prompt_position = "top",
                            preview_height = 0.8, -- 60% of available lines
                            preview_cutoff = 1,
                        },
                    },
                    marks = {
                        theme = "ivy",
                        layout_strategy = "vertical",
                        layout_config = {
                            height = 0.9, --vim.o.lines, -- maximally available lines
                            width = 0.9, --vim.o.columns, -- maximally available columns
                            -- prompt_position = "top",
                            preview_height = 0.8, -- 60% of available lines
                            preview_cutoff = 1,
                        },
                    },
                    live_grep = {
                        layout_strategy = "vertical",
                        layout_config = {
                            width = 0.9,
                            height = 0.9,
                            preview_cutoff = 1,
                            mirror = false,
                        },
                    },
                    grep_string = {
                        layout_strategy = "vertical",
                        layout_config = {
                            width = 0.9,
                            height = 0.9,
                            preview_cutoff = 1,
                            mirror = false,
                        },
                    },
                    lsp_implementations = {
                        layout_strategy = "vertical",
                        layout_config = {
                            width = 0.9,
                            height = 0.9,
                            preview_cutoff = 1,
                            mirror = false,
                        },
                    },
                    lsp_references = {
                        layout_strategy = "vertical",
                        layout_config = {
                            width = 0.9,
                            height = 0.9,
                            preview_cutoff = 1,
                            mirror = false,
                        },
                    },
                },
                extensions = {
                    aerial = {
                        theme = "dropdown",
                    },
                    ["zf-native"] = {
                        file = {
                            enable = true,
                        },
                        generic = {
                            enable = true,
                        },
                    },
                    ast_grep = {
                        layout_strategy = "vertical",
                        layout_config = {
                            width = 0.9,
                            height = 0.9,
                            preview_cutoff = 1,
                            mirror = false,
                        },
                    },
                    live_grep_args = {
                        auto_quoting = true, -- enable/disable auto-quoting
                        -- define mappings, e.g.
                        mappings = { -- extend mappings
                            i = {
                                ["<C-k>"] = lga_actions.quote_prompt(),
                                ["<C-i>"] = lga_actions.quote_prompt { postfix = " --iglob " },
                            },
                        },
                        layout_strategy = "vertical",
                        layout_config = {
                            width = 0.9,
                            height = 0.9,
                            preview_cutoff = 1,
                            mirror = false,
                        },
                    },
                    zoxide = {
                        theme = "dropdown",
                    },
                },
            }

            if vim.env.USE_ZF_NATIVE == "1" then
                require("telescope").load_extension("zf-native")
            end
            require("telescope").load_extension("zoxide")
        end,
    },

    {
        "jvgrootveld/telescope-zoxide",
    },

    {
        enabled = vim.env.USE_ZF_NATIVE == "1",
        "natecraddock/telescope-zf-native.nvim",
    },

    {
        "danielfalk/smart-open.nvim",
        branch = "0.2.x",
        lazy = true,
        config = function()
            require("telescope").load_extension("smart_open")
        end,
        dependencies = {
            "kkharji/sqlite.lua",
        },
    },

    {
        "jmacadie/telescope-hierarchy.nvim",
        dependencies = {
            {
                "nvim-telescope/telescope.nvim",
                dependencies = { "nvim-lua/plenary.nvim" },
            },
        },
        keys = {
            { -- lazy style key map
                -- Choose your own keys, this works for me
                "<leader>si",
                "<cmd>Telescope hierarchy incoming_calls<cr>",
                desc = "LSP: [S]earch [I]ncoming Calls",
            },
            {
                "<leader>so",
                "<cmd>Telescope hierarchy outgoing_calls<cr>",
                desc = "LSP: [S]earch [O]utgoing Calls",
            },
        },
        opts = {
            -- don't use `defaults = { }` here, do this in the main telescope spec
            extensions = {
                hierarchy = {
                    -- telescope-hierarchy.nvim config, see below
                },
                -- no other extensions here, they can have their own spec too
            },
        },
        config = function(_, opts)
            -- Calling telescope's setup from multiple specs does not hurt, it will happily merge the
            -- configs for us. We won't use data, as everything is in it's own namespace (telescope
            -- defaults, as well as each extension).
            require("telescope").setup(opts)
            require("telescope").load_extension("hierarchy")
        end,
    },
}
