local lsp_zero = require('lsp-zero')
local lsp_config = require('lspconfig')

lsp_zero.on_attach(function(client, bufnr)
  local set_lsp_keymap = function(key, fn, desc)
    vim.keymap.set({ 'n', 'v' }, '<leader>c'..key, fn, { buffer = bufnr, desc = desc })
  end
  set_lsp_keymap('a', vim.lsp.buf.code_action, '[c]ode - [a]ction')
  set_lsp_keymap('f', vim.lsp.buf.format, '[c]ode - [f]ormat')
  set_lsp_keymap('R', vim.lsp.buf.rename, '[c]ode - [R]ename symbol')
  set_lsp_keymap('k', vim.lsp.buf.hover, '[c]ode - show information')
  set_lsp_keymap('d', vim.lsp.buf.definition, '[c]ode - jump to [d]efinition')
  set_lsp_keymap('D', vim.lsp.buf.declaration, '[c]ode - jump to [d]eclaration')
  set_lsp_keymap('i', vim.lsp.buf.implementation, '[c]ode - jump to [i]mplementation')
  set_lsp_keymap('o', vim.lsp.buf.type_definition, '[c]ode - jump to type definition')
  set_lsp_keymap('r', vim.lsp.buf.references, '[c]ode - list all [r]eferences')
  set_lsp_keymap('s', vim.lsp.buf.signature_help, '[c]ode - show [s]ignature')
  require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
end)

--
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    'ts_ls',
    'lua_ls',
    'eslint',
    'jdtls',
  },
})

lsp_zero.default_setup()

lsp_config.lua_ls.setup({
    settings = {
        Lua = {
            diagnostics = {
                globals = {'vim'}
            }
        }
    }
})

lsp_config.smithy_ls.setup({})

lsp_config.jdtls.setup({})

lsp_config.ts_ls.setup({})
