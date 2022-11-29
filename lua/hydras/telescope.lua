local Hydra = require("hydra")

local function cmd(command)
    return table.concat { "<Cmd>", command, "<CR>" }
end

local hint = [[
                 _f_: files       _s_: document symbols
   🭇🬭🬭🬭🬭🬭🬭🬭🬭🬼    _b_: buffers     _w_: workspace symbols 
  🭉🭁🭠🭘    🭣🭕🭌🬾   _p_: projects    _g_: live grep      
  🭅█ ▁     █🭐   _m_: marks       _/_: search in file 
  ██🬿      🭊██   
 🭋█🬝🮄🮄🮄🮄🮄🮄🮄🮄🬆█🭀  _h_: vim help    _c_: colorscheme     
 🭤🭒🬺🬹🬱🬭🬭🬭🬭🬵🬹🬹🭝🭙  _k_: keymap      _;_: commands history
                 _o_: options     _?_: search history  

                 _<Enter>_: Telescope           _<Esc>_
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
    mode = "n",
    body = "<leader>f",
    heads = {
        { "f", cmd("Telescope find_files") },
        { "b", cmd("Telescope buffers") },
        { "g", cmd("Telescope live_grep") },
        { "h", cmd("Telescope help_tags"), { desc = "Vim help" } },
        { "m", cmd("Telescope marks"), { desc = "Marks" } },
        { "k", cmd("Telescope keymaps") },
        { "s", cmd("Telescope lsp_document_symbols") }, -- consider document_symbols too
        { "w", cmd("Telescope lsp_workspace_symbols") }, -- consider document_symbols too
        { "p", cmd("Telescope projections theme=dropdown"), { desc = "Projects" } },
        { "/", cmd("Telescope current_buffer_fuzzy_find"), { desc = "Search in file" } },
        { "?", cmd("Telescope search_history"), { desc = "Search history" } },
        { ";", cmd("Telescope command_history"), { desc = "Command-line history" } },
        { "o", cmd("Telescope vim_options") },
        {
            "c",
            cmd('lua require("telescope.builtin").colorscheme(require("telescope.themes").get_dropdown({enable_preview=true}))'),
            { desc = "Change colorscheme" },
        },
        { "<Enter>", cmd("Telescope"), { exit = true, desc = "List all pickers" } },
        { "<Esc>", nil, { exit = true, nowait = true } },
    },
}
