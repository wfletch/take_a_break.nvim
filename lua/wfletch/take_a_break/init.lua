local function on_anything()
    -- The logic would be that we would reset an idle timer on every single action
    -- If the idle timer triggers, we must be on a break
    -- Once the idel timer restarts after breaking. the process restarts
    -- if the user decides to ignore the break warning. Just keep notifying every second
    -- allow functionality to disable limits and stop warnings/alerts
end

vim.api.nvim_create_autocmd({
    "CmdlineLeave",
    "BufWritePost",
    "BufReadPost",
    "TextChanged",
    "TextChangedI",
    "CursorMoved",
    "ModeChanged",
}, {
    callback = on_anything,
})
