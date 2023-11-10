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
        event = "VimEnter",
        config = function()
            require("cfg.telescope")
        end,
    },

    "romgrk/fzy-lua-native", -- for use with wilder

    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    },

    -- "nvim-telescope/telescope-z.nvim",

    {

        "ziontee113/icon-picker.nvim",
        config = function()
            require("icon-picker")
        end,
    },

    -- }}}
}
