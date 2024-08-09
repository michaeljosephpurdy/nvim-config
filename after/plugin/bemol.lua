local function bemol()
  local bemol_dir = vim.fs.find({ '.bemol' }, { upward = true, type = 'directory' })[1]
  if not bemol_dir then
    return
  end

  -- bemol_package_folders is a file (`${workspace_directory}./bemol/ws_root_folders`)
  -- that is a line-deliminated list of paths to bemol packages.
  -- example:
  -- michpurd@147dda118716 .bemol % cat /Users/michpurd/workplace/tuff/validators/.bemol/ws_root_folders
  -- /Users/michpurd/workplace/tuff/validators/src/D16GTuffCreativeValidators
  local bemol_package_folders = io.open(bemol_dir .. '/ws_root_folders', 'r')
  if not bemol_package_folders then
    return
  end

  -- We only want to add folders **if they are not already in the lsp workspace list**
  local new_bemol_packages = {}
  for new_folder in bemol_package_folders:lines() do
    for current_folder in pairs(vim.lsp.buf.list_workspace_folders()) do
      if current_folder ~= new_folder then
        table.insert(new_bemol_packages, new_folder)
      end
    end
  end
  bemol_package_folders:close()

  for _, folder in ipairs(new_bemol_packages) do
    vim.lsp.buf.add_workspace_folder(folder)
  end
end

if IS_ON_WORK_COMPUTER then
  bemol()
end
