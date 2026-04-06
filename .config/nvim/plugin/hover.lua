--[[
Adds popover which can be activated by mouse or keyboard that
displays lsp, dictionary, and diagnostic information. Additional
data providers can be enabled.
--]]

--[[ INSTALL --]]

vim.pack.add({ 'https://github.com/lewis6991/hover.nvim' }, { confirm = false })

--[[ SETUP --]]

require('hover').setup({})

