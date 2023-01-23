local purdy = {}

function purdy.load()
  vim.keymap.set('i', 'jj', '<Esc>', { silent = true })
  -- since `j` is used to go down when in visual mode, use double space to exit
  vim.keymap.set('v', '<Space><Space>', '<Esc>', { silent = true })

  -- set Escape key to nothing, to enforce its deprecation
  vim.keymap.set('i', '<Esc>', '', { silent = true })
  vim.keymap.set('v', '<Esc>', '', { silent = true })

  -- esure cursor is in center line
  vim.o.scrolloff = 9999
end

return purdy
