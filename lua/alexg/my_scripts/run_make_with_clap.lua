function extract_make_targets(makefile_path)
    local targets = {}
    for line in io.lines(makefile_path) do
        local target = line:match("^([%w%-%_]+):")
        if target then
            table.insert(targets, target)
        end
    end
    return targets
end

function ClapMakeTargets()
    local targets = extract_make_targets(vim.fn.getcwd() .. '/Makefile')
    print(targets)
    vim.fn['clap#run']({
        id = 'make_targets',
        source = targets,
        sink = function(selected_target)
            ExecuteMakeTarget(selected_target)
        end
    })
end

function ExecuteMakeTarget(target)
    local cmd = 'make ' .. target
    vim.cmd('belowright split | terminal ' .. cmd)
end

vim.api.nvim_set_keymap('n', '<leader>b', ':lua ClapMakeTargets()<CR>', { noremap = true, silent = true })
