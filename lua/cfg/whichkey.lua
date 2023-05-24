local wk = require("which-key")
wk.register {
    ["<A-1>"] = { "<Cmd>BufferLineGoToBuffer 1<CR>", "Goto buffer 1" },
    ["<A-2>"] = { "<Cmd>BufferLineGoToBuffer 2<CR>", "Goto buffer 2" },
    ["<A-3>"] = { "<Cmd>BufferLineGoToBuffer 3<CR>", "Goto buffer 3" },
    ["<A-4>"] = { "<Cmd>BufferLineGoToBuffer 4<CR>", "Goto buffer 4" },
    ["<A-5>"] = { "<Cmd>BufferLineGoToBuffer 5<CR>", "Goto buffer 5" },
    ["<A-6>"] = { "<Cmd>BufferLineGoToBuffer 6<CR>", "Goto buffer 6" },
    ["<A-7>"] = { "<Cmd>BufferLineGoToBuffer 7<CR>", "Goto buffer 7" },
    ["<A-8>"] = { "<Cmd>BufferLineGoToBuffer 8<CR>", "Goto buffer 8" },
    ["<A-9>"] = { "<Cmd>BufferLineGoToBuffer 9<CR>", "Goto buffer 9" },
}

wk.register({
    f = { "+telescope  " },
    d = { "+debug  " },
    g = { "+git  " },
    o = { "+options  " },
    b = { "+buffer 󰕸 " },
    x = { "+trouble  " },
    t = { "+test  " },
    e = { "+experiment  " },
    r = { "+refactor  " },
    p = { "+perf  " },
    n = { "+neogen (doc)" },
}, { prefix = "<leader>" })

wk.register({
    name = "Insert mode completion",
    ["<c-l>"] = "Lines",
    ["<c-n>"] = "Current file",
    ["<c-k>"] = "Dictionary",
    ["<c-t>"] = "Thesarus",
    ["<c-i>"] = "Included",
    ["<c-]>"] = "Tags",
    ["<c-f>"] = "File names",
    ["<c-d>"] = "Defintions",
    ["<c-v>"] = "Vim CMD",
    ["<c-u>"] = "User defined",
    ["<c-o>"] = "Omni",
    ["s"] = "Spell suggest",
    ["<c-z>"] = "Stop Completion",
}, { mode = "i", prefix = "<C-x>" })

wk.register({
    ["co"] = "Select ours",
    ["ct"] = "Select theirs",
    ["cb"] = "Select both",
    ["c0"] = "Select none",
    ["[x"] = "Previous Conflict",
    ["]x"] = "Next conflict",
}, { mode = "n" })

wk.register({
    name = "Show mappings",
    o = { "<cmd>WhichKey '' o<cr>", "Operators" },
    i = { "<cmd>WhichKey '' i<cr>", "Insert Mode" },
    v = { "<cmd>WhichKey '' v<cr>", "Visual Mode" },
    n = { "<cmd>WhichKey '' n<cr>", "Normal Mode" },
    x = { "<cmd>WhichKey '' x<cr>", "Mode" },
}, { prefix = "<space><space>", mode = "n" })
