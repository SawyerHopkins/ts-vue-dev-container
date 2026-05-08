vim.pack.add({ 'https://github.com/nvim-mini/mini.nvim' }, { confirm = false })
vim.pack.add({ 'https://github.com/folke/which-key.nvim' }, { confirm = false })
vim.pack.add({ 'https://github.com/stevearc/oil.nvim' }, { confirm = false })
vim.pack.add({ 'https://github.com/nvim-telescope/telescope.nvim' }, { confirm = false })

local builtin = require('telescope.builtin')
local MiniMap = require('mini.map')
local mini_key_map = require('mini.keymap')

-- Move to window using the <ctrl> hjkl keys
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Go to Left Window', remap = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Go to Lower Window', remap = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Go to Upper Window', remap = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Go to Right Window', remap = true })

-- [f]ile keys
vim.keymap.set({ 'x', 'n', 's' }, '<leader>fs', '<cmd>w<cr><esc>', { desc = 'Save File' })
vim.keymap.set('n', '<leader>fg', '<cmd>NvimTreeFindFile<CR>', { desc = 'Expand to file' })
vim.keymap.set('n', '<leader>fr', '<cmd>NvimTreeRefresh<CR>', { desc = 'Refresh explorer' })
vim.keymap.set('n', '<leader>fe', '<cmd>NvimTreeToggle<CR>', { desc = 'File explorer' })
require('which-key').add({
  { '<leader>f', group = '[f]ile', icon = '' }
})

-- [_]neovim keys
vim.keymap.set("n", "<leader>_c", function()
  require("oil").open(vim.fn.stdpath("config"))
end, { desc = "Neovim config" })
require('which-key').add({
  { '<leader>_', group = '[_]neovim', icon = '' }
})

-- [s]earch keys
vim.keymap.set('n', '<leader>sac', builtin.autocommands, { desc = 'Search auto commands' })
vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = 'Search buffers' })
vim.keymap.set('n', '<leader>sds', builtin.lsp_document_symbols, { desc = 'Search document symbols' })
vim.keymap.set('n', '<leader>sD', builtin.diagnostics, { desc = 'Search diagnostics' })
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Search files' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Search grep' })
vim.keymap.set('n', '<leader>sh', builtin.current_buffer_fuzzy_find, { desc = 'Search here' })
vim.keymap.set('n', '<leader>sH', builtin.help_tags, { desc = 'Search help tags' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = 'Search keymaps' })
vim.keymap.set('n', '<leader>sp', builtin.builtin, { desc = 'Search pickers' })
vim.keymap.set('n', '<leader>sr', builtin.registers, { desc = 'Search registers' })
vim.keymap.set('n', '<leader>ssp', builtin.spell_suggest, { desc = 'Search spelling suggestions' })
vim.keymap.set('n', '<leader>sws', builtin.lsp_workspace_symbols, { desc = 'Search workspace symbols' })
vim.keymap.set('n', '<leader>sqf', builtin.quickfix, { desc = 'Search quick fix' })
vim.keymap.set('n', '<leader>st', builtin.treesitter, { desc = 'Search treesitter' })
vim.keymap.set('n', '<leader>sT', builtin.current_buffer_tags, { desc = 'Search buffer tags' })
require('which-key').add({
  { '<leader>s', group = '[s]earch', icon = '' }
})

-- [g]it keys
vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = 'Git branches' })
vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = 'Git commits' })
vim.keymap.set('n', '<leader>gC', builtin.git_bcommits, { desc = 'Git buffer commits' })
vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = 'Git status' })
vim.keymap.set('n', '<leader>gS', builtin.git_stash, { desc = 'Git stash' })
vim.keymap.set('n', '<leader>gl', '<cmd>lua _lazygit_toggle()<CR>', { noremap = true, silent = true })
require('which-key').add({
{ '<leader>g', group = '[g]it', icon = '' }
})

-- [g]oto LSP key binds
vim.keymap.set('n', 'gai', builtin.lsp_incoming_calls, { desc = 'Telescope incoming calls' })
vim.keymap.set('n', 'gao', builtin.lsp_outgoing_calls, { desc = 'Telescope outgoing calls' })
vim.keymap.set('n', 'gd', builtin.lsp_definitions, { desc = 'Telescope definition' })
vim.keymap.set('n', 'gI', builtin.lsp_implementations, { desc = 'Telescope implementation' })
vim.keymap.set('n', 'gr', builtin.lsp_references, { desc = 'Telescope references' })
vim.keymap.set('n', 'gy', builtin.lsp_type_definitions, { desc = 'Telescope type definition' })

