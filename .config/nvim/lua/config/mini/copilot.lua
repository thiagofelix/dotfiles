-- Module definition ==========================================================
local MiniCopilot = {}
local H = {}

H.statuses = {
  ['Detached'] = { icon = ' ', hl = 'ErrorMsg' },
  ['Normal'] = { icon = ' ', hl = 'CursorLine' },
  ['InProgress'] = { icon = ' ', hl = 'MoreMsg' },
  ['Warning'] = { icon = ' ', hl = 'WarningMsg' },
}

H.get_status = function()
  local client = require 'copilot.client'
  local api = require 'copilot.api'

  local status = not client.buf_is_attached(0) and 'Detached' or api.status.data.status == '' and 'Normal' or api.status.data.status

  return status
end

H.create_default_hl = function()
  local set_default_hl = function(name, data)
    data.default = true
    vim.api.nvim_set_hl(0, name, data)
  end

  -- Set default highlight groups links
  set_default_hl('MiniStatuslineCopilotDetached', { link = 'MiniStatuslineModeReplace' })
  set_default_hl('MiniStatuslineCopilotNormal', { link = 'MiniStatuslineDevinfo' })
  set_default_hl('MiniStatuslineCopilotInProgress', { link = 'MiniStatuslineModeInsert' })
  set_default_hl('MiniStatuslineCopilotWarning', { link = 'MiniStatuslineModeCommand' })
end

H.create_autocommands = function()
  -- Ensure colors
  vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = '*',
    callback = H.create_default_hl,
    desc = 'Ensure colors',
  })
end

H.register_status_notification_handler = function()
  -- Refresh statusline on status change
  require('copilot.api').register_status_notification_handler(function()
    vim.go.statusline = '%{%v:lua.MiniStatusline.active()%}'
  end)
end

MiniCopilot.setup = function()
  -- Export module
  _G.MiniCopilot = MiniCopilot

  -- Register listerner
  H.register_status_notification_handler()

  -- Define behavior
  H.create_autocommands()

  -- Create default highlighting
  H.create_default_hl()
end

MiniCopilot.section_copilot = function(args)
  if MiniStatusline.is_truncated(args.trunc_width) then
    return ''
  end

  local status = H.get_status()
  local item = H.statuses[status]

  return item.hl, item.icon
end

return MiniCopilot
