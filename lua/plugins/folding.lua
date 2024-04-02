return {
    {
        "kevinhwang91/nvim-ufo",
        enabled = true,
        dependencies = "kevinhwang91/promise-async",
        event = "VeryLazy",
        opts = {
            { "lsp", "treesitter", "indent" },
            open_fold_hl_timeout = 150,
            close_fold_kinds_for_ft = {
                default = { "imports", "comment" },
                json = { "array" },
                c = { "comment", "region" },
            },
            preview = {
                win_config = {
                    border = { "", "─", "", "", "", "─", "", "" },
                    winhighlight = "Normal:Folded",
                    winblend = 0,
                },
                mappings = {
                    scrollU = "<C-u>",
                    scrollD = "<C-d>",
                    jumpTop = "[",
                    jumpBot = "]",
                },
            },
            -- provider_selector = function(_, ft, _)
            --     if ft == "tex" or ft == "latex" then
            --         return "treesitter"
            --     else
            --         return nil
            --     end
            -- end,
            fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
                local newVirtText = {}
                local suffix = (" 󰁂 %d "):format(endLnum - lnum)
                local sufWidth = vim.fn.strdisplaywidth(suffix)
                local targetWidth = width - sufWidth
                local curWidth = 0
                for _, chunk in ipairs(virtText) do
                    local chunkText = chunk[1]
                    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    if targetWidth > curWidth + chunkWidth then
                        table.insert(newVirtText, chunk)
                    else
                        chunkText = truncate(chunkText, targetWidth - curWidth)
                        local hlGroup = chunk[2]
                        table.insert(newVirtText, { chunkText, hlGroup })
                        chunkWidth = vim.fn.strdisplaywidth(chunkText)
                        -- str width returned from truncate() may less than 2nd argument, need padding
                        if curWidth + chunkWidth < targetWidth then
                            suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
                        end
                        break
                    end
                    curWidth = curWidth + chunkWidth
                end
                table.insert(newVirtText, { suffix, "MoreMsg" })
                return newVirtText
            end,
        },
        init = function()
            vim.o.foldcolumn = "1"
            vim.o.foldlevel = 99
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true
            vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
            local keymap = vim.keymap
            keymap.amend = require("keymap-amend")
            vim.keymap.amend("n", "l", function(fallback)
                local winid = require("ufo").peekFoldedLinesUnderCursor()
                if not winid then
                    fallback()
                end
            end)
        end,
        keys = {
            {
                "zR",
                function()
                    require("ufo").openAllFolds()
                end,
                desc = "Open all folds",
            },
            {
                "zM",
                function()
                    require("ufo").closeAllFolds()
                end,
                desc = "Minimize all folds",
            },
            {
                "zr",
                function()
                    require("ufo").openAllFolds()
                end,
                desc = "Open all folds under cursor",
            },
            {
                "zm",
                function()
                    require("ufo").closeFoldsWith()
                end,
                desc = "Close all folds under cursor",
            },
        },
    },

    {
        "chrisgrieser/nvim-origami",
        event = "BufReadPost", -- later or on keypress would prevent saving folds
        opts = {
            keepFoldsAcrossSessions = true,
            pauseFoldsOnSearch = true,
            setupFoldKeymaps = false,
        },
    },
}
