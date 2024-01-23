local Hydra = require("hydra")

local function cmd(command)
    return table.concat { "<Cmd>", command, "<CR>" }
end

local hint = [[
                 _f_: files       _s_: document symbols
   🭇🬭🬭🬭🬭🬭🬭🬭🬭🬼    _b_: buffers     _w_: workspace symbols
  🭉🭁🭠🭘    🭣🭕🭌🬾   _t_: ast-grep    _g_: live grep (_a_rgs)
  🭅█ ▁     █🭐   _m_: marks       _/_: search in file
  ██🬿      🭊██
 🭋█🬝🮄🮄🮄🮄🮄🮄🮄🮄🬆█🭀  _h_: vim help    _c_: colorscheme
 🭤🭒🬺🬹🬱🬭🬭🬭🬭🬵🬹🬹🭝🭙  _k_: keymap      _;_: commands history
                 _o_: options     _?_: search history
     _r_esume
                 _<space>_: alternative        _<esc>_
]]

Hydra {
    name = "Telescope",
    hint = hint,
    config = {
        color = "teal",
        invoke_on_body = true,
        hint = {
            position = "middle",
            border = "rounded",
        },
    },
    mode = { "n" },
    body = "<leader>f",
    heads = {
        { "r", cmd("Telescope resume") },
        { "f", cmd("Telescope find_files") },
        { "b", cmd("Telescope buffers") },
        { "g", cmd("Telescope live_grep") },
        { "a", cmd("Telescope live_grep_args") },
        { "t", cmd("Telescope ast_grep") },
        { "h", cmd("Telescope help_tags"), { desc = "Vim help" } },
        { "m", cmd("Telescope marks"), { desc = "Marks" } },
        { "k", cmd("Telescope keymaps") },
        { "s", cmd("Telescope lsp_document_symbols theme=dropdown") }, -- consider document_symbols too
        { "w", cmd("Telescope lsp_workspace_symbols") }, -- consider document_symbols too
        { "/", cmd("Telescope current_buffer_fuzzy_find"), { desc = "Search in file" } },
        { "?", cmd("Telescope search_history"), { desc = "Search history" } },
        { ";", cmd("Telescope command_history"), { desc = "Command-line history" } },
        { "o", cmd("Telescope vim_options") },
        {
            "c",
            function()
                vim.api.nvim_exec_autocmds("User", { pattern = "LoadAllColorSchemes" })
                require("telescope.builtin").colorscheme(
                    require("telescope.themes").get_dropdown { enable_preview = true }
                )
            end,
            { desc = "Change colorscheme" },
        },
        -- { "<Enter>", cmd("Telescope"), { exit = true, desc = "List all pickers" } },
        {
            "<space>",
            function()
                require("hydras.telescope_alt"):activate()
            end,
            { exit_before = true },
        },
        { "<esc>", nil, { exit = true, nowait = true } },
    },
}

-- Not a hydra but could become one.
vim.keymap.set("x", "<leader>f", cmd("Telescope grep_string"), { desc = "grep string" })
