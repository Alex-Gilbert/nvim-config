local function set_key_mappings(buf, win)
    local opts = { noremap = true, silent = true }

    -- 'j' and 'k' for navigation
    vim.api.nvim_buf_set_keymap(buf, 'n', 'j', 'j', opts)
    vim.api.nvim_buf_set_keymap(buf, 'n', 'k', 'k', opts)

    -- '<CR>' to confirm selection
    vim.api.nvim_buf_set_keymap(buf, 'n', '<CR>', ':lua on_target_selected(' .. buf .. ', ' .. win .. ')<CR>', opts)

    -- 'q' to quit and cancel
    vim.api.nvim_buf_set_keymap(buf, 'n', 'q', ':lua vim.api.nvim_win_close(' .. win .. ', true)<CR>', opts)
end

local output_buf = nil

local function on_make_output(job_id, data, event)
    if output_buf and data then
        for _, line in ipairs(data) do
            if line ~= "" then
                vim.api.nvim_buf_set_lines(output_buf, -1, -1, false, { line })
            end
        end
    end
end

local function on_make_exit(job_id, exit_code, _)
    print("Make exited with code: " .. exit_code)
end

local function create_floating_window()
    local width = 40                        -- define the width of the window
    local height = 10                       -- define the height of the window

    local row = (vim.o.lines - height) / 2  -- calculate vertical position
    local col = (vim.o.columns - width) / 2 -- calculate horizontal position

    local opts = {
        relative = 'editor', -- position relative to the editor window
        width = width,
        height = height,
        row = row,
        col = col,
        style = 'minimal',  -- minimal style for the floating window
        border = 'rounded', -- rounded border for the floating window
    }

    local buf = vim.api.nvim_create_buf(false, true)   -- create a new buffer for the window
    local win = vim.api.nvim_open_win(buf, true, opts) -- open the window with the specified options

    return buf, win                                    -- return buffer and window handles
end

local function create_output_window()
    local width = math.floor(vim.o.columns * 0.8) -- 80% of the total width
    local height = math.floor(vim.o.lines * 0.8) -- 80% of the total height

    -- Ensure width and height are positive integers
    width = width > 0 and width or 1
    height = height > 0 and height or 1

    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    local opts = {
        relative = 'editor',
        width = width,
        height = height,
        row = row,
        col = col,
        style = 'minimal',
        border = 'rounded',
    }

    local buf = vim.api.nvim_create_buf(false, true)
    local win = vim.api.nvim_open_win(buf, true, opts)

    return buf, win
end

local function extract_make_targets(makefile_path)
    local targets = {}
    for line in io.lines(makefile_path) do
        local target = line:match("^([%w%-%_]+):")
        if target then
            table.insert(targets, target)
        end
    end
    return targets
end

local function populate_window(buf, win, targets)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, targets)
    set_key_mappings(buf, win)
end

function on_target_selected(buf, win)
    -- Get the current line (target) in the buffer
    local line = vim.api.nvim_buf_get_lines(buf, vim.api.nvim_win_get_cursor(win)[1] - 1,
        vim.api.nvim_win_get_cursor(win)[1], false)[1]
    local target = line:match("^([%w%-%_]+)")

    if target then
        vim.api.nvim_win_close(win, true) -- Close the menu window

        -- Open output window
        output_buf, output_win = create_output_window()

        -- Start the make command
        vim.fn.jobstart("make " .. target, {
            cwd = vim.fn.getcwd(),
            on_stdout = on_make_output,
            on_stderr = on_make_output,
            on_exit = function(job_id, exit_code, _)
                vim.api.nvim_buf_set_lines(output_buf, -1, -1, false, { "Make exited with code: " .. exit_code })
            end,
        })
    end
end

function open_make_menu()
    local makefile_path = vim.fn.getcwd() .. '/Makefile'
    local targets = extract_make_targets(makefile_path)
    local buf, win = create_floating_window()
    populate_window(buf, win, targets)
end

vim.api.nvim_set_keymap('n', '<leader>b', ':lua open_make_menu()<CR>', { noremap = true, silent = true })
