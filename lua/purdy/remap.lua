-- global vim
vim.g.mapleader = ' '

local insert_mode = {
  -- fix escape mappings
  { '<ESC>', '' },
  { 'jj', '<ESC>' },
}

local normal_mode = {
  -- fix escape mappings
  { '<ESC>', '' },
  { '<Space><Space>', '<ESC>' },
  -- open up netrw
  { '<Leader>pv', vim.cmd.Ex },
  -- keep focus in middle of buffer when going through search results
  { 'n', 'nzzzv' },
  { 'N', 'Nzzzv' },
  -- yank this line to system clipboard
  { '<Leader>y', 'V"*y' },
  -- copy entire file
  { '<Leader>Y', 'ggVG"*y' },
  -- paste from system clipboard
  { '<Leader>p', '"*P' },
}

local visual_mode = {
  -- fix escape mappings
  { '<ESC>', '' },
  { '<Space><Space>', '<ESC>' },
  -- move selected lines up and down
  { 'J', ":m '>+1<CR>gv=gv" },
  { 'K', ":m '<-2<CR>gv=gv" },
  -- yank selection to system clipboard
  { '<Leader>y', '"*y' },
}

for _, entry in ipairs(insert_mode) do
  vim.keymap.set('i', entry[1], entry[2])
end

for _, entry in ipairs(normal_mode) do
  vim.keymap.set('n', entry[1], entry[2])
end

for _, entry in ipairs(visual_mode) do
  vim.keymap.set('v', entry[1], entry[2])
end
