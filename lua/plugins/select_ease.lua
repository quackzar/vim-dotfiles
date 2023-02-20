return {
    "ziontee113/SelectEase",
    keys = { "<C-Q>", mode = { "n", "i", "v" } },
    config = function()
        local select_ease = require("SelectEase")

        -- For more language support check the `Queries` section
        local lua_query = [[
            ;; query
            ((identifier) @cap)
            ("string_content" @cap)
            ((true) @cap)
            ((false) @cap)
        ]]
        local python_query = [[
            ;; query
            ((identifier) @cap)
            ((string) @cap)
        ]]
        local rust_query = [[
            ;; query
            ((boolean_literal) @cap)
            ((string_literal) @cap)

            ; Identifiers
            ((identifier) @cap)
            ((field_identifier) @cap)
            ((field_expression) @cap)
            ((scoped_identifier) @cap)
            ((unit_expression) @cap)

            ; Types
            ((reference_type) @cap)
            ((primitive_type) @cap)
            ((type_identifier) @cap)
            ((generic_type) @cap)

            ; Calls
            ((call_expression) @cap)
        ]]
        local c_query = [[
            ;; query
            ((string_literal) @cap)
            ((system_lib_string) @cap)

            ; Identifiers
            ((identifier) @cap)
            ((struct_specifier) @cap)
            ((type_identifier) @cap)
            ((field_identifier) @cap)
            ((number_literal) @cap)
            ((unary_expression) @cap)
            ((pointer_declarator) @cap)

            ; Types
            ((primitive_type) @cap)

            ; Expressions
            (assignment_expression
             right: (_) @cap)
        ]]
        local cpp_query = [[
            ;; query

            ; Identifiers
            ((namespace_identifier) @cap)
        ]] .. c_query

        local go_query = [[
            ;; query
            ((selector_expression) @cap) ; Method call
            ((field_identifier) @cap) ; Method names in interface

            ; Identifiers
            ((identifier) @cap)
            ((expression_list) @cap) ; pseudo Identifier
            ((int_literal) @cap)
            ((interpreted_string_literal) @cap)

            ; Types
            ((type_identifier) @cap)
            ((pointer_type) @cap)
            ((slice_type) @cap)

            ; Keywords
            ((true) @cap)
            ((false) @cap)
            ((nil) @cap)
        ]]

        local queries = {
            lua = lua_query,
            python = python_query,
            rust = rust_query,
            c = c_query,
            cpp = cpp_query,
        }

        vim.keymap.set({ "n", "s", "i" }, "<C-Q>k", function()
            select_ease.select_node {
                queries = queries,
                direction = "previous",
                vertical_drill_jump = true,
                -- visual_mode = true, -- if you want Visual Mode instead of Select Mode
                fallback = function()
                    -- if there's no target, this function will be called
                    select_ease.select_node { queries = queries, direction = "previous" }
                end,
            }
        end, { desc = "select node up" })
        vim.keymap.set({ "n", "s", "i" }, "<C-Q>j>", function()
            select_ease.select_node {
                queries = queries,
                direction = "next",
                vertical_drill_jump = true,
                -- visual_mode = true, -- if you want Visual Mode instead of Select Mode
                fallback = function()
                    -- if there's no target, this function will be called
                    select_ease.select_node { queries = queries, direction = "next" }
                end,
            }
        end, { desc = "select node down" })

        vim.keymap.set({ "n", "s", "i" }, "<C-Q>h", function()
            select_ease.select_node {
                queries = queries,
                direction = "previous",
                current_line_only = true,
                -- visual_mode = true, -- if you want Visual Mode instead of Select Mode
            }
        end, { desc = "select node back" })
        vim.keymap.set({ "n", "s", "i" }, "<C-Q>l", function()
            select_ease.select_node {
                queries = queries,
                direction = "next",
                current_line_only = true,
                -- visual_mode = true, -- if you want Visual Mode instead of Select Mode
            }
        end, { desc = "select node" })

        -- previous / next node that matches query
        vim.keymap.set({ "n", "s", "i" }, "<C-Q>p", function()
            select_ease.select_node { queries = queries, direction = "previous" }
        end, { desc = "prev. node" })
        vim.keymap.set({ "n", "s", "i" }, "<C-Q>n", function()
            select_ease.select_node { queries = queries, direction = "next" }
        end, { desc = "next node" })

        -- Swap Nodes
        vim.keymap.set({ "n", "s", "i" }, "<C-Q>K", function()
            select_ease.swap_nodes {
                queries = queries,
                direction = "previous",
                vertical_drill_jump = true,

                -- swap_in_place option. Default behavior is cursor will jump to target after the swap
                -- jump_to_target_after_swap = false --> this will keep cursor in place after the swap
            }
        end, { desc = "Swap prev. vert. drill jump" })
        vim.keymap.set({ "n", "s", "i" }, "<C-Q>J", function()
            select_ease.swap_nodes {
                queries = queries,
                direction = "next",
                vertical_drill_jump = true,
            }
        end, { desc = "Swap next vert. drill jump" })
        vim.keymap.set({ "n", "s", "i" }, "<C-Q>H", function()
            select_ease.swap_nodes {
                queries = queries,
                direction = "previous",
                current_line_only = true,
            }
        end, { desc = "swap nodes next previous" })
        vim.keymap.set({ "n", "s", "i" }, "<C-Q>L", function()
            select_ease.swap_nodes {
                queries = queries,
                direction = "next",
                current_line_only = true,
            }
        end, { desc = "swap nodes next current" })
        vim.keymap.set({ "n", "s", "i" }, "<C-Q>P", function()
            select_ease.swap_nodes { queries = queries, direction = "previous" }
        end, { desc = "swap prev node" })
        vim.keymap.set({ "n", "s", "i" }, "<C-Q>N", function()
            select_ease.swap_nodes { queries = queries, direction = "next" }
        end, { desc = "swap next node" })
    end,
}
