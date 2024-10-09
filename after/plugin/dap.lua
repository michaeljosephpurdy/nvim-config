local dap, dapui = require('dap'), require('dapui')

-- Set keymaps to control the debugger
vim.keymap.set('n', '<F4>', dapui.toggle)
vim.keymap.set('n', '<F5>', dap.continue)
vim.keymap.set('n', '<F6>', dap.step_into)
vim.keymap.set('n', '<F7>', dap.step_over)
vim.keymap.set('n', '<F8>', dap.step_out)
vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint)
vim.keymap.set('n', '<leader>B', function()
  dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end)


for _, language in pairs({ 'typescript', 'javascript' }) do
  dap.configurations[language] = {
    type = "pwa-node",
    request = "launch",
    name = "debug",
    -- trace = true, -- include debugger info
    runtimeExecutable = "node",
    runtimeArgs = {
      "./node_modules/jest/bin/jest.js",
      "--runInBand",
    },
    rootPath = "${workspaceFolder}",
    cwd = "${workspaceFolder}",
    console = "integratedTerminal",
    internalConsoleOptions = "neverOpen",
  }
end

-- javascript debug
require('dap-vscode-js').setup({
  -- node_path = 'node', -- Path of node executable. Defaults to $NODE_PATH, and then 'node'
  debugger_path = '/Users/michpurd/.local/share/nvim/site/pack/packer/opt/vscode-js-debug', -- Path to vscode-js-debug installation.
  -- debugger_cmd = { 'extension' }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
  adapters = { 'chrome', 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost', 'node', 'chrome' }, -- which adapters to register in nvim-dap
  -- log_file_path = '(stdpath cache)/dap_vscode_js.log' -- Path for file logging
  -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
  -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
})

-- ui setup
dapui.setup()

dap.listeners.after.event_initialized['dapui_config'] = function()
    dapui.open({})
end
dap.listeners.before.event_terminated['dapui_config'] = function()
    dapui.close({})
end
dap.listeners.before.event_exited['dapui_config'] = function()
    dapui.close({})
end
