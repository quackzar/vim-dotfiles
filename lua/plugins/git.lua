return {
    -- Version Control and Git {{{
    "tpope/vim-fugitive",
    {
        "lewis6991/gitsigns.nvim",
        lazy = false,
        opts = {
            signs = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "◢" },
                topdelete = { text = "◥" },
                changedelete = { text = "▎" },
            },
            numhl = false,
            linehl = false,
            watch_gitdir = {
                interval = 1000,
                follow_files = true,
            },
            sign_priority = 6,
            current_line_blame_opts = {
                virt_text_pos = "right_align",
            },
            update_debounce = 100,
            status_formatter = nil, -- Use default
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map("n", "]c", function()
                    if vim.wo.diff then
                        return "]c"
                    end
                    vim.schedule(function()
                        gs.next_hunk()
                    end)
                    return "<Ignore>"
                end, { expr = true, desc = "next hunk" })

                map("n", "[c", function()
                    if vim.wo.diff then
                        return "[c"
                    end
                    vim.schedule(function()
                        gs.prev_hunk()
                    end)
                    return "<Ignore>"
                end, { expr = true, desc = "prev hunk" })

                -- Actions
                -- map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", { desc = "stage hunk" })
                -- map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", { desc = "reset hunk" })

                -- Text object
                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "inner hunk" })
            end,
        },
    },

    { "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" },

    {
        "akinsho/git-conflict.nvim",
        version = "*",
        config = function()
            require("git-conflict").setup {
                default_mappings = true, -- disable buffer local mapping created by this plugin
                disable_diagnostics = true, -- This will disable the diagnostics in a buffer whilst it is conflicted
                highlights = { -- They must have background color, otherwise the default color will be used
                    incoming = "DiffText",
                    current = "DiffAdd",
                },
            }
            -- vim.api.nvim_create_autocmd("User", {
            --     pattern = "GitConflictDetected",
            --     callback = function()
            --         local conflict = require("git-conflict")
            --         -- vim.notify('Conflict detected in '..vim.fn.expand('<afile>'))
            --         vim.keymap.set("n", "cww", function()
            --             conflict.engage.conflict_buster()
            --             conflict.create_buffer_local_mappings()
            --         end)
            --     end,
            -- })
        end,
    },
    {
        "TimUntersberger/neogit",
        dependencies = "nvim-lua/plenary.nvim",
        opts = {
            kind = "split",
            integrations = {
                diffview = true,
            },
        },
        lazy = true,
        cmd = "Neogit",
        -- keys = {
        --     { "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit" },
        --     { "<leader>gl", "<cmd>Neogit log<cr>", desc = "Neogit log" },
        --     { "<leader>gc", "<cmd>Neogit commit<cr>", desc = "Neogit commit" },
        -- },
    },

    {
        "f-person/git-blame.nvim",
        init = function()
            vim.g.gitblame_enabled = 0
        end,
    },

    {
        "ruifm/gitlinker.nvim",
        config = function()
            require("gitlinker").setup {
                callbacks = {
                    ["github.com"] = require("gitlinker.hosts").get_github_type_url,
                    ["gitlab.com"] = require("gitlinker.hosts").get_gitlab_type_url,
                    ["try.gitea.io"] = require("gitlinker.hosts").get_gitea_type_url,
                    ["codeberg.org"] = require("gitlinker.hosts").get_gitea_type_url,
                    ["bitbucket.org"] = require("gitlinker.hosts").get_bitbucket_type_url,
                    ["try.gogs.io"] = require("gitlinker.hosts").get_gogs_type_url,
                    ["git.sr.ht"] = require("gitlinker.hosts").get_srht_type_url,
                    ["git.launchpad.net"] = require("gitlinker.hosts").get_launchpad_type_url,
                    ["repo.or.cz"] = require("gitlinker.hosts").get_repoorcz_type_url,
                    ["git.kernel.org"] = require("gitlinker.hosts").get_cgit_type_url,
                    ["git.savannah.gnu.org"] = require("gitlinker.hosts").get_cgit_type_url,
                    ["git.fish.princh.com"] = require("gitlinker.hosts").get_gitlab_type_url,
                },
            }
        end,
    },

    {
        "lewis6991/satellite.nvim",
        enabled = false,
        event = "BufRead",
        opts = {
            current_only = true,
            handlers = {
                marks = {
                    enable = true,
                    show_builtins = true,
                },
            },
        },
    },

    -- { 'petertriho/nvim-scrollbar',
    --     config = function()
    --         require("scrollbar").setup()
    --     end
    -- },

    --- }}}
}
