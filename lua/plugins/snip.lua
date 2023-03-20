return {
    {
        "L3MON4D3/LuaSnip",
        config = function()
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

    {
        "ziontee113/SnippetGenie",
        lazy = true,
        keys = { { "<c-s><c-q>", mode = { "v", "x" } } },
        config = function()
            local genie = require("SnippetGenie")

            genie.setup {
                -- SnippetGenie will use this regex to find the pattern in your snippet file,
                -- and insert the newly generated snippet there.
                regex = [[-\+ Snippets goes here]],
                -- A line that matches this regex looks like:
                ------------------------------------------------ Snippets goes here

                -- this must be configured
                snippets_directory = vim.fn.stdpath("config") .. "/lua/snippets",
                file_name = "generated",

                -- SnippetGenie was designed to generate LuaSnip's `fmt()` snippets.
                -- here you can configure the generated snippet's "skeleton" / "template" according to your use case
                snippet_skeleton = [[
s(
    "{trigger}",
    fmt([=[
{body}
]=], {{
        {nodes}
    }})
),
]],
            }

            -- SnippetGenie doesn't map any keys by default.
            -- Here're the suggested mappings:
            vim.keymap.set({ "x", "v" }, "<c-s><c-q>", function()
                genie.create_new_snippet_or_add_placeholder()
                vim.cmd("norm! �") -- exit Visual Mode, go back to Normal Mode
            end, { desc = "New snippet" })

            vim.keymap.set({ "n", "x", "v" }, "<c-s><c-x>", function()
                genie.finalize_snippet()
            end, { desc = "Finalize snippet" })

            vim.keymap.set({ "n", "v", "x" }, "<c-s>", "<nop>", {})
        end,
    },
}