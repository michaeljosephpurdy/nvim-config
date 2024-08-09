---@param color? string
function set_colorscheme(color)
  color = color or 'rose-pine'
  vim.cmd.colorscheme(color)
end
set_colorscheme()
