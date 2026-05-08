vim.pack.add({ "https://github.com/nvim-tree/nvim-tree.lua" }, { confirm = false })

require('nvim-tree').setup({
  diagnostics = {
    enable = true,
    show_on_dirs = true
  },
  modified = {
    enable = true,
    show_on_dirs = true
  }
})
