local function setup()
  local harpoon = require('harpoon')
  harpoon:setup()

  -- basic telescope configuration
  local conf = require('telescope.config').values
  local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
      table.insert(file_paths, item.value)
    end

    require('telescope.pickers')
      .new({}, {
        prompt_title = 'Harpoon',
        finder = require('telescope.finders').new_table({
          results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
      })
      :find()
  end

  vim.keymap.set('n', '<leader>ha', function()
    harpoon:list():add()
  end, { desc = 'Add file to harpoon'})

  vim.keymap.set('n', '<leader>hd', function()
    harpoon:list():remove()
  end, { desc = 'Remove file from harpoon'})

  vim.keymap.set('n', '<leader>hs', function()
    toggle_telescope(harpoon:list())
  end, { desc = 'Open harpoon window' })

  vim.keymap.set('n', '<leader>hl', function()
    harpoon:list():next({
      ui_nav_wrap = true,
    })
  end, { desc = 'Go to next harpooned buffer' })

  vim.keymap.set('n', '<leader>hh', function()
    harpoon:list():prev({
      ui_nav_wrap = true,
    })
  end, { desc = 'Go to previous harpooned buffer' })
end

setup()
