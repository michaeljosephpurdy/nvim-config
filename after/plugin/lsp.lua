local lsp_zero = require('lsp-zero')

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
  handlers = {
    ["lua_ls"] = function ()
        require('lspconfig').lua_ls.setup({
            settings = {
                Lua = {
                    diagnostics = {
                        globals = {'vim'}
                    }
                }
            }
        })
    end,
    ['jdtls'] = function()
    end,
    ['ts_ls'] = function()
      lsp_zero.default_setup()
    end,
    function (server_name) -- default handler (optional)
      lsp_zero.default_setup()
    end,
  },
})

require('lspconfig').jdtls.setup({
})

require('lspconfig').ts_ls.setup({
    lsp_zero.default_setup()
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
  sources = {
    { name = 'path' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'luasnip', keyword_length = 2 },
    { name = 'buffer', keyword_length = 3 },
  },
  formatting = lsp_zero.cmp_format({ details = false }),
  mapping = cmp.mapping.preset.insert({
    ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
})
