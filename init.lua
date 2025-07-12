local M = {}
-- TEST
function M.Check_For_New_Tasks()
    if not pcall(require,"notify") then
        vim.api.nvim_err_writeln("nvim-notify is required")
        return
    end
    local filename = "tasks.txt"
    local file = io.open(filename, "r")  -- open file for reading
    if not file then
      error("Could not open file: " .. filename)
    end
    local content = file:read("*a")  -- read the whole file
    file:close()
    if #content == 0 then
        -- No Tasks for Today
        return
    end
     -- We have Some Tasks
    local datetime = os.date("%H:%M:%S")
    local function time_to_seconds(timestr)
        local h, m, s = timestr:match("(%d%d):(%d%d):(%d%d)")
        h, m, s = tonumber(h), tonumber(m), tonumber(s)
        return h * 3600 + m * 60 + s
    end
    local now_sec = time_to_seconds(datetime) 
    for line in content:gmatch("[^\r\n]+") do
        local task = {}
        for part in line:gmatch("([^,]+)") do
          table.insert(task, vim.trim and vim.trim(part) or part:match("^%s*(.-)%s*$"))
        end
        local task_time_sec = time_to_seconds(time[0]) 
        if task_time_sec >= task_time_now then
            vim.notify(task[1])
        end
    end
end
return M
