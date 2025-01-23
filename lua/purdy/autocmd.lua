-- Create group to assign commands
-- 'clear = true' must be set to prevent loading an
-- auto-command repeatedly every time a file is resourced
local autocmd_group = vim.api.nvim_create_augroup('Custom auto-commands', { clear = true })

-- Auto-formatting Lua files using `stylua`
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  pattern = { '**.lua' },
  desc = 'format lua files after saving',
  callback = function()
    local fileName = vim.api.nvim_buf_get_name(0)
    vim.cmd(':silent :!stylua ' .. fileName)
  end,
  group = autocmd_group,
})

-- Autoset some nice-to-have options for Markdown
vim.api.nvim_create_autocmd({'BufRead','BufNewFile'}, {
  pattern = { '*.md' },
  callback = function()
      vim.opt.spell = true
      vim.opt.wrap = true
  end,
  group = autocmd_group,
})
