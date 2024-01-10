return {
    {
        "L3MON4D3/LuaSnip",
        config = function() -- TODO: Hydra could help?
            require("cfg.luasnip")
            require("luasnip.loaders.from_vscode").lazy_load()
            require("luasnip.loaders.from_snipmate").lazy_load()
            -- luasnip.snippets = require("luasnip-snippets").load_snippets()
        end,
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!:).
        build = "make install_jsregexp",
        dependencies = { "rafamadriz/friendly-snippets" },
        lazy = true,
        keys = { "<c-s>" },
        event = "InsertEnter",
    },

    {
        "chrisgrieser/nvim-scissors",
        dependencies = "nvim-telescope/telescope.nvim",
        opts = {
            -- snippetDir = vim.fn.stdpath("data") .. "/lazy/friendly-snippets",
            snippetDir = vim.fn.stdpath("config") .. "/snippets",
            jsonFormatter = "jq",
        },
        keys = {
            {
                "<leader>se",
                function()
                    require("scissors").editSnippet()
                end,
                desc = "edit snippet",
            },
            {
                "<leader>sa",
                function()
                    require("scissors").addNewSnippet()
                end,
                desc = "add new snippet",
                mode = { "x", "n" },
            },
        },
    },
}
