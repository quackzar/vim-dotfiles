return {
    {
        "L3MON4D3/LuaSnip",
        config = function() -- TODO: Hydra could help?
            require("cfg.luasnip")
            require("luasnip.loaders.from_vscode").lazy_load()
            require("luasnip.loaders.from_snipmate").lazy_load()
            -- luasnip.snippets = require("luasnip-snippets").load_snippets()
        end,
        dependencies = { "rafamadriz/friendly-snippets" },
        lazy = true,
        keys = { "<c-s>" },
        event = "InsertEnter",
    },
}
