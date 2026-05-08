--[[
Enable git gutter support, blame, and hunk diffing. Exposes git interactions
through the :Gitsigns user command.

@TODO Add key bindings for common git hunk actions
--]]

--[[ INSTALL --]]

vim.pack.add({ 'https://github.com/lewis6991/gitsigns.nvim' }, { confirm = false })

--[[ SETUP --]]

require('gitsigns').setup()
