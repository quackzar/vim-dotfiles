return {
    {
        "hrsh7th/nvim-cmp", -- TODO: https://github.com/hrsh7th/nvim-cmp/pull/1094
        config = function()
            require("cfg.cmp")
        end,
        event = "InsertEnter",
        dependencies = {
            "neovim/nvim-lspconfig",

            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-nvim-lsp-document-symbol",
            "hrsh7th/cmp-nvim-lsp",

            "hrsh7th/cmp-buffer",

            "FelipeLema/cmp-async-path",
            "hrsh7th/cmp-omni",
            "hrsh7th/cmp-cmdline",
            "f3fora/cmp-spell",
            "saadparwaiz1/cmp_luasnip",

            -- specialty
            {
                "KadoBOT/cmp-plugins",
                opts = {
                    files = { "$XDG_CONFIG_HOME/nvim/plugins" }, -- default
                },
            },
            "hrsh7th/cmp-nvim-lua",
        },
        keys = {
            { ":", mode = { "n", "v" } }, -- also trigger on cmdline
        },
    },

    -- {
    --     "jcdickinson/codeium.nvim",
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --         "hrsh7th/nvim-cmp",
    --     },
    --     config = true,
    -- },
}
