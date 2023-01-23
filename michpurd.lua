local michpurd = {}

local function isOnWorkComputer()
  local hostname = vim.fn.hostname()
  local i, _ = string.find(hostname, 'amazon.com')
  return i ~= nil
end

local function isOnDevDesktop()
  local hostname = vim.fn.hostname()
  local i, _ = string.find(hostname, 'us-east-1.amazon.com')
  return i ~= nil
end


function michpurd.load()
  if not isOnWorkComputer() then
    return
  end
  if isOnDevDesktop() then
    vim.o.colorscheme = 'slate'
  end
end

return michpurd
