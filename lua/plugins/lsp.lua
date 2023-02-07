return {

    -- LSP + Snippets {{{
    {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "jayp0521/mason-nvim-dap.nvim",
        "jayp0521/mason-null-ls.nvim",
        "neovim/nvim-lspconfig",
    },

    "weilbith/nvim-code-action-menu",
    "kosayoda/nvim-lightbulb",

    {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = true,
    },

    {
        "folke/trouble.nvim",
        opts = {
            use_diagnostic_signs = true,
        },
        keys = {
            { "<leader>xx", "<cmd>TroubleToggle<cr>", desc = "toggle trouble" },
            { "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>" },
            { "<leader>xd", "<cmd>Trouble document_diagnostics<cr>" },
            { "<leader>xl", "<cmd>Trouble loclist<cr>" },
            { "<leader>xq", "<cmd>Trouble quickfix<cr>" },
            { "<leader>xc", "<cmd>TroubleClose<cr>" },
            { "gR", "<cmd>Trouble lsp_references<cr>" },
        },
    },

    -- { 'Issafalcon/lsp-overloads.nvim'},
    "ray-x/lsp_signature.nvim",

    {
        "WhoIsSethDaniel/toggle-lsp-diagnostics.nvim",
        config = function()
            require("toggle_lsp_diagnostics").init()
        end,
    },

    "jose-elias-alvarez/null-ls.nvim",

    {
        "stevearc/aerial.nvim",
        opts = {
            backends = { "treesitter", "lsp", "markdown", "man" },
            layout = {
                placement = "edge",
            },
            on_attach = function(bufnr)
                vim.keymap.set("n", "[[", "<cmd>AerialPrev<CR>", { buffer = bufnr })
                vim.keymap.set("n", "]]", "<cmd>AerialNext<CR>", { buffer = bufnr })
            end,
        },
        keys = {
            { "<leader>v", "<cmd>AerialToggle!<CR>", desc = "Toggle Aerial" },
            { "<leader>V", "<cmd>AerialOpen<CR>", desc = "Aerial Focus" },
        },
    },

    { "onsails/lspkind-nvim" },

    {
        "L3MON4D3/LuaSnip",
        config = function()
            require("cfg.luasnip")
            require("luasnip.loaders.from_vscode").lazy_load()
            require("luasnip.loaders.from_snipmate").lazy_load()
        end,
        dependencies = { "rafamadriz/friendly-snippets" },
        event = "InsertEnter",
    },

    {
        "jackMort/ChatGPT.nvim",
        config = true,
        cmd = { "ChatGPT", "ChatGPTActAs", "ChatGPTEditWithInstructions", "ChatGPTRun", "ChatGPTRunCustomCodeAction" },
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
    },

    {
        "utilyre/barbecue.nvim",
        enabled = false, -- currently winbar is buggy, see https://github.com/utilyre/barbecue.nvim/issues/61
        name = "barbecue",
        version = "*",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
        opts = {
            -- configurations go here
        },
    },

    -- }}}
}
