--[[
Shows a floating dialog with completion paths for keybindings
--]]

--[[ INSTALL --]]

vim.pack.add({ 'https://github.com/folke/which-key.nvim' }, { confirm = false })
vim.pack.add({ 'https://github.com/nvzone/showkeys' }, { confirm = false })

--[[ SETUP --]]

require('showkeys').setup()
local which_key = require('which-key')
which_key.setup({
  preset = 'modern',
})

