local scope = 'focus'
local indent = 'passive'
local cmp = require 'cmp'
local hooks = require 'ibl.hooks'
local npairs = require 'nvim-autopairs'
local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, 'focus', { fg = '#6f6f8f' })
  vim.api.nvim_set_hl(0, 'passive', { fg = '#41425e' })
end)

require('ibl').setup {
  scope = { highlight = scope },
  indent = { highlight = indent },
}

-- require('smear_cursor').setup()

require('colorizer').setup {
  filetypes = { '*' },
  user_default_options = {
    RGB = true, -- #RGB hex codes
    RRGGBB = true, -- #RRGGBB hex codes
    names = false, -- "Name" codes like Blue or blue
    RRGGBBAA = true, -- #RRGGBBAA hex codes
    AARRGGBB = true, -- 0xAARRGGBB hex codes
    rgb_fn = true, -- CSS rgb() and rgba() functions
    hsl_fn = true, -- CSS hsl() and hsla() functions
    css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
    -- Available modes for `mode`: foreground, background,  virtualtext
    mode = 'background', -- Set the display mode.
    -- Available methods are false / true / "normal" / "lsp" / "both"
    -- True is same as normal
    tailwind = true, -- Enable tailwind colors
    -- parsers can contain values used in |user_default_options|
    sass = { enable = true, parsers = { 'css' } }, -- Enable sass colors
    virtualtext = '■',
    -- update color values even if buffer is not focused
    -- example use: cmp_menu, cmp_docs
    always_update = false,
  },
  -- all the sub-options of filetypes apply to buftypes
  buftypes = {},
}

-- cmp.event:on(
--   'confirm_done',
--   cmp_autopairs.on_confirm_done()
-- )

npairs.setup { map_cr = true }
