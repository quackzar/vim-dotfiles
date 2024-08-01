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
            require("cfg.telescope")
        end,
    },

    {
        "jvgrootveld/telescope-zoxide",
    },

    {
        "natecraddock/telescope-zf-native.nvim",
    },

    {
        "danielfalk/smart-open.nvim",
        branch = "0.2.x",
        config = function()
            require("telescope").load_extension("smart_open")
        end,
        dependencies = {
            "kkharji/sqlite.lua",
        },
    },

    -- "nvim-telescope/telescope-z.nvim",

    -- }}}
    {
        "leath-dub/snipe.nvim",
        opts = {},
        keys = {
            {
                "gb",
                function()
                    local toggle = require("snipe").create_buffer_menu_toggler()
                    toggle()
                end,
            },
        },
    },
}
