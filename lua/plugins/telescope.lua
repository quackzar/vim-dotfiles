return {
    -- Telescope {{{
    --
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { { "nvim-lua/plenary.nvim" } },
        event = "VimEnter",
        config = function()
            require("cfg.telescope")
        end,
    },

    "romgrk/fzy-lua-native", -- for use with wilder

    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    -- "nvim-telescope/telescope-z.nvim",

    { "Marskey/telescope-sg" },

    {

        "ziontee113/icon-picker.nvim",
        config = function()
            require("icon-picker")
        end,
    },

    {
        "max397574/colortils.nvim",
        cmd = "Colortils",
        config = true,
    },

    -- }}}
}
