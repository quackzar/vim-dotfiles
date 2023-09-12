local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")
local lga_actions = require("telescope-live-grep-args.actions")

require("telescope").load_extension("fzf")
require("telescope").load_extension("i23")
require("telescope").load_extension("ast_grep")
require("telescope").load_extension("live_grep_args")

require("telescope").setup {
    defaults = {
        -- Default configuration for telescope goes here:
        -- config_key = value,
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        mappings = {
            i = {
                ["<esc>"] = actions.close,
                ["<C-u>"] = false,
                ["<c-t>"] = trouble.open_with_trouble,
                -- map actions.which_key to <C-h> (default: <C-/>)
                -- actions.which_key shows the mappings for your picker,
                -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                ["<C-h>"] = "which_key",
            },
            n = {
                ["<c-t>"] = trouble.open_with_trouble,
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
        },
    },
    prompt_prefix = "   ",

    color_devicons = true,
    set_env = { ["COLORTERM"] = "truecolor" },
    file_ignore_patterns = { "node_modules", ".git", "bin", "target", "obj" },
    pickers = {
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --   picker_config_key = value,
        --   ...
        -- }
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker
        lsp_document_symbols = {
            theme = "dropdown",
        },
        lsp_workspace_symbols = {
            theme = "dropdown",
        },
        tagstack = {
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
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        },
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = false,
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
    },
}

-- require("telescope").load_extension("z")
