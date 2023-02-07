return {
    {
        "hrsh7th/nvim-cmp", -- TODO: https://github.com/hrsh7th/nvim-cmp/pull/1094
        config = function()
            require("cfg.cmp")
        end,
        event = "InsertEnter",
        dependencies = {
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-omni",
            "hrsh7th/cmp-cmdline",
            "f3fora/cmp-spell",
            "saadparwaiz1/cmp_luasnip",
        },
        keys = {
            { ":", mode = { "n", "v" } }, -- also trigger on cmdline
        },
    },
}
