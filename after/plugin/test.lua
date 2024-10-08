local neotest = require('neotest')

vim.keymap.set('n', '<Leader>tn', function()
    neotest.run.run()
end, { desc = 'test nearest test'})

vim.keymap.set('n', '<Leader>tdn', function()
    neotest.run.run({strategy = 'dap'})
end, { desc = 'debug nearest test'})

vim.keymap.set('n', '<Leader>tf', function()
    neotest.run.run(vim.fn.expand('%'))
end, { desc = 'test entire file'})

vim.keymap.set('n', '<Leader>ts', function()
    neotest.summary()
end, { desc = 'show test summary'})

