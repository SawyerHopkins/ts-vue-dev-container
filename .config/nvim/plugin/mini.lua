--[[
Installs and configures various tools provided from the mini meta library.
--]]

--[[ INSTALL --]]

vim.pack.add({ 'https://github.com/nvim-mini/mini.nvim' }, { confirm = false })
vim.pack.add({ 'https://github.com/folke/which-key.nvim' }, { confirm = false })

--[[ SETUP --]]

-- Enhanced text objects (e.g., around/inside functions, arguments, etc.)
require('mini.ai').setup()

-- Align text based on patterns (like '=', ':', etc.)
require('mini.align').setup()

-- Toggle comments easily (line/block commenting)
require('mini.comment').setup()

-- Move lines or selections up/down/left/right
require('mini.move').setup()

-- Extended operator support (like replace, evaluate, sort, etc.)
require('mini.operators').setup()

-- Auto-pair brackets, quotes, etc.
require('mini.pairs').setup()

-- Toggle between single-line and multi-line structures (e.g., arrays, arguments)
require('mini.splitjoin').setup()

-- Add/change/delete surrounding characters (quotes, brackets, etc.)
require('mini.surround').setup()

-- Sensible default settings (options, mappings, autocommands)
require('mini.basics').setup()

-- Navigate between bracketed items (buffers, files, diagnostics, etc.)
require('mini.bracketed').setup()

-- Allow removing buffers without closing windows
require('mini.bufremove').setup()

-- Enhanced command-line UI (better completion and visuals)
require('mini.cmdline').setup()

-- Show and manage diff hunks in buffers
require('mini.diff').setup()

-- Git integration (status, hunks, blame, etc.)
require('mini.git').setup()

-- Session management (save/restore working sessions)
require('mini.sessions').setup()

-- Smooth animations for scrolling, cursor movement, etc.
require('mini.animate').setup()

-- Highlight word under cursor
require('mini.cursorword').setup()

-- Provide filetype icons (used by other plugins/UI)
require('mini.icons').setup()

-- Visual indentation guides with scope highlighting
require('mini.indentscope').setup()

-- Notification system (replaces vim.notify with better UI)
require('mini.notify').setup()

-- Lightweight and customizable statusline
require('mini.statusline').setup()

-- Tabline showing open buffers/tabs
require('mini.tabline').setup()

-- Highlight and remove trailing whitespace
require('mini.trailspace').setup()

vim.api.nvim_create_autocmd("User", {
  pattern = "MiniSessionSavePre",
  callback = function()
    -- Close nvim-tree before session save
    local nvim_tree_api = require("nvim-tree.api")
    nvim_tree_api.tree.close()
  end,
})

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

vim.cmd.colorscheme('catppuccin')

