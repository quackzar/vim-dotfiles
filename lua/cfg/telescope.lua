local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")

require("telescope").setup {
    defaults = {
        -- Default configuration for telescope goes here:
        -- config_key = value,
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
    },
    file_ignore_patterns = { "node_modules", ".git" },
    pickers = {
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --   picker_config_key = value,
        --   ...
        -- }
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker
    },
    extensions = {
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
    },
}

require("telescope").load_extension("fzf")
-- require("telescope").load_extension("z")


