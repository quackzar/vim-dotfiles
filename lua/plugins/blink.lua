return {
    {
        "saghen/blink.compat",
        -- use the latest release, via version = '*', if you also use the latest release for blink.cmp
        version = "*",
        -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
        lazy = true,
        -- make sure to set opts so that lazy.nvim calls blink.compat's setup
        opts = {
            impersonate_nvim_cmp = true,
        },
    },
    {
        "saghen/blink.cmp",
        -- optional: provides snippets for the snippet source
        dependencies = {
            { "L3MON4D3/LuaSnip", version = "v2.*" },
            { "Kaiser-Yang/blink-cmp-dictionary" },
        },

        -- use a release tag to download pre-built binaries
        version = "*",
        -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
        -- build = 'cargo build --release',
        -- If you use nix, you can build from source using latest nightly rust with:
        -- build = 'nix run .#build-plugin',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = {
                preset = "default",
                ["<C-x><C-o>"] = {
                    function(cmp)
                        cmp.show()
                    end,
                },
                ["<C-x><C-i>"] = {
                    function(cmp)
                        cmp.show { providers = { "rg" } }
                    end,
                },
                ["<C-x><C-k>"] = {
                    function(cmp)
                        cmp.show { providers = { "dictionary" } }
                    end,
                },
                ["<C-x><C-s>"] = {
                    function(cmp)
                        cmp.show { providers = { "spell" } }
                    end,
                },
                ["<C-x>s"] = {
                    function(cmp)
                        cmp.show { providers = { "spell" } }
                    end,
                },
                ["<C-x><C-p>"] = {
                    function(cmp)
                        cmp.show { providers = { "path" } }
                    end,
                },
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
                use_nvim_cmp_as_default = true,
                -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = "mono",
            },
            completion = {
                documentation = { auto_show = true, auto_show_delay_ms = 500 },
                ghost_text = { enabled = false },
                menu = {
                    draw = {
                        treesitter = { "lsp" },
                    },
                },
            },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { "lsp", "snippets" },
                providers = {
                    spell = {
                        name = "spell",
                        module = "blink.compat.source",
                        opts = {
                            keep_all_entries = true,
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
