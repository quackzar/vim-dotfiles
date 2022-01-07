local colors = {
    flavour = "dark", -- set type of colorscheme: dark/light
    bg = "#191919", -- background
    -- bg = "#1B1D1E", -- background
    bg_alt = "#26202b", -- alternate background
    bg_float = "#26202b", -- for floating windows and statuslines and pum sidebar and pum selected and CursorColumn
    inactive = "#403D3D", -- for stuff like empty folder(any inactive stuff)
    subtle = "#808080", -- for comments and float border and more...
    fg = "#ffffff", -- the foreground/text color
    red = "#F92672", -- for errors
    yellow = "#ffff87", -- for warns
    orange = "#FF9700", -- mostly for booleans
    blue = "#62D8F1", -- for keywords
    green = "#A4E400", -- for info and constructors/labels and diffadd
    magenta = "#af87ff", -- for hints and visual mode/search foreground/special comments/git stage and merge
    highlight = "#403D3D", -- ofc for highlighting (it is the bg of highlighted text)
    highlight_inactive = "#292929", -- same as highlight for inactive stuff and also cursor line
    highlight_overlay = "#403D3D", -- same as highlight for overlays (floats)
    none = "NONE",
}

return colors
