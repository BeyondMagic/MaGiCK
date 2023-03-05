-- Minimise code.
local set = vim.api.nvim_set_var

-- All possible highlighters
set('Hexokinase_highlighters', {
  'virtual',
  'sign_column',
  'background',
  'backgroundfull',
--  'foreground',
--  'foregroundfull'
})

-- Patterns to match for all filetypes
-- Can be a comma separated string or a list of strings

-- All possible values
set('Hexokinase_optInPatterns', {
  'full_hex',
  'triple_hex',
  'rgb',
  'rgba',
  'hsl',
  'hsla',
  'colour_names'
})

-- Filetype specific patterns to match
-- entry value must be comma seperated list
set('Hexokinase_ftOptInPatterns', {
  css  = 'full_hex,rgb,rgba,hsl,hsla,colour_names',
  html = 'full_hex,rgb,rgba,hsl,hsla,colour_names'
})

-- Sample value, to keep default behaviour don't define this', variable
set('Hexokinase_ftEnabled', { 'css', 'html', 'javascript' })

-- Turn the colors on.
vim.cmd('au BufEnter * HexokinaseTurnOn')
