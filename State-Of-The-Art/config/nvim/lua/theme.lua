---Returns the color set by the current colorscheme for the `attr` attribute of
---the `hlgroup_name` highlight group in hexadecimal format.
---@param hlgroup_name  string
---@param attr  '"fg"' | '"bg"'
---@return string
local get_hex = function(hlgroup_name, attr)
  local hlgroup_ID = vim.fn.synIDtrans(vim.fn.hlID(hlgroup_name))
  local hex        = vim.fn.synIDattr(hlgroup_ID, attr)
  return hex ~= "" and hex or "NONE"
end

-- TODO: discover what this command means.
vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function() vim.api.nvim_set_hl(…) end,
  group = vim.api.nvim_create_augroup('config', {clear = false}),
  pattern = 'highlite',
})

-- Allow transparency.
vim.opt.termguicolors = true

-- Setting our theem set.
-- 1. 'light' for white theme.
-- 2. 'dark' for dark theme.
vim.api.nvim_set_option('background', 'dark')

-- Set colorscheme theme.
vim.cmd.colorscheme'arcoiris'

-- Color table for highlights
-- stylua: ignore
COLOUR = {
  bg            = get_hex("StatusLine", "bg"),
  fg            = get_hex("Comment", "fg"),
  bar_bg        = get_hex("VisualNOS", "bg"),
  bar           = get_hex("CursorLineNR", "bg"),
  bold          = get_hex("NavicBold", "fg"),
  yellow        = get_hex("PreProc", "fg"),
  cyan          = get_hex("Repeat", "fg"),
  darkblue      = get_hex("FoldColumn", "fg"),
  green         = get_hex("Operator", "fg"),
  orange        = get_hex("Constant", "fg"),
  violet        = get_hex("Note", "bg"),
  magenta       = get_hex("Note", "bg"),
  blue          = get_hex("Macro", "fg"),
  dark_yellow   = get_hex("Boolean", "fg"),
  light_green   = get_hex("TodoDONE", "fg"),
  string_orange = get_hex("NeoTreeGitConflict", "fg"),
  purple        = get_hex("String", "fg"),
  grey          = get_hex("Visual", "bg"),
  vivid_blue    = get_hex("markdownH4", "fg"),
  light_blue    = get_hex("Statement", "fg"),
  error_red     = get_hex("NavicRed", "fg"),
  info_yellow   = get_hex("NavicYellow", "fg"),
  bg_light      = get_hex("VertSplit", "fg"),
  bg_cursor     = get_hex("CursorColumn", "bg"),
  gray          = get_hex("SpecialComment", "fg"),

  -- LSP
  error       = get_hex('DiagnosticError', 'fg'),
  warning     = get_hex('DiagnosticWarn', 'fg'),
  information = get_hex("DiagnosticInfo", "fg"),
  hint        = get_hex("DiagnosticHint", "fg"),
  add         = get_hex("DiffAdd", "fg"),
  change      = get_hex("DiffChange", "fg"),
  red         = get_hex("DiffDelete", "fg"),

  -- General.
  comment    = get_hex('Comment', 'fg'),
  ignore     = get_hex('Ignore', 'fg'),
  --delimeter  = get_hex('Delimeter', 'fg'),
  operator   = get_hex('Operator', 'fg'),
  background = get_hex('VertSplit', 'bg'),
  tabfill    = get_hex('TabLineFill', 'bg'),
  msgarea    = get_hex('MsgArea', 'bg'),
}
