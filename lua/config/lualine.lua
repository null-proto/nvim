
---@diagnostic disable-next-line: different-requires
local lualine = require 'lualine'
local color_pallet = require 'catppuccin.palettes.mocha'
local hydra = require 'hydra.statusline'

local colors = {
  normal_m = color_pallet.sapphire,
  insert_m = color_pallet.red,
  visual_m = color_pallet.teal,

  command_m = color_pallet.rosewater,
  replace_m = color_pallet.peach,

  bg1 = color_pallet.mantle,
  bg2 = color_pallet.surface0,

  black = color_pallet.crust,
  text_fg1 = color_pallet.text,
  text_fg2 = color_pallet.subtext1,
  text_fg3 = color_pallet.subtext0,
  text_fg4 = color_pallet.surface2,
  text_fg5 = color_pallet.surface1,
}

local line_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.normal_m },
    b = { fg = colors.text_fg1, bg = colors.bg2 },
    c = { fg = colors.text_fg1, bg = colors.bg1 },
  },

  insert = { a = { fg = colors.black, bg = colors.insert_m } },
  visual = { a = { fg = colors.black, bg = colors.visual_m } },
  replace = { a = { fg = colors.black, bg = colors.replace_m } },
  command = { a = { fg = colors.black, bg = colors.command_m } },
  inactive = {
    a = { fg = colors.text_fg1, bg = colors.black },
    b = { fg = colors.text_fg1, bg = colors.black },
    c = { fg = colors.text_fg1, bg = colors.bg1 },
  },
}

-- local function get_active_lsp()
-- 	local msg = ''
-- 	local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
-- 	local clients = vim.lsp.get_active_clients()
-- 	if next(clients) == nil then
-- 		return msg
-- 	end
-- 	for _, client in ipairs(clients) do
-- 		if client.config.filetypes and vim.fn.index(client.config.filetypes, buf_ft) ~= -1 then
-- 			return client.name
-- 		end
-- 	end
-- 	return '[' .. msg .. ']'
-- end

local function get_active_lsp()
  local buf_clients = vim.lsp.get_clients { bufnr = 0 }
  if next(buf_clients) == nil then
    return ''
  end

  local parts = {}
  for _, client in ipairs(buf_clients) do
    table.insert(parts, '[' .. client.name .. ']')
  end

  return table.concat(parts, ' ')
end

local function hydra_active()
  if hydra.is_active() then
    return ' '
  else
    return ''
  end
end

local function window()
  return vim.api.nvim_win_get_number(0)
end

local config = {
  options = {
    icons_enabled = true,
    theme = line_theme,
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    padding = 1,
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
  },

  sections = {
    lualine_a = { { 'mode', color = { gui = 'bold' } } },
    lualine_b = {
      { 'filetype', icon_only = true, padding = { left = 1, right = 0 } },
      { 'filename', padding = { left = 0, right = 1 } },
      { 'branch', icon = '' },
      { 'diff' },
    },

    lualine_c = {
      {
        'filesize',
        icon = '',
        color = { fg = colors.text_fg3 },
      },
      {
        hydra_active,
      },
      {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        symbols = { error = ' ', warn = ' ', info = '' },
        diagnostics_color = {
          error = { fg = color_pallet.red },
          warn = { fg = color_pallet.yellow },
          info = { fg = color_pallet.teal },
          hint = { fg = color_pallet.teal },
        },
      },
    },

    lualine_x = {
      {
        get_active_lsp,
        -- icon = '󱁤'
        fmt = function(a)
          return string.gsub(a, '_', '-')
        end,
        color = { fg = colors.text_fg4 },
      },
      {
        'fileformat',
        fmt = string.lower,
        icons_enabled = false,
        color = { fg = colors.text_fg3 },
      },
      { 'encoding', color = { fg = colors.text_fg3 } },
    },

    lualine_y = { { window, icon = '' }, 'progress' },
    lualine_z = {{
			'location',
			color = {
				bg = color_pallet.surface1,
				fg = color_pallet.text
			}
		}},
  },

  inactive_sections = {
    lualine_a = {},
    lualine_b = { 'filetype' },
    lualine_c = { 'filename', 'filesize' },
    lualine_x = { 'location' },
    lualine_y = { { window, icon = '' }, 'progress' },
    lualine_z = {},
  },

  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {},
}

lualine.setup(config)

--
-- local catppuchin_colors = {
-- 	rosewater = "#f5e0dc",
-- 	flamingo = "#f2cdcd",
-- 	pink = "#f5c2e7",
-- 	mauve = "#cba6f7",
-- 	red = "#f38ba8",
-- 	maroon = "#eba0ac",
-- 	peach = "#fab387",
-- 	yellow = "#f9e2af",
-- 	green = "#a6e3a1",
-- 	teal = "#94e2d5",
-- 	sky = "#89dceb",
-- 	sapphire = "#74c7ec",
-- 	blue = "#89b4fa"r
-- 	lavender = "#b4befe",
-- 	text = "#cdd6f4",
-- 	subtext1 = "#bac2de",
-- 	subtext0 = "#a6adc8",
-- 	overlay2 = "#9399b2",
-- 	overlay1 = "#7f849c",
-- 	overlay0 = "#6c7086",
-- 	surface2 = "#585b70",
-- 	surface1 = "#45475a",
-- 	surface0 = "#313244",
-- 	base = "#1e1e2e",
-- 	mantle = "#181825",
-- 	crust = "#11111b",
-- }
