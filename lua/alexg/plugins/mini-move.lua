local minimove_config = function()
    local opts = {
        -- Module mappings. Use `''` (empty string) to disable one.
        mappings = {
            -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
            left = '<M-S-h>',
            right = '<M-S-l>',
            down = '<M-S-j>',
            up = '<M-S-k>',

            -- Move current line in Normal mode
            line_left = '<M-S-h>',
            line_right = '<M-S-l>',
            line_down = '<M-S-j>',
            line_up = '<M-S-k>',
        },

        -- Options which control moving behavior
        options = {
            -- Automatically reindent selection during linewise vertical move
            reindent_linewise = true,
        },
    }
    require('mini.move').setup(opts)
end
return { 'echasnovski/mini.move', version = '*' , config = minimove_config}
