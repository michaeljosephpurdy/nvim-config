local telescope = require('telescope')
local builtin = require('telescope.builtin')
local layout = {
    width = function(_, max_columns, _)
        return math.min(max_columns, 120)
      end,
    height = function(_, _, max_lines)
        return math.min(max_lines, 20)
      end,
  }
telescope.setup({
  pickers = {
    find_files = {
      theme = "dropdown",
      layout_config = layout,
    },
    live_grep = {
      theme = 'dropdown',
      layout_config = layout,
    },
  },
})
vim.keymap.set('n', '<leader>ea', builtin.diagnostics, { bufnr = nil })
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {

})
vim.keymap.set('n', '<leader>fh', builtin.git_files, {})
vim.keymap.set('n', '<leader>fs', function()
  builtin.grep_string({ search = vim.fn.input('Grep > ') })
end)
