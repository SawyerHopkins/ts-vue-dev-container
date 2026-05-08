--[[
Provides autocompletion for buffer and lsp
--]]
--
--[[ INSTALL --]]

vim.pack.add({
  { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('*') },
})

require('blink.cmp').setup({
  keymap = {
    preset = 'super-tab',
  },
  completion = {
    list = {
      selection = {
        preselect = true,
        auto_insert = false,
      },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
    },
    ghost_text = {
      enabled = true,
    },
    menu = {
      draw = {
        columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } }
      }
    }
  },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
    providers = {
      snippets = {
        opts = {
          friendly_snippets = true
        }
      }
    }
  },
  fuzzy = {
    implementation = 'prefer_rust_with_warning',
  },
  appearance = {
    nerd_font_variant = 'mono',
    use_nvim_cmp_as_default = true
  },
  signature = {
    enabled = true
  },
})
