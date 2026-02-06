return {
    -- Version Control and Git {{{
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        opts = {
            signs = {
                add = { text = "🮇" },
                change = { text = "🮇" },
                delete = {
                    text = "◢",
                    show_count = false,
                },
                topdelete = {
                    text = "◥",
                    show_count = false,
                },
                changedelete = { text = "🮇" },
                untracked = { text = " " },
            },
            signs_staged = {
                add = { text = "🮇" },
                change = { text = "🮇" },
                delete = { text = "◢" },
                topdelete = { text = "◥" },
                changedelete = { text = "🮇" },
                untracked = { text = " " },
            },
            count_chars = { "¹", "²", "³", "⁴", "⁵", "⁶", "⁷", "⁸", "⁹", ["+"] = "⁺" },
            signs_staged_enable = true,
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
            diff_opts = {
                vertical = false,
            },
            preview_config = {
                border = { "╔", "═", "╗", "║", "╝", "═", "╚", "║" },
            },
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
                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "inner hunk", silent = true })
            end,
        },
    },

    {
        "sindrets/diffview.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        cmd = { "DiffviewFileHistory", "DiffviewOpen", "DiffviewLog" },
        init = function()
            vim.opt.fillchars:append("diff:╱")

            if vim.fn.executable("nvr") == 1 then
                local nvr = "nvr --servername " .. vim.v.servername .. " "
                vim.env.GIT_EDITOR = nvr .. "-cc split +'setl bh=delete' --remote-wait"
                vim.env.EDITOR = nvr .. "-l --remote" -- (Optional)
                vim.env.VISUAL = nvr .. "-l --remote" -- (Optional)
            end
        end,
        opts = {
            enhanced_diff_hl = true,
            default_args = {
                DiffviewOpen = { "--imply-local" },
            },
            view = {
                merge_tool = {
                    layout = "diff4_mixed",
                },
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
        "isakbm/gitgraph.nvim",
        lazy = true,
        dependencies = { "sindrets/diffview.nvim" },
        ---@type I.GGConfig
        opts = {
            hooks = {
                -- Check diff of a commit
                on_select_commit = function(commit)
                    vim.notify("DiffviewOpen " .. commit.hash .. "^!")
                    vim.cmd(":DiffviewOpen " .. commit.hash .. "^!")
                end,
                -- Check diff from commit a -> commit b
                on_select_range_commit = function(from, to)
                    vim.notify("DiffviewOpen " .. from.hash .. "~1.." .. to.hash)
                    vim.cmd(":DiffviewOpen " .. from.hash .. "~1.." .. to.hash)
                end,
            },
        },
    },

    {
        "akinsho/git-conflict.nvim",
        version = "*",
        event = "BufEnter",
        opts = {
            default_commands = false,
            default_mappings = false,
            disable_diagnostics = true,
            highlights = { -- They must have background color, otherwise the default color will be used
                incoming = "DiffText",
                current = "DiffAdd",
            },
        },
        -- init = function()
        --     vim.keymap.set("n", "co", "<Plug>(git-conflict-ours)")
        --     vim.keymap.set("n", "ct", "<Plug>(git-conflict-theirs)")
        --     vim.keymap.set("n", "cb", "<Plug>(git-conflict-both)")
        --     vim.keymap.set("n", "c0", "<Plug>(git-conflict-none)")
        --     vim.keymap.set("n", "[x", "<Plug>(git-conflict-prev-conflict)")
        --     vim.keymap.set("n", "]x", "<Plug>(git-conflict-next-conflict)")
        -- end,
    },
    {
        "NeogitOrg/neogit",
        dependencies = "nvim-lua/plenary.nvim",
        opts = {
            disable_commit_confirmation = true,
            disable_insert_on_commit = "auto",
            kind = "split",
            integrations = {
                diffview = true,
            },
            graph_style = "unicode",
            process_spinner = false,
            signs = {
                -- { CLOSED, OPENED }
                section = { "", "" },
                item = { "", "" },
                hunk = { "", "" },
            },
        },
        lazy = true,
        cmd = "Neogit",
        init = function()
            vim.api.nvim_create_augroup("neogit-additions", {})
            vim.api.nvim_create_autocmd("FileType", {
                group = "neogit-additions",
                pattern = "NeogitCommitMessage",
                command = "silent! set filetype=gitcommit",
            })
        end,
    },

    {
        "ruifm/gitlinker.nvim",
        lazy = true,
        enabled = false,
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
        "trevorhauter/gitportal.nvim",
        opts = {
            always_include_current_line = true,
        },
    },

    {
        "nvim-mini/mini-git",
        version = false,
    },

    {
        "lewis6991/satellite.nvim",
        enabled = false, -- vim.fn.has("nvim-0.10") == 1,
        event = "BufRead",
        opts = {
            current_only = true,
            handlers = {
                marks = {
                    enable = true,
                    show_builtins = true,
                },
                diagnostic = {
                    --signs = { '⠐','⠨', '⠸'}
                    signs = { "᎐", "᎓", "፧" },
                },
                gitsigns = {
                    enable = true,
                    signs = { -- can only be a single character (multibyte is okay)
                        add = "│",
                        change = "│",
                        delete = "⏴",
                    },
                },
                --
            },
        },
    },

    --- }}}
}
