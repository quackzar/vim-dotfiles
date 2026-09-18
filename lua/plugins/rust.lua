return {
    {
        "mrcjkb/rustaceanvim",
        version = "^9",
        enabled = true,
        init = function()
            local cfg = require("rustaceanvim.config")

            -- local codelldb_path = vim.env.HOME .. "/.local/share/nvim/mason/bin/codelldb"
            -- local liblldb_path = vim.env.HOME .. "/.local/share/nvim/mason/bin/liblldb"
            vim.g.rustaceanvim = {
                server = {
                    default_settings = {
                        ["rust-analyzer"] = {
                            assist = {
                                importEnforceGranularity = true,
                                importPrefix = "crate",
                            },
                            inlayHints = {
                                maxLength = 10,
                                locationLinks = true,
                                discriminantHints = true,
                                bindingModeHints = true,
                                closureReturnTypeHints = true,
                                implicitDrops = true,
                                lifetimeElisionHints = true,
                                closureCaptureHints = true,
                            },
                            diagnostics = {
                                enable = true,
                                experimental = {
                                    enable = true,
                                },
                                disabled = {
                                    "inactive_code",
                                    "unused_variables",
                                    "dead_code",
                                },
                            },
                            cargo = {
                                features = "all",
                                buildScripts = { enable = true },
                            },
                            check = {
                                allTargets = true,
                                command = "clippy",
                                workspace = true,
                            },
                            completion = {
                                fullFunctionSignatures = { enable = true },
                            },
                        },
                    },
                },
            }
        end,
    },

    -- {
    --     'cordx56/rustowl',
    --     version = '*', -- Latest stable version
    --     lazy = false,  -- This plugin is already lazy
    --     opts = {
    --         -- colors = {
    --             --     lifetime = '#98BB6C',   -- Lime green
    --             --     imm_borrow = '#A3D4D5', -- Royal blue
    --             --     mut_borrow = '#D27E99', -- Hot pink
    --             --     move = '#FFA066',       -- Orange
    --             --     call = '#E6C384',       -- Gold
    --             --     outlive = '#FF5D62',    -- Crimson
    --             -- },
    --             auto_enable = false,
    --             idle_time = 300,
    --             highlight_style = {
    --                 definitely_live = 'underline',
    --                 maybe_initialized = 'undercurl',
    --             },
    --             client = {
    --                 on_attach = function(_, buffer)
    --                     vim.keymap.set('n', '<leader>ro', function()
    --                         require('rustowl').toggle(buffer)
    --                     end, { buffer = buffer, desc = 'Toggle RustOwl' })
    --
    --                     vim.keymap.set('n', '<leader>re', function()
    --                         require('rustowl').enable(buffer)
    --                     end, { buffer = buffer, desc = 'Enable RustOwl' })
    --
    --                     vim.keymap.set('n', '<leader>rd', function()
    --                         require('rustowl').disable(buffer)
    --                     end, { buffer = buffer, desc = 'Disable RustOwl' })
    --                 end
    --             },
    --     },
    -- },

    {
        "saecki/crates.nvim",
        tag = "stable",
        event = { "BufRead Cargo.toml" },
        config = true,
    },
}
