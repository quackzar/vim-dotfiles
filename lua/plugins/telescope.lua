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

    -- "nvim-telescope/telescope-z.nvim",

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
