return {
    "jake-stewart/multicursor.nvim",
    enable = false,
    event = "VeryLazy",
    branch = "1.0",
    config = function()
        -- The leader for multicursors have been set to <S-C>
        local mc = require("multicursor-nvim")
        local set = vim.keymap.set

        mc.setup()

        -- Add cursors above/below the main cursor.
        set({ "n", "v" }, "<S-C-k>", function()
            mc.addCursor("k")
        end)
        set({ "n", "v" }, "<S-C-j>", function()
            mc.addCursor("j")
        end)

        -- Add a cursor and jump to the next word under cursor.
        set({ "n", "v" }, "<S-C-n>", function()
            mc.addCursor("*")
        end)

        -- Jump to the next word under cursor but do not add a cursor.
        set({ "n", "v" }, "<S-C-s>", function()
            mc.skipCursor("*")
        end)

        -- Rotate the main cursor.
        set({ "n", "v" }, "<S-C-l>", mc.nextCursor)
        set({ "n", "v" }, "<S-C-h>", mc.prevCursor)

        -- Delete the main cursor.
        set({ "n", "v" }, "<S-C-x>", mc.deleteCursor)

        -- Add and remove cursors with control + left click.
        set("n", "<c-leftmouse>", mc.handleMouse)

        set({ "n", "v" }, "<S-C-q>", function()
            if mc.cursorsEnabled() then
                -- Stop other cursors from moving.
                -- This allows you to reposition the main cursor.
                mc.disableCursors()
            else
                mc.addCursor()
            end
        end)

        set("n", "<esc>", function()
            if not mc.cursorsEnabled() then
                mc.enableCursors()
            elseif mc.hasCursors() then
                mc.clearCursors()
            else
                -- Default <esc> handler.
            end
        end)

        -- Align cursor columns.
        set("n", "<S-C-a>", mc.alignCursors)

        -- Split visual selections by regex.
        set("v", "S", mc.splitCursors)

        -- Append/insert for each line of visual selections.
        set("v", "I", mc.insertVisual)
        set("v", "A", mc.appendVisual)

        -- match new cursors within visual selections by regex.
        set("v", "M", mc.matchCursors)

        -- Rotate visual selection contents.
        set("v", "<S-C-t>", function()
            mc.transposeCursors(1)
        end)
        set("v", "<S-C-o>", function()
            mc.transposeCursors(-1)
        end)

        set({ "x", "n" }, "<c-i>", mc.jumpForward)
        set({ "x", "n" }, "<c-o>", mc.jumpBackward)

        -- Customize how cursors look.
        local hl = vim.api.nvim_set_hl
        hl(0, "MultiCursorCursor", { link = "Cursor" })
        hl(0, "MultiCursorVisual", { link = "Visual" })
        hl(0, "MultiCursorSign", { link = "SignColumn" })
        hl(0, "MultiCursorMatchPreview", { link = "Search" })
        hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
        hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
        hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
    end,
}
