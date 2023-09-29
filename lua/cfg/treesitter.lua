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
    incremental_selection = {
        enable = true,
        keymaps = {
            node_incremental = "v", -- genius mapping
            node_decremental = "<M-v>",
        },
    },
    textobjects = {
        select = {
            enable = true,
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = { query = "@function.outer", desc = "outer function" },
                ["if"] = { query = "@function.inner", desc = "inner function" },
                ["ac"] = { query = "@class.outer", desc = "outer class" },
                ["ic"] = { query = "@class.inner", desc = "inner class" },
                ["ag"] = { query = "@comment.outer", desc = "outer comment" },
                ["il"] = { query = "@loop.inner", desc = "inner loop" },
                ["al"] = { query = "@loop.outer", desc = "outer loop" },
                ["ia"] = { query = "@parameter.inner", desc = "inner parameter" },
                ["aa"] = { query = "@parameter.outer", desc = "outer parameter" },
                ["aC"] = { query = "@call.outer", desc = "outer call" },
                ["iC"] = { query = "@call.inner", desc = "inner call" },
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
                ["]f"] = { query = "@function.outer", desc = "next function" },
                ["]o"] = { query = "@loop.*", desc = "next loop" },
                -- ["]]"] = "@class.outer",
                ["]]"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
            },
            goto_next_end = {
                ["]F"] = "@function.outer",
            },
            goto_previous_start = {
                ["[f"] = { query = "@function.outer", desc = "prev function" },
                ["[o"] = { query = "@loop.*", desc = "prev loop" },
                ["[["] = { query = "@scope", query_group = "locals", desc = "Prev scope" },
                -- ["[["] = "@class.outer",
            },
            goto_previous_end = {
                ["[F"] = { query = "@function.outer", desc = "prev outside-function" },
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
