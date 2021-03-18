local M = {}

local running = false
local state = '  '

function M.state()
    return state
end

function M.isRunning()
    return running
end

function M.start()
    if running then
        return
    end
    running = true
    local chars = {
            "⢀⠀", "⡀⠀", "⠄⠀", "⢂⠀", "⡂⠀", "⠅⠀", "⢃⠀",
            "⡃⠀", "⠍⠀", "⢋⠀", "⡋⠀", "⠍⠁", "⢋⠁", "⡋⠁",
            "⠍⠉", "⠋⠉", "⠋⠉", "⠉⠙", "⠉⠙", "⠉⠩", "⠈⢙",
            "⠈⡙", "⢈⠩", "⡀⢙", "⠄⡙", "⢂⠩", "⡂⢘", "⠅⡘",
            "⢃⠨", "⡃⢐", "⠍⡐", "⢋⠠", "⡋⢀", "⠍⡁", "⢋⠁",
            "⡋⠁", "⠍⠉", "⠋⠉", "⠋⠉", "⠉⠙", "⠉⠙", "⠉⠩",
            "⠈⢙", "⠈⡙", "⠈⠩", "⠀⢙", "⠀⡙", "⠀⠩", "⠀⢘",
            "⠀⡘", "⠀⠨", "⠀⢐", "⠀⡐", "⠀⠠", "⠀⢀", "⠀⡀"
        }
    local i = 1
    local timer = vim.loop.new_timer()
    timer:start(1000,
    120, function()
        if not running then
            timer:close()  -- Always close handles to avoid leaks.
        end
        i = (i + 1) % 56
        state = chars[i+1]
    end)
end

function M.stop()
    running = false
    state = '  '
end

return M
