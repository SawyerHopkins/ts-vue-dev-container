vim.opt.tabstop = 2         -- Number of spaces that a <Tab> character displays as
vim.opt.shiftwidth = 2      -- Number of spaces used for each step of (auto)indent
vim.opt.softtabstop = 2     -- Number of spaces a <Tab> counts for while editing (in insert mode)
vim.opt.expandtab = true    -- Convert tabs to spaces (insert spaces instead of literal tab characters)
vim.opt.foldlevelstart = 99 -- Initial fold level when opening a file (99 = effectively all folds open)
vim.o.mousemoveevent = false -- Enable mouse move events (triggers events on mouse movement, useful for plugins/UI) 
vim.g.no_plugin_maps = true -- Disable entire built-in ftplugin mappings to avoid conflicts.
vim.opt.cursorline = true   -- Enable highlighting of the current line
vim.opt.clipboard = vim.env.SSH_CONNECTION and '' or 'unnamedplus' -- Sync with system clipboard
vim.g.loaded_netrw = 1 -- Disable netrw
vim.g.loaded_netrwPlugin = 1 -- Disable netrw
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

--[[
  Set status line filename highlight color when buffer is dirty 
--]]

local default_hl = nil -- Default highlight color
local dirty_hl = nil -- Highlight color to use when file is dirty
local target_hl = 'MiniStatuslineFilename' -- Highlight to change when dirty


vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function ()
    default_hl = vim.api.nvim_get_hl_by_name(target_hl, true) -- Get the original target highlight
    dirty_hl = vim.api.nvim_get_hl_by_name('WarningMsg', true)
  end
})

vim.api.nvim_create_autocmd({
  'BufEnter',
  'BufModifiedSet',
  'WinEnter',
  'BufWritePost'
}, {
  callback = function()
    -- Color scheme needs to be loaded to continue
    if (default_hl == nil) or (dirty_hl == nil) then
      return
    end

    if vim.bo.modified then
      -- Set warning highlight
      vim.api.nvim_set_hl(0, target_hl, {
        fg = dirty_hl.foreground,
        bg = dirty_hl.background,
        bold = true
      })
    else
      -- Restore default highlight
      vim.api.nvim_set_hl(0, target_hl, {
        fg = default_hl.foreground,
        bg = default_hl.background,
        bold = default_hl.bold,
      })
    end
  end,
})
