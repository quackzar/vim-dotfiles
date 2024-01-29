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
        "natecraddock/telescope-zf-native.nvim",
    },

    -- "nvim-telescope/telescope-z.nvim",

    {

        "ziontee113/icon-picker.nvim",
        lazy = true, -- TODO: Used?
        config = function()
            require("icon-picker")
        end,
    },

    -- }}}
}
