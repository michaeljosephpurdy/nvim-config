local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ea', builtin.diagnostics, { bufnr = nil })
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {

})
vim.keymap.set('n', '<leader>fh', builtin.git_files, {})
vim.keymap.set('n', '<leader>fs', function()
  builtin.grep_string({ search = vim.fn.input('Grep > ') })
end)
