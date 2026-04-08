return {
    {
        "Bekaboo/dropbar.nvim",
        lazy = false, -- lazy-loading is done by the plugin itself
        opts = {
            sources = {
                lsp = {
                    max_depth = 6,
                },
                path = {
                    max_depth = 6,
                },
                treesitter = {
                    max_depth = 6,
                },
            },
            icons = {
                enable = false,
                kinds = {
                    symbols = {
                        -- Folder icons are implicit
                        Folder = "",
                    },
                },
                ui = {
                    bar = {
                        separator = " ",
                    },
                    menu = {
                        separator = " ",
                        indicator = " ",
                    },
                },
            },
        },
        config = function(_, opts)
            -- setup so it looks like `https://github.com/utilyre/barbecue.nvim`
            vim.api.nvim_create_autocmd("ColorScheme", {
                group = vim.api.nvim_create_augroup("set_dropbar_colors", { clear = true }),
                callback = function()
                    local winbar_hl = vim.api.nvim_get_hl(0, { name = "WinBar", link = false })
                    local visual_hl = vim.api.nvim_get_hl(0, { name = "Visual", link = false })
                    vim.api.nvim_set_hl(0, "DropBarFileName", { fg = visual_hl["fg"] })

                    -- Let this be a warning for the future.
                    -- You can fix colors here, but in the end
                    -- it is the colorscheme that chooses the colors.
                    vim.api.nvim_set_hl(0, "DropBarIconUISeparator", { fg = winbar_hl["fg"] })
                    --vim.api.nvim_set_hl(0, 'WinBar', { fg = conceal_hl["fg"] })
                end,
            })

            local dropbar = require("dropbar")
            local sources = require("dropbar.sources")
            local utils = require("dropbar.utils")

            local custom_path = {
                get_symbols = function(buff, win, cursor)
                    local symbols = sources.path.get_symbols(buff, win, cursor)
                    symbols[#symbols].name_hl = "DropBarFileName"
                    if vim.bo[buff].modified then
                        symbols[#symbols].name = symbols[#symbols].name .. " [+]"
                        symbols[#symbols].name_hl = "DiffAdded"
                    end
                    return symbols
                end,
            }

            opts["bar"] = {
                sources = function(buf, _)
                    if vim.bo[buf].ft == "markdown" then
                        return {
                            custom_path,
                            sources.markdown,
                        }
                    end
                    if vim.bo[buf].buftype == "terminal" then
                        return {
                            sources.terminal,
                        }
                    end
                    return {
                        custom_path,
                        utils.source.fallback {
                            sources.lsp,
                            -- sources.treesitter,
                        },
                    }
                end,
            }

            local dropbar_api = require("dropbar.api")
            vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
            vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
            vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
            require("dropbar").setup(opts)
        end,
    },
}
