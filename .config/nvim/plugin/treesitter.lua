--[[
Provides language parsing for syntax highlighting, indentation and folding.
--]]

--[[ PRE-INSTALL --]]

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'nvim-treesitter' and kind == 'update' then
      if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
      vim.cmd('TSUpdate')
    end
  end
})

--[[ INSTALL --]]

vim.pack.add({ 'https://github.com/nvim-treesitter/nvim-treesitter' }, { confirm = false })
vim.pack.add({ 'https://github.com/nvim-treesitter/nvim-treesitter-context' }, { confirm = false })
vim.pack.add({ 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects' }, { confirm = false })

--[[ SETUP --]]

local nts = require('nvim-treesitter')
nts.install({
  'css',
  'hcl',
  'html',
  'javascript',
  'json',
  'scss',
  'sql',
  'tsx',
  'typescript',
  'vue',
  'xml',
  'yaml'
})

require('treesitter-context').setup({
  enabled = true
})
require('nvim-treesitter-textobjects').setup({
    select = {
    lookahead = true,
    include_surrounding_whitespace = false,
  },
  move = {
    lookahead = true,
    -- whether to set jumps in the jumplist
    set_jumps = true,
  },
})

vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local filetype = args.match
    local lang = vim.treesitter.language.get_lang(filetype)
    if vim.treesitter.language.add(lang) then
      vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.wo[0][0].foldmethod = 'expr'
      vim.bo.indentexpr = 'v:lua.require\'nvim-treesitter\'.indentexpr()'
      vim.treesitter.start()
    end
  end
})

