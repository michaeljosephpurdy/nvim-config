local function bemol()
  local bemol_dir = vim.fs.find({ '.bemol' }, { upward = true, type = 'directory' })[1]
  if not bemol_dir then
      return
  end

  local ws_folders_lsp = vim.lsp.buf.list_workspace_folders()

  local file = io.open(bemol_dir .. '/ws_root_folders', 'r')
  if file then
    for line in file:lines() do
      table.insert(ws_folders_lsp, line)
    end
    file:close()
  end

  for _, folder in ipairs(ws_folders_lsp) do
    vim.lsp.buf.add_workspace_folder(folder)
  end
end

if IS_ON_WORK_COMPUTER then
  bemol()
end
