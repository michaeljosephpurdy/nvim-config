vim.cmd([[packadd packer.nvim]])

return require('packer').startup(function(use)
  -- Packer can manage itself
  use('wbthomason/packer.nvim')

  -- debugger
  use('mfussenegger/nvim-dap')
  -- javascript debugger, uses same DAP implementation as VSCode
  use('mxsdev/nvim-dap-vscode-js')
  use({
      'microsoft/vscode-js-debug',
      opt = true,
      run = 'npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out'
  })
  -- debugger ui
  use({"rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"}})

  -- neotest lets us run tests straight from vim
  use({'nvim-neotest/neotest',
    requires = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-neotest/neotest-jest',
    },
    config = function()
    require('neotest').setup({
      adapters = {
        require('neotest-jest')({
          jestCommand = "npm test --",
          jestConfigFile = "custom.jest.config.ts",
          env = { CI = true },
          cwd = function(path)
            return vim.fn.getcwd()
          end,
        }),
      }
    })
  end
  })

  -- telescope, provides fuzzyfinding
  use({
    'nvim-telescope/telescope.nvim',
    tag = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } },
  })

  use({
    'rose-pine/neovim',
    as = 'rose-pine',
  })
  vim.cmd.colorscheme('rose-pine')

  -- treesitter
  use({
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  })

  use({ 'ThePrimeagen/harpoon', branch = 'harpoon2', requires = { { 'nvim-lua/plenary.nvim' } } })

  use('mbbill/undotree')

  use('tpope/vim-fugitive')

  use({
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    requires = {
      --- Uncomment the two plugins below if you want to manage the language servers from neovim
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'L3MON4D3/LuaSnip' },
    },
  })

  if IS_ON_WORK_COMPUTER then
    use({
      "https://git.amazon.com/pkg/Scat-nvim",
      branch = "mainline",
      config = function()
          local map_key = vim.keymap.set
          local brazil = require("scat.brazil")
          local cr = require("scat.cr")
          local paste = require("scat.paste")
          local local_manager = require("scat.cr.local_manager")
          local brazil_utils = require'scat.brazil.utils'
          local scat = require"scat"
          scat.setup{
              cr = {
                  -- template_path = vim.fn.expandcmd"$HOME/<path_to_your_cr_template>",
                  -- user = "<your_user_name>" -- default user to be used when no user_id is provided to featch_active_crs
              }
          }
          map_key("n", "<leader>al", brazil.list_all_packages, { desc = "List All Packages" })
          map_key("n", "<leader>ap", brazil.display_current_package_url, { desc = "Display Current Package URL" })
          map_key("n", "<leader>aP", brazil.display_package_under_cursor_url, { desc = "Display URL for Package under Cursor" })
          map_key("n", "<leader>aR", brazil.display_release_under_cursor_url, { desc = "Display URL for Release under Cursor" })
          map_key({ "n", "x" }, "<leader>af", brazil.display_current_file_url, { desc = "Display Current File URL" })
          map_key("n", "<leader>aij", brazil.install_current_jdt_package, { desc = "Install Current JDT Package" })
          map_key("n", "<leader>ar", cr.open_cr, { desc = "Open CR" })
          -- or map_key("n", "<leader>ar", function() cr.open_cr({ cr_template = vim.fn.expandcmd"$HOME/<path_to_your_cr_template>" }) end, { desc = "Open CR" })
          map_key("n", "<leader>arp", cr.fetch_active_crs, { desc = "Fetch Active CRs" })
          -- the below mapping prompts for user id you would like to view instead of picking from config
          map_key("n", "<leader>arpp", function() cr.fetch_active_crs({ force_pick = true }) end, { desc = "Fetch Active CRs (ignore user specified in config)" })
          -- or map_key("n", "<leader>arp", function() cr.fetch_active_crs({user = "<your_user_name>"}) end)
          map_key("n", "<leader>aru", cr.update_existing_cr, { desc = "Update Existing CR" })
          map_key("n", "<leader>art", local_manager.toggle_cr_overview, { desc = "Toggle CR Overview" })
          map_key("n", "<leader>ac", brazil_utils.run_checkstyle, { desc = "Run Brazil Checkstyle" })
          map_key('n', '<leader>ab', brazil.build_current_package, { desc = "Build Current Package" })
          map_key('n', '<leader>abc', brazil.run_command_inside_current_package, { desc = "Run Brazil Command inside Current Package" })
          map_key("n", "<leader>abt", function()
              brazil.pick_brazil_task_inside_current_package({
                  callback = function(task)
                      vim.g.test_replacement_command = task
                  end,
              })
          end, { desc = "Pick Brazil Task inside Current Package" })
          map_key('n', '<leader>abl', brazil.run_prev_brazil_task, { desc = "Run Previous Brazil Task" })
          map_key('n', '<leader>av', brazil.display_current_version_set_url, { desc = "Display Current Version Set URL" })
          map_key('n', '<leader>abr', brazil.build_current_package_recursively, { desc = "Build Current Package Recursively" })
          map_key('n', '<leader>aw', brazil.switch_workspace_package_info, { desc = "Switch packageInfo in Current Workspace" })
          map_key({ 'n', 'x' }, '<leader>as', paste.send_to_pastebin, { desc = "Send Selection to Pastebin" })
          map_key('n', '<leader>asl', paste.list_my_pastes, { desc = "List My Pastes" })
          map_key('n', '<leader>ais', brazil.lookup_packages, { desc = "Lookup Packages" })
          -- if you are using the patched fork of Telescope, you can also leverage these, see more details below
          -- map_key('n', '<leader>aiv', brazil.lookup_version_set, { desc = "Lookup Version Set" })
      end,
      requires = { "nvim-telescope/telescope.nvim", "sindrets/diffview.nvim" },
    })
  end
end)