--  [ai] around/inside content selection
vim.keymap.set({ 'x', 'o' }, 'am', function()
  require 'nvim-treesitter-textobjects.select'.select_textobject('@function.outer', 'textobjects')
end, { desc = 'Select function' })
vim.keymap.set({ 'x', 'o' }, 'im', function()
  require 'nvim-treesitter-textobjects.select'.select_textobject('@function.inner', 'textobjects')
end, { desc = 'Select function content' })
vim.keymap.set({ 'x', 'o' }, 'ac', function()
  require 'nvim-treesitter-textobjects.select'.select_textobject('@class.outer', 'textobjects')
end, { desc = 'Select class' })
vim.keymap.set({ 'x', 'o' }, 'ic', function()
  require 'nvim-treesitter-textobjects.select'.select_textobject('@class.inner', 'textobjects')
end, { desc = 'Select class content' })
vim.keymap.set({ 'x', 'o' }, 'as', function()
  require 'nvim-treesitter-textobjects.select'.select_textobject('@local.scope', 'locals')
end, { desc= 'Select block content' })

-- []] next start
vim.keymap.set({ 'n', 'x', 'o' }, ']]', function()
  require('nvim-treesitter-textobjects.move').goto_next_start('@class.outer', 'textobjects')
end, { desc = 'Goto next class start' })
vim.keymap.set({ 'n', 'x', 'o' }, ']m', function()
  require('nvim-treesitter-textobjects.move').goto_next_start('@function.outer', 'textobjects')
end, { desc = 'Goto next function start' })
vim.keymap.set({ 'n', 'x', 'o' }, ']o', function()
  require('nvim-treesitter-textobjects.move').goto_next_start('@loop.outer', 'textobjects')
end, { desc = 'Goto next loop start'})
vim.keymap.set({ 'n', 'x', 'o' }, ']d', function()
  require('nvim-treesitter-textobjects.move').goto_next_start('@conditional.outer', 'textobjects')
end, { desc = 'Goto next condition start' })
vim.keymap.set({ 'n', 'x', 'o' }, ']s', function()
  require('nvim-treesitter-textobjects.move').goto_next_start('@local.scope', 'locals')
end, { desc = 'Goto next block start' })
vim.keymap.set({ 'n', 'x', 'o' }, ']z', function()
  require('nvim-treesitter-textobjects.move').goto_next_start('@fold', 'folds')
end, { desc = 'Goto next fold start' })

-- []] next end
vim.keymap.set({ 'n', 'x', 'o' }, '][', function()
  require('nvim-treesitter-textobjects.move').goto_next_end('@class.outer', 'textobjects')
end, { desc = 'Goto next class end' })
vim.keymap.set({ 'n', 'x', 'o' }, ']M', function()
  require('nvim-treesitter-textobjects.move').goto_next_end('@function.outer', 'textobjects')
end, { desc = 'Goto next function end' })
vim.keymap.set({ 'n', 'x', 'o' }, ']O', function()
  require('nvim-treesitter-textobjects.move').goto_next_end('@loop.outer', 'textobjects')
end, { desc = 'Goto next loop end'})
vim.keymap.set({ 'n', 'x', 'o' }, ']D', function()
  require('nvim-treesitter-textobjects.move').goto_next_end('@conditional.outer', 'textobjects')
end, { desc = 'Goto next condition end' })
vim.keymap.set({ 'n', 'x', 'o' }, ']S', function()
  require('nvim-treesitter-textobjects.move').goto_next_end('@local.scope', 'locals')
end, { desc = 'Goto next block end' })
vim.keymap.set({ 'n', 'x', 'o' }, ']Z', function()
  require('nvim-treesitter-textobjects.move').goto_next_end('@fold', 'folds')
end, { desc = 'Goto next fold end' })

