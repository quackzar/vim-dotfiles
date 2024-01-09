local Hydra = require("hydra")

local function cmd(command)
    return table.concat { "<Cmd>", command, "<CR>" }
end

--                 _f_: files       _s_: document symbols
--   🭇🬭🬭🬭🬭🬭🬭🬭🬭🬼    _b_: buffers     _w_: workspace symbols
--  🭉🭁🭠🭘    🭣🭕🭌🬾   _t_: ast-grep    _g_: live grep (_a_rgs)
--  🭅█ ▁     █🭐   _m_: marks       _/_: search in file
--  ██🬿      🭊██
-- 🭋█🬝🮄🮄🮄🮄🮄🮄🮄🮄🬆█🭀  _h_: vim help    _c_: colorscheme
-- 🭤🭒🬺🬹🬱🬭🬭🬭🬭🬵🬹🬹🭝🭙  _k_: keymap      _;_: commands history
--                 _o_: options     _?_: search history
--     _r_esume
--                 _<space>_: alternative        _<Esc>_

local hint_alt = [[
     infinite possibilities
   🭇🬭🬭🬭🬭🬭🬭🬭🬭🬼
  🭉🭁🭠🭘    🭣🭕🭌🬾     _c_: grep under cursor
  🭅█      █🭐     _g_: live grep args (under cursor)
  ██🬿  o   🭊██     _t_: tagstack
 🭋█🬝🮄🮄🮄🮄🮄🮄🮄🮄🬆█🭀    _j_: jump list
 🭤🭒🬺🬹🬱🬭🬭🬭🬭🬵🬹🬹🭝🭙

     _r_esume
                 _<enter>_: telescope         _<esc>_
]]

return Hydra {
    name = "Telescope",
    hint = hint_alt,
    config = {
        color = "teal",
        invoke_on_body = true,
        hint = {
            position = "middle",
            border = "rounded",
        },
    },
    mode = "n",
    -- body = "<leader>F",
    heads = {
        { "r", cmd("Telescope resume") },
        -- { "g", cmd("Telescope live_grep") },
        -- { "a", function()
        --     local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
        --     live_grep_args_shortcuts.grep_word_under_cursor()
        -- end},
        {
            "g",
            function()
                local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
                live_grep_args_shortcuts.grep_word_under_cursor()
            end,
        },
        { "c", cmd("Telescope grep_word_under_cursor") },
        { "t", cmd("Telescope tagstack") },
        { "j", cmd("Telescope jumplist") },
        { "<enter>", cmd("Telescope") },
        { "<esc>", nil, { exit = true, nowait = true } },
    },
}
