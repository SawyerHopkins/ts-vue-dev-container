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

-- Lightweight autocompletion framework
require('mini.completion').setup()

-- File explorer for navigating directories and files
-- lighter and smaller than oil, but less information provided
require('mini.files').setup()

-- Map keys to perform configurable multi-step actions
local mini_key_map = require('mini.keymap')
mini_key_map.setup()

-- Move lines or selections up/down/left/right
require('mini.move').setup()

-- Extended operator support (like replace, evaluate, sort, etc.)
require('mini.operators').setup()

-- Auto-pair brackets, quotes, etc.
require('mini.pairs').setup()

-- Snippet engine (loading + expansion support)
local snippets = require('mini.snippets')
snippets.setup({
  snippets = {
    snippets.gen_loader.from_file(vim.fn.stdpath('config') .. '/snippets/global.json'),
    snippets.gen_loader.from_lang(),
  }
})
snippets.start_lsp_server()

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

-- Mini-map (code overview sidebar like VSCode minimap)
local map = require('mini.map')
map.setup({
  integrations = {
    map.gen_integration.builtin_search(),
    map.gen_integration.diff(),
    map.gen_integration.diagnostic(),
  }
})

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
