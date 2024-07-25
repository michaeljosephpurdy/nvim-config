local function isOnWorkComputer()
  local hostname = vim.fn.hostname()
  local i, _ = string.find(hostname, 'amazon.com')
  return i ~= nil
end

IS_ON_WORK_COMPUTER = isOnWorkComputer()

require('purdy')
