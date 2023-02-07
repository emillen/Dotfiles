local action_state = require('telescope.actions.state')
local actions = require('telescope.actions')

local m = {}

m.my_buffer = function()
  require'telescope.builtin'.buffers{
    attach_mappings = function(prompt_bufnr, map)
      local delete_buf = function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        vim.api.nvim_buf_delete(selection.bufnr, { force = true })
        m.my_buffer()
      end

      map('n', '<c-d>', delete_buf)
      map('i', '<c-d>', delete_buf)

      return true
    end
  }
end

return m
