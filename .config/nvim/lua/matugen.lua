 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#000000',
    base01 = '#000000',
    base02 = '#070707',
    base03 = '#726983',
    base04 = '#ffffff',
    base05 = '#ffffff',
    base06 = '#ffffff',
    base07 = '#ffffff',
    base08 = '#c01c28',
    base09 = '#ffffff',
    base0A = '#1b467c',
    base0B = '#3584e4',
    base0C = '#e99696',
    base0D = '#8fbbf0',
    base0E = '#96bbe9',
    base0F = '#bed6f4',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#ffffff',          bg = '#000000' })
  hi('TelescopeBorder',         { fg = '#726983',             bg = '#000000' })
  hi('TelescopePromptNormal',   { fg = '#ffffff',          bg = '#000000' })
  hi('TelescopePromptBorder',   { fg = '#726983',             bg = '#000000' })
  hi('TelescopePromptPrefix',   { fg = '#3584e4',             bg = '#000000' })
  hi('TelescopePromptCounter',  { fg = '#ffffff',  bg = '#000000' })
  hi('TelescopePromptTitle',    { fg = '#000000',             bg = '#3584e4' })
  hi('TelescopePreviewTitle',   { fg = '#000000',             bg = '#1b467c' })
  hi('TelescopeResultsTitle',   { fg = '#000000',             bg = '#ffffff' })
  hi('TelescopeSelection',      { fg = '#ffffff',          bg = '#070707' })
  hi('TelescopeSelectionCaret', { fg = '#3584e4',             bg = '#070707' })
  hi('TelescopeMatching',       { fg = '#3584e4',             bold = true })
end

-- Register a signal handler for SIGUSR1 (matugen updates).
-- The handler re-requires this module, which re-runs the code below, so the
-- previous handle is stopped first; otherwise handlers double on every signal.
if _G.__matugen_signal then
  _G.__matugen_signal:stop()
  _G.__matugen_signal:close()
end

local signal = vim.uv.new_signal()
_G.__matugen_signal = signal
signal:start(
  'sigusr1',
  vim.schedule_wrap(function()
    package.loaded['matugen'] = nil
    require('matugen').setup()
  end)
)

return M
