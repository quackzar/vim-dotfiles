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
        config = function()
            require("lsp_lines").setup()
        end,
    },

    {
        "folke/trouble.nvim",
        config = function()
            vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { desc = "toggle trouble" })
            vim.keymap.set("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>")
            vim.keymap.set("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>")
            vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist<cr>")
            vim.keymap.set("n", "<leader>xq", "<cmd>Trouble quickfix<cr>")
            vim.keymap.set("n", "<leader>xc", "<cmd>TroubleClose<cr>")
            vim.keymap.set("n", "gR", "<cmd>Trouble lsp_references<cr>")
            require("trouble").setup {
                use_diagnostic_signs = true,
            }
        end,
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
        config = function()
            require("aerial").setup {
                backends = { "treesitter", "lsp", "markdown", "man" },
                on_attach = function(bufnr)
                    -- Jump forwards/backwards with '{' and '}'
                    vim.keymap.set("n", "[[", "<cmd>AerialPrev<CR>", { buffer = bufnr })
                    vim.keymap.set("n", "]]", "<cmd>AerialNext<CR>", { buffer = bufnr })
                end,
            }
            vim.keymap.set("n", "<leader>v", "<cmd>AerialToggle!<CR>", { desc = "Toggle Aerial" })
        end,
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
        config = function()
            require("chatgpt").setup {
                -- optional configuration
            }
        end,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
    },

    -- }}}
}
