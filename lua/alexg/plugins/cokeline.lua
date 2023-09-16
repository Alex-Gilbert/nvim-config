function cokeline_config()

    local map = vim.api.nvim_set_keymap
    local get_hex = require('cokeline/utils').get_hex
    local get_visible = require('cokeline/buffers').get_visible
    local is_picking_focus = require('cokeline/mappings').is_picking_focus
    local is_picking_close = require('cokeline/mappings').is_picking_close

    local red = vim.g.terminal_color_1
    local yellow = vim.g.terminal_color_3
    local oceanblue = '#C55FFC'

    require('cokeline').setup({
        -- Only show the bufferline when there are at least this many visible buffers.
        -- default: `1`.
        show_if_buffers_are_at_least = 1,

        buffers = {
            -- filter_valid = function(buffer) return buffer.filetype ~= 'netrw' and buffer.filetype ~= 'startify' end,

            focus_on_delete = 'next',

            new_buffers_position = 'next',
        },

        mappings = {
            cycle_prev_next = true,
        },

        rendering = {
            max_buffer_width = 999,
        },

        default_hl = {
            fg = '#ffffff',
            bg = function(buffer)
                return
                    buffer.is_focused
                    and oceanblue
                    or get_hex('ColorColumn', 'bg')
            end,
        },
        components = {
            {
                text = function(buffer)
                    return buffer.is_focused and '' or ' '
                end ,
                fg = function(buffer)
                    return buffer.is_focused and buffer.index ~= 1 and get_hex('Normal', 'bg') or oceanblue
                end,
                bg = function(buffer)
                    return buffer.is_focused and oceanblue or get_hex('Normal', 'bg')
                end
            },
            {
                text = function(buffer)
                    return
                        (is_picking_focus() or is_picking_close())
                        and buffer.pick_letter .. ' '
                        or buffer.devicon.icon
                end,
                fg = function(buffer)
                    return
                        (is_picking_focus() and red)
                        or (is_picking_close() and yellow)
                        or buffer.devicon.color
                end,
                style = function(_)
                    return
                        (is_picking_focus() or is_picking_close())
                        and 'italic,bold'
                        or nil
                end,
            },
            {
                text = function(buffer) return buffer.index .. ' ' end,
                style = 'italic',
            },
            {
                text = function(buffer) return buffer.filename .. '  ' end,
                style = function(buffer) return buffer.is_focused and 'bold' or nil end,
            },
            {
                text = function(buffer)
                    if buffer.is_focused then
                        return ''
                    end
                    local buffers = get_visible()
                    local next = buffer.index + 1
                    return buffers[next] and buffers[next].is_focused and '' or ' '
                end ,
                fg = function(buffer)
                    return buffer.is_focused and oceanblue or get_hex('Normal', 'fg')
                end,
                bg = get_hex('ColorColumn', 'bg')
            },
        },
    })

end

local coke = {
  "willothy/nvim-cokeline",
  dependencies = {
    "nvim-lua/plenary.nvim",        -- Required for v0.4.0+
    "nvim-tree/nvim-web-devicons", -- If you want devicons
  },
  config = cokeline_config,
}
return {}
