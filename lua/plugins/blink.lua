return {
    {
        "saghen/blink.cmp",
        -- optional: provides snippets for the snippet source
        dependencies = {
            { "L3MON4D3/LuaSnip", version = "v2.*" },
            { "ribru17/blink-cmp-spell" },
            { "archie-judd/blink-cmp-words" },
            { "xzbdmw/colorful-menu.nvim" },
            { "krissen/blink-cmp-bibtex" },
        },
        version = "*",
        init = function()
            vim.keymap.set("i", "<C-x><C-o>", function()
                require("blink.cmp").show()
            end, { silent = false, desc = "Lsp complete [blink]" })

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
            vim.keymap.set("i", "<C-x><C-t>", function()
                require("blink.cmp").show { providers = { "thesaurus" } }
            end, { silent = false, desc = "Dictionary complete [blink]" })
            vim.keymap.set("i", "<C-x><C-t>", function()
                require("blink.cmp").show { providers = { "bibtex" } }
            end, { silent = false, desc = "BibTeX complete [blink]" })
            vim.keymap.set("i", "<C-x><C-p>", function()
                require("blink.cmp").show { providers = { "path" } }
            end, { silent = false, desc = "Path complete [blink]" })
        end,
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = {
                preset = "none",
                ["<C-e>"] = { "hide" },
                ["<C-y>"] = { "select_and_accept" },
                ["<Up>"] = { "select_prev", "fallback" },
                ["<Down>"] = { "select_next", "fallback" },
                ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
                ["<C-n>"] = { "select_next", "fallback_to_mappings" },

                ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
                ["<C-b>"] = { "scroll_documentation_up", "fallback" },
                ["<C-f>"] = { "scroll_documentation_down", "fallback" },

                ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
                ["<C-u>"] = { "scroll_signature_up", "fallback" },
                ["<C-d>"] = { "scroll_signature_down", "fallback" },
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
                trigger = {
                    show_on_trigger_character = true,
                    show_on_keyword = true,
                },
                list = {
                    selection = {
                        preselect = false,
                        auto_insert = false,
                    },
                },
                accept = { auto_brackets = { enabled = true } },
                documentation = { auto_show = false, auto_show_delay_ms = 500 },
                ghost_text = {
                    enabled = true,
                    show_with_menu = true,
                },
                menu = {
                    auto_show = true,
                    draw = {
                        -- NOTE: uses colorful-menu.nvim
                        columns = { { "kind_icon" }, { "label", gap = 1 } },
                        components = {
                            label = {
                                text = function(ctx)
                                    return require("colorful-menu").blink_components_text(ctx)
                                end,
                                highlight = function(ctx)
                                    return require("colorful-menu").blink_components_highlight(ctx)
                                end,
                            },
                        },
                        -- columns = {
                        --     { "kind_icon", "label", "label_description", gap = 1 }, { "kind" },
                        -- },
                        -- treesitter = { "lsp" },
                    },
                },
            },
            fuzzy = {
                implementation = "rust",
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
                default = { "lsp", "snippets", "buffer" },
                providers = {
                    spell = {
                        name = "Spell",
                        module = "blink-cmp-spell",
                        opts = {
                            max_entries = 12,
                            keep_all_entries = true,
                            use_cmp_spell_sorting = false,
                        },
                    },
                    dictionary = {
                        name = "blink-cmp-words",
                        module = "blink-cmp-words.dictionary",
                        -- All available options
                        opts = {
                            -- The number of characters required to trigger completion.
                            -- Set this higher if completion is slow, 3 is default.
                            dictionary_search_threshold = 3,

                            -- See above
                            score_offset = 0,

                            -- See above
                            pointer_symbols = { "!", "&", "^" },
                        },
                    },
                    thesaurus = {
                        name = "blink-cmp-words",
                        module = "blink-cmp-words.thesaurus",
                        -- All available options
                        opts = {
                            -- A score offset applied to returned items.
                            -- By default the highest score is 0 (item 1 has a score of -1, item 2 of -2 etc..).
                            score_offset = 0,

                            -- Default pointers define the lexical relations listed under each definition,
                            -- see Pointer Symbols below.
                            -- Default is as below ("antonyms", "similar to" and "also see").
                            pointer_symbols = { "!", "&", "^" },
                        },
                    },
                    bibtex = {
                        module = "blink-cmp-bibtex",
                        name = "BibTeX",
                        min_keyword_length = 2,
                        score_offset = 10,
                        async = true,
                    },
                },
            },
            signature = { enabled = true },
        },
        opts_extend = { "sources.default" },
    },
}
