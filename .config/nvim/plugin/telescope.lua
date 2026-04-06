--[[
Adds (fuzzy) search functionality for various providers (buffers, lsp, git)
--]]

--[[ INSTALL --]]

vim.pack.add({ 'https://github.com/nvim-lua/plenary.nvim' }, { confirm = false })
vim.pack.add({ 'https://github.com/nvim-telescope/telescope-fzf-native.nvim' }, { confirm = false })
vim.pack.add({ 'https://github.com/nvim-telescope/telescope.nvim' }, { confirm = false })
vim.pack.add({ 'https://github.com/folke/which-key.nvim' }, { confirm = false })

--[[ SETUP --]]

local sendToGrep = function(prompt_bufnr)
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local builtin = require("telescope.builtin")

  local picker = action_state.get_current_picker(prompt_bufnr)
  local selections = picker:get_multi_selection()

  -- if nothing was multi-selected, use the current highlight
  if #selections == 0 then
    table.insert(selections, action_state.get_selected_entry())
  end

  actions.close(prompt_bufnr)

  -- collect unique directories from all selections
  local dirs = {}
  local seen = {}
  for _, entry in ipairs(selections) do
    local dir = vim.fn.fnamemodify(entry.path or entry.value, ":h")
    if not seen[dir] then
      seen[dir] = true
      table.insert(dirs, dir)
    end
  end

  builtin.live_grep({ search_dirs = dirs })
end

require('telescope').setup({
  pickers = {
    find_files = {
      mappings = {
        n = {
          ["<leader>sg"] = sendToGrep
        }
      }
    },
    buffers = {
      mappings = {
        n = {
        ["d"] = function(prompt_bufnr)
            local action_state = require("telescope.actions.state")
            local current_picker = action_state.get_current_picker(prompt_bufnr)
            current_picker:delete_selection(function(selection)
              require("mini.bufremove").delete(selection.bufnr)
            end)
          end,
        }
      }
    }
  }
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'TelescopePreviewerLoaded',
  callback = function(args)
    if args.data.filetype ~= 'help' then
      vim.wo.number = true
    elseif args.data.bufname:match('*.csv') then
      vim.wo.wrap = false
    end
  end,
})

