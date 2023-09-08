require("nvim-treesitter.configs").setup {
    highlight = {
        enable = true,
        custom_captures = {
            -- Highlight the @foo
        },
        -- Setting this to true or a list of languages will run `:h syntax` and tree-sitter at the same time.
        additional_vim_regex_highlighting = false,
        disable = function(_, bufnr)
            local ft = vim.bo[bufnr].filetype
            if ft == "tex" then
                return true
            end

            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(bufnr))
            if ok and stats and stats.size > max_filesize then
                return true
            end
            return false
        end,
    },
    -- refactor = { -- TODO: Reanble when fixed.
    --     highlight_definitions = {
    --         enable = true,
    --         -- Set to false if you have an `updatetime` of ~100.
    --         clear_on_cursor_move = true,
    --     },
    --     navigation = {
    --         enable = true,
    --         keymaps = {
    --             goto_next_usage = "<c-n>",
    --             goto_previous_usage = "<c-p>",
    --         },
    --     },
    -- },
    indent = {
        enable = false,
    },
    textsubjects = {
        enable = false,
        prev_selection = ",", -- (Optional) keymap to select the previous selection
        keymaps = {
            ["."] = "textsubjects-smart",
            [";"] = "textsubjects-container-outer",
            ["i;"] = "textsubjects-container-inner",
        },
    },
    textobjects = {
        select = {
            enable = true,
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["ag"] = "@comment.outer",
                ["il"] = "@loop.inner",
                ["al"] = "@loop.outer",
                ["ia"] = "@parameter.inner",
                ["aa"] = "@parameter.outer",
                ["aC"] = "@call.outer",
                ["iC"] = "@call.inner",
                ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
            },
            selection_modes = {
                ["@parameter.outer"] = "v", -- charwise
                ["@function.outer"] = "V", -- linewise
                ["@class.outer"] = "<c-v>", -- blockwise
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["]f"] = "@function.outer",
                ["]o"] = "@loop.*",
                -- ["]]"] = "@class.outer",
                ["]]"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
            },
            goto_next_end = {
                ["]F"] = "@function.outer",
            },
            goto_previous_start = {
                ["[f"] = "@function.outer",
                ["[["] = { query = "@scope", query_group = "locals", desc = "Prev scope" },
                -- ["[["] = "@class.outer",
            },
            goto_previous_end = {
                ["[F"] = "@function.outer",
            },
        },
        lsp_interop = {
            enable = true,
            border = "rounded",
            peek_definition_code = {
                ["<leader><C-]>"] = "@function.outer",
                ["<leader><leader><C-]>"] = "@class.outer",
            },
        },
    },
    matchup = {
        enable = true,
        include_match_words = true,
    },
    autotag = {
        enable = true,
    },
    playground = { enable = false },
}

-- vim: foldmethod=marker foldmarker={,}
