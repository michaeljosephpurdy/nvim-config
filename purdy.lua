local purdy = {}

function purdy.load()
  vim.keymap.set('i', 'jj', '<Esc>', { silent = true })
end

return purdy
