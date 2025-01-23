-- Create group to assign commands
-- 'clear = true' must be set to prevent loading an
-- auto-command repeatedly every time a file is resourced
local autocmd_group = vim.api.nvim_create_augroup('Custom auto-commands', { clear = true })

vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  pattern = { '**.lua' },
  desc = 'format lua files after saving',
  callback = function()
    local fileName = vim.api.nvim_buf_get_name(0)
    vim.cmd(':silent :!stylua ' .. fileName)
  end,
  group = autocmd_group,
})

-- spellchecking
vim.api.nvim_create_autocmd({'BufRead','BufNewFile'}, {
  pattern = { '*.md' },
  callback = function()
      vim.opt.spell = true
  end,
  group = autocmd_group,
})
