require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        custom_captures = {
            -- Highlight the @foo
        },
        -- Setting this to true or a list of languages will run `:h syntax` and tree-sitter at the same time.
        additional_vim_regex_highlighting = false,
        disable = { "tex", "latex" },
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        },
    },
    refactor = {
        highlight_definitions = { enable = true },
        smart_rename = {
            enable = true,
            keymaps = {
                smart_rename = "grr",
            },
        },
    },
    indent = {
        enable = true
    },
    textsubjects = {
        enable = true,
        prev_selection = ',', -- (Optional) keymap to select the previous selection
        keymaps = {
            ['.'] = 'textsubjects-smart',
            [';'] = 'textsubjects-container-outer',
            ['i;'] = 'textsubjects-container-inner',
        }
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
                ["ig"] = "@comment.inner",
                ["ag"] = "@comment.outer",
                ["il"] = "@loop.inner",
                ["al"] = "@loop.outer",
                ["ia"] = "@parameter.inner",
                ["aa"] = "@parameter.outer",
                ["aC"] = "@call.outer",
                ["iC"] = "@call.inner",
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ["g>"] = "@swappable",
            },
            swap_previous = {
                ["g<"] = "@swappable",
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer",
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
            },
        },
        lsp_interop = {
            enable = true,
            border =    'rounded',
            peek_definition_code = {
                ["<leader>df"] = "@function.outer",
                ["<leader>dF"] = "@class.outer",
            },
        },
    },
    matchup = {
        enable = true,
    },
    playground = {enable = true},
}

require'which-key'.register({
    -- ['v.'] = 'Textsubject smart',
    -- ['v;'] = 'Textsubject outer container',
    [']m'] = 'Go to next function start',
    [']]'] = 'Go to next class start',
    [']M'] = 'Go to next function end',
    [']['] = 'Go to next class end',
    ['[m'] = 'Go to previous function start',
    ['[]'] = 'Go to previous class start',
    ['[M'] = 'Go to previous function end',
    ['[['] = 'Go to previous class end',
    ['g'] = {
        ['<'] = 'Swap previous parameter',
        ['>'] = 'Swap next parameter',
        ['nn'] = 'Init incr. selection',
        ['rn'] = 'Node increment',
        ['rc'] = 'Scope increment',
        ['rm'] = 'Node decrement',
        ['rr'] = 'Smart rename (TS)',
    }
}, {})
-- vim: foldmethod=marker foldmarker={,}
