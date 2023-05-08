require("nvim-treesitter.configs").setup {
    highlight = {
        enable = true,
        custom_captures = {
            -- Highlight the @foo
        },
        -- Setting this to true or a list of languages will run `:h syntax` and tree-sitter at the same time.
        additional_vim_regex_highlighting = false,
        disable = { "tex", "latex", "css", "toml" },
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
        enable = true,
    },
    textsubjects = {
        enable = true,
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
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["]m"] = "@function.outer",
                -- ["]]"] = "@class.outer",
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                -- ["[["] = "@class.outer",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
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
        enable = false, -- TODO: reeanble when fixed
    },
    autotag = {
        enable = true,
    },
    playground = { enable = true },
}

-- vim: foldmethod=marker foldmarker={,}