-- [[] previous start
vim.keymap.set({ 'n', 'x', 'o' }, '[]', function()
  require('nvim-treesitter-textobjects.move').goto_previous_start('@class.outer', 'textobjects')
end, { desc = 'Goto previous class start' })
vim.keymap.set({ 'n', 'x', 'o' }, '[m', function()
  require('nvim-treesitter-textobjects.move').goto_previous_start('@function.outer', 'textobjects')
end, { desc = 'Goto previous function start' })
vim.keymap.set({ 'n', 'x', 'o' }, '[o', function()
  require('nvim-treesitter-textobjects.move').goto_previous_start('@loop.outer', 'textobjects')
end, { desc = 'Goto previous loop start'})
vim.keymap.set({ 'n', 'x', 'o' }, '[d', function()
  require('nvim-treesitter-textobjects.move').goto_previous_start('@conditional.outer', 'textobjects')
end, { desc = 'Goto previous condition start' })
vim.keymap.set({ 'n', 'x', 'o' }, '[s', function()
  require('nvim-treesitter-textobjects.move').goto_previous_start('@local.scope', 'locals')
end, { desc = 'Goto previous block start' })
vim.keymap.set({ 'n', 'x', 'o' }, '[z', function()
  require('nvim-treesitter-textobjects.move').goto_previous_start('@fold', 'folds')
end, { desc = 'Goto previous fold start' })

-- [[] previous end
vim.keymap.set({ 'n', 'x', 'o' }, '[[', function()
  require('nvim-treesitter-textobjects.move').goto_previous_end('@class.outer', 'textobjects')
end, { desc = 'Goto previous class end' })
vim.keymap.set({ 'n', 'x', 'o' }, '[M', function()
  require('nvim-treesitter-textobjects.move').goto_previous_end('@function.outer', 'textobjects')
end, { desc = 'Goto previous function end' })
vim.keymap.set({ 'n', 'x', 'o' }, '[O', function()
  require('nvim-treesitter-textobjects.move').goto_previous_end('@loop.outer', 'textobjects')
end, { desc = 'Goto previous loop end'})
vim.keymap.set({ 'n', 'x', 'o' }, '[D', function()
  require('nvim-treesitter-textobjects.move').goto_previous_end('@conditional.outer', 'textobjects')
end, { desc = 'Goto previous condition end' })
vim.keymap.set({ 'n', 'x', 'o' }, '[S', function()
  require('nvim-treesitter-textobjects.move').goto_previous_end('@local.scope', 'locals')
end, { desc = 'Goto previous block end' })
vim.keymap.set({ 'n', 'x', 'o' }, '[Z', function()
  require('nvim-treesitter-textobjects.move').goto_previous_end('@fold', 'folds')
end, { desc = 'Goto previous fold end' })

-- [?]which_key
vim.keymap.set('n', '<leader>?', function() require('which-key').show({
  global = false
}) end, { desc = 'Buffer Local Keymaps (which-key)' })

-- [t]tab keys
vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<CR>", { desc = "New tab" })
vim.keymap.set("n", "<leader>tc", "<cmd>tabclose<CR>", { desc = "Close tab" })
vim.keymap.set("n", "<leader>to", "<cmd>tabonly<CR>", { desc = "Close other tabs" })

vim.keymap.set("n", "<leader>th", "<cmd>tabnext<CR>", { desc = "Next tab" })
vim.keymap.set("n", "<leader>tl", "<cmd>tabprevious<CR>", { desc = "Previous tab" })
vim.keymap.set("n", "<leader>tf", "<cmd>tabfirst<CR>", { desc = "First tab" })
vim.keymap.set("n", "<leader>te", "<cmd>tablast<CR>", { desc = "Last tab" })

vim.keymap.set("n", "<leader>tL", "<cmd>tabmove +1<CR>", { desc = "Move tab right" })
vim.keymap.set("n", "<leader>tH", "<cmd>tabmove -1<CR>", { desc = "Move tab left" })

-- [w]indow keys
vim.keymap.set("n", "<leader>wv", "<cmd>vsplit<CR>", { desc = "Split vertical" })
vim.keymap.set("n", "<leader>wx", "<cmd>split<CR>", { desc = "Split horizontal" })

vim.keymap.set("n", "<leader>wc", "<cmd>close<CR>", { desc = "Close window" })
vim.keymap.set("n", "<leader>wo", "<cmd>only<CR>", { desc = "Close other windows" })

vim.keymap.set("n", "<leader>wh", "<C-w>h", { desc = "Go left" })
vim.keymap.set("n", "<leader>wj", "<C-w>j", { desc = "Go down" })
vim.keymap.set("n", "<leader>wk", "<C-w>k", { desc = "Go up" })
vim.keymap.set("n", "<leader>wl", "<C-w>l", { desc = "Go right" })

vim.keymap.set("n", "<leader>w=", "<C-w>=", { desc = "Equal size" })
vim.keymap.set("n", "<leader>w+", "<cmd>resize +5<CR>", { desc = "Taller" })
vim.keymap.set("n", "<leader>w-", "<cmd>resize -5<CR>", { desc = "Shorter" })
vim.keymap.set("n", "<leader>w>", "<cmd>vertical resize +5<CR>", { desc = "Wider" })
vim.keymap.set("n", "<leader>w<", "<cmd>vertical resize -5<CR>", { desc = "Narrower" })

vim.keymap.set("n", "<leader>wH", "<C-w>H", { desc = "Move window left" })
vim.keymap.set("n", "<leader>wJ", "<C-w>J", { desc = "Move window down" })
vim.keymap.set("n", "<leader>wK", "<C-w>K", { desc = "Move window up" })
vim.keymap.set("n", "<leader>wL", "<C-w>L", { desc = "Move window right" })

vim.keymap.set("n", "<leader>wV", "<cmd>vnew<CR>", { desc = "New vertical" })
vim.keymap.set("n", "<leader>wX", "<cmd>new<CR>", { desc = "New horizontal" })

-- [r]efactor keys
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
vim.keymap.set("n", "<leader>ra", vim.lsp.buf.code_action, { desc = "Code action" })
vim.keymap.set("v", "<leader>ra", vim.lsp.buf.code_action, { desc = "Code action (selection)" })

vim.keymap.set("n", "<leader>rf", function()
  vim.lsp.buf.format({ async = true })
end, { desc = "Format buffer" })
vim.keymap.set("v", "<leader>rf", function()
  vim.lsp.buf.format({ async = true })
end, { desc = "Format selection" })

vim.keymap.set("n", "<leader>ro", function()
  vim.lsp.buf.code_action({
    apply = true,
    filter = function(action)
      return action.title:match("organize imports") or action.title:match("Organize Imports")
    end,
  })
end, { desc = "Organize imports" })

vim.keymap.set("n", "<leader>ru", function()
  vim.lsp.buf.code_action({
    apply = true,
    filter = function(action)
      return action.title:match("unused") or action.title:match("Remove unused")
    end,
  })
end, { desc = "Remove unused imports" })

require('which-key').add({
  { '<leader>r', group = '[r]efactor', icon = '' }
})

-- [h]over keys
vim.keymap.set('n', '<leader>ht', vim.lsp.buf.hover, { desc = 'LSP' })
vim.keymap.set('n', '<leader>hs', vim.lsp.buf.signature_help, { desc = 'Signature' })
vim.keymap.set('n', '<leader>hd', vim.diagnostic.open_float, { desc = 'Diagnostics' })
require('which-key').add({
  { '<leader>h', group = '[h]over', icon = '󰇀' }
})


-- [p]ersistent session keys
vim.keymap.set('n', '<leader>pw', function()
  require('mini.sessions').write()
end, { desc = 'Write current session' })

vim.keymap.set('n', '<leader>pr', function()
  require('mini.sessions').read()
end, { desc = 'Read default session' })

vim.keymap.set('n', '<leader>pd', function()
  require('mini.sessions').delete()
end, { desc = 'Delete current session' })
require('which-key').add({
  { '<leader>p', group = '[p]ersistent sessions', icon = '' }
})

-- [b]uffer keys
vim.keymap.set("n", "<leader>bc", function()
  require("mini.bufremove").delete()
end, { desc = "Close buffer" })
require('which-key').add({
  { '<leader>b', group = '[b]uffer', icon = '' }
})

-- completion
mini_key_map.map_multistep('i', '<Tab>',   { 'pmenu_accept', 'minipairs_cr' })
mini_key_map.map_multistep('i', '<S-Tab>', { 'pmenu_prev' })
mini_key_map.map_multistep('i', '<CR>',    { 'pmenu_accept', 'minipairs_cr' })
mini_key_map.map_multistep('i', '<BS>',    { 'minipairs_bs' })

