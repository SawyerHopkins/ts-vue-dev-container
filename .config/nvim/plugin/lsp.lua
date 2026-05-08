--[[
Provides data for code completion, diagnostics, and formatting.
--]]

--[[ INSTALL --]]

vim.pack.add({ 'https://github.com/neovim/nvim-lspconfig' }, { confirm = false })

--[[ SETUP --]]

vim.lsp.config('vue_ls', {
  init_options = {
    vue = {
      hybridMode = true
    }
  }
})

vim.lsp.config('vtsls', {
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          {
            name = '@vue/typescript-plugin',
            location = vim.fn.stdpath('data') .. '/mason/packages/vue-language-server/node_modules/@vue/language-server',
            languages = { 'vue' },
            configNamespace = 'typescript',
          }
        },
      },
    },
  },
  filetypes = {
    'typescript',
    'javascript',
    'javascriptreact',
    'typescriptreact',
    'vue'
  },
  on_attach = function(client)
    local existing_capabilities = client.server_capabilities
    if vim.bo.filetype == 'vue' then
      existing_capabilities.semanticTokensProvider.full = false
    else
      existing_capabilities.semanticTokensProvider.full = true
    end
  end
})

vim.lsp.enable({
  'vtsls',
  'vue_ls'
})
