return {
    {
        "saghen/blink.cmp",
        -- optional: provides snippets for the snippet source
        dependencies = {
            { "L3MON4D3/LuaSnip", version = "v2.*" },
            { "Kaiser-Yang/blink-cmp-dictionary" },
            { "ribru17/blink-cmp-spell" },
        },
        version = "*",
        init = function()
            vim.keymap.set("i", "<C-x><C-o>", function()
                require("blink.cmp").show()
                require("blink.cmp").show_documentation()
                require("blink.cmp").hide_documentation()
            end, { silent = false, desc = "Omni complete [blink]" })

            vim.keymap.set("i", "<C-x><C-s>", function()
                require("blink.cmp").show { providers = { "spell" } }
            end, { silent = false, desc = "Spell complete [blink]" })

            vim.keymap.set("i", "<C-x>s", function()
                require("blink.cmp").show { providers = { "spell" } }
            end, { silent = false, desc = "Spell complete [blink]" })

            vim.keymap.set("i", "<C-x><C-i>", function()
                require("blink.cmp").show { providers = { "rg" } }
            end, { silent = false, desc = "rg complete [blink]" })

            vim.keymap.set("i", "<C-x><C-k>", function()
                require("blink.cmp").show { providers = { "dictionary" } }
            end, { silent = false, desc = "Dictionary complete [blink]" })

            vim.keymap.set("i", "<C-x><C-p>", function()
                require("blink.cmp").show { providers = { "path" } }
            end, { silent = false, desc = "Path complete [blink]" })
        end,
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = {
                preset = "default",
            },
            snippets = {
                expand = function(snippet)
                    require("luasnip").lsp_expand(snippet)
                end,
                active = function(filter)
                    if filter and filter.direction then
                        return require("luasnip").jumpable(filter.direction)
                    end
                    return require("luasnip").in_snippet()
                end,
                jump = function(direction)
                    require("luasnip").jump(direction)
                end,
            },
            appearance = {
                -- Sets the fallback highlight groups to nvim-cmp's highlight groups
                -- Useful for when your theme doesn't support blink.cmp
                -- Will be removed in a future release
                use_nvim_cmp_as_default = false,
                -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = "mono",
            },
            completion = {
                accept = { auto_brackets = { enabled = true } },
                documentation = { auto_show = true, auto_show_delay_ms = 500 },
                ghost_text = { enabled = false },
                menu = {
                    draw = {
                        treesitter = { "lsp" },
                    },
                },
            },
            fuzzy = {
                sorts = {
                    function(a, b)
                        local sort = require("blink.cmp.fuzzy.sort")
                        if a.source_id == "spell" and b.source_id == "spell" then
                            return sort.label(a, b)
                        end
                    end,
                    "score", -- First what we searched for
                    "sort_text", -- This is the good one. Ensures functions > methods.
                    "kind", -- This is just for consistency
                },
            },
            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { "lsp" },
                providers = {
                    spell = {
                        name = "Spell",
                        module = "blink-cmp-spell",
                        opts = {
                            max_entries = 12,
                        },
                    },
                    dictionary = {
                        module = "blink-cmp-dictionary",
                        name = "Dict",
                        --- @module 'blink-cmp-dictionary'
                        --- @type blink-cmp-dictionary.Options
                        opts = {
                            get_command = {
                                "rg", -- make sure this command is available in your system
                                "--color=never",
                                "--no-line-number",
                                "--no-messages",
                                "--no-filename",
                                "--ignore-case",
                                "--",
                                "${prefix}", -- this will be replaced by the result of 'get_prefix' function
                                vim.fn.expand("/usr/share/dict/words"), -- where you dictionary is
                            },
                            documentation = {
                                enable = true, -- enable documentation to show the definition of the word
                                get_command = {
                                    "wn", -- make sure this command is available in your system
                                    "${word}", -- this will be replaced by the word to search
                                    "-over",
                                },
                            },
                        },
                    },
                },
            },
            signature = { enabled = true },
        },
        opts_extend = { "sources.default" },
    },
}
