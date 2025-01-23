-- global vim
vim.g.mapleader = ' '

local insert_mode = {
  -- fix escape mappings
  { '<ESC>', '' },
  { 'jj', '<ESC>' },
}

local normal_mode = {
  -- disable q: because I always hit it by accident
  { 'q:', '' },
  -- fix escape mappings
  { '<ESC>', '' },
  { '<Space><Space>', '<ESC>' },
  { '<leader>ee', ':lua vim.diagnostic.open_float()<Enter>' },
  { '<leader>en', ':lua vim.diagnostic.goto_next()<Enter>' },
  { '<leader>ep', ':lua vim.diagnostic.goto_prev()<Enter>' },
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
  -- split manipulation
  { '<Leader>we', ':vsplit<Enter>' }, -- vertical split
  { '<Leader>ww', ':split<Enter>' }, -- horizontal split
  { '<Leader>wk', '<C-w>k' }, -- move up
  { '<Leader>wj', '<C-w>j' }, -- move down
  { '<Leader>wh', '<C-w>h' }, -- move left
  { '<Leader>wl', '<C-w>l' }, -- move right
  { '<Leader>wq', '<C-w>c' }, -- close splitting
  -- spellcheck
  { '<Leader>sp', '[s' }, -- previous wrong word
  { '<Leader>sn', ']s' }, -- next wrong word
  { '<Leader>sf', 'z=' }, -- fix wrong word
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
