-- Syntax Tree Surfer V2 Mappings
-- Targeted Jump with virtual_text
local sts = require("syntax-tree-surfer")
vim.keymap.set("n", "<leader>sv", function() -- only jump to variable_declarations
    sts.targeted_jump { "variable_declaration" }
end, { desc = "Surf declarations" })
vim.keymap.set("n", "<leader>sf", function() -- only jump to functions
    sts.targeted_jump {
        "function",
        "arrrow_function",
        "function_definition",
    }
end, { desc = "Surf functions" })
vim.keymap.set("n", "<leader>sc", function() -- only jump to if_statements
    sts.targeted_jump {
        "if_statement",
        "else_clause",
        "else_statement",
        "elseif_statement",
        "switch_statement",
        "for_statement",
        "while_statement",
    }
end, { desc = "Surf control flow" })
vim.keymap.set("n", "<leader>ss", function() -- jump to all that you specify
    sts.targeted_jump {
        "function",
        "arrow_function",
        "if_statement",
        "else_clause",
        "else_statement",
        "elseif_statement",
        "for_statement",
        "while_statement",
        "switch_statement",
    }
end, { desc = "Surf all" })

-------------------------------
-- filtered_jump --
-- "default" means that you jump to the default_desired_types or your lastest jump types
vim.keymap.set("n", "<A-n>", function()
    sts.filtered_jump("default", true) --> true means jump forward
end, opts)
vim.keymap.set("n", "<A-p>", function()
    sts.filtered_jump("default", false) --> false means jump backwards
end, opts)

-------------------------------

-- Setup Function example:
-- These are the default options:
require("syntax-tree-surfer").setup {
    highlight_group = "LeapLabelSecondary",
    disable_no_instance_found_report = false,
    default_desired_types = {
        "function",
        "arrow_function",
        "function_definition",
        "if_statement",
        "else_clause",
        "else_statement",
        "elseif_statement",
        "for_statement",
        "while_statement",
        "switch_statement",
    },
    left_hand_side = "fdsawervcxqtzb",
    right_hand_side = "jkl;oiu.,mpy/n",
    icon_dictionary = {
        ["if_statement"] = "",
        ["else_clause"] = "",
        ["else_statement"] = "",
        ["elseif_statement"] = "",
        ["for_statement"] = "ﭜ",
        ["while_statement"] = "ﯩ",
        ["switch_statement"] = "ﳟ",
        ["function"] = "",
        ["function_definition"] = "",
        ["variable_declaration"] = "",
    },
}
