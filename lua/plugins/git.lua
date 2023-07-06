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

                -- Text object
                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "inner hunk" })
            end,
        },
    },

    {
        "sindrets/diffview.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        opts = {
            enhanced_diff_hl = true,
            default_args = {
                DiffviewOpen = { "--imply-local" },
            },
            keymaps = {
                file_panel = {
                    { "n", "c", "<cmd>Neogit commit<cr>", { desc = "Commit..." } },
                    { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close" } },
                },
                file_history_panel = {
                    { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close" } },
                },
            },
        },
    },

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
        end,
    },
    {
        "TimUntersberger/neogit",
        url = "https://github.com/tobealive/neogit.git",
        branch = "fix-noice-commit-confirm-message",
        dependencies = "nvim-lua/plenary.nvim",
        opts = {
            kind = "split",
            integrations = {
                diffview = true,
            },
            signs = {
                -- { CLOSED, OPENED }
                section = { "", "" },
                item = { "", "" },
                hunk = { "", "" },
            },
            commit_popup = {
                kind = "split",
                commit_confirmation = {
                    enabled = false,
                    close_on_deny = false,
                },
                start_insert_on_commit = true,
            },
        },
        lazy = true,
        cmd = "Neogit",
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
                mappings = nil, -- this doesn't work
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
                },
            }
            vim.keymap.del("n", "<leader>gy", {}) -- so we just remove it here
        end,
    },

    {
        "pwntester/octo.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            enable_builtin = true,
        },
        config = true,
        cmd = { "Octo" },
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

    --- }}}
}
